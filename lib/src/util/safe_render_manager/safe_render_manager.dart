// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:w_common/disposable.dart';

import './safe_render_manager_helper.dart';

/// A class that manages the top-level rendering of a [ReactElement] into a given node,
/// with support for safely rendering/updating via [render] and safely unmounting via [tryUnmount].
///
/// Content is also unmounted when this object is [dispose]d.
///
/// This is useful in cases where [react_dom.render] or [react_dom.unmountComponentAtNode]
/// may or may not be called from React events or lifecycle methods, which can have
/// undesirable/unintended side effects.
///
/// For instance, calling [react_dom.unmountComponentAtNode] can unmount a component
/// while an event is being propagated through a component, which normally would never happen.
/// This could result in null errors in the component as the event logic continues.
///
/// SafeRenderManager uses a helper component under the hood to manage the rendering of content
/// via Component state changes, ensuring that the content is mounted/unmounted as it
/// normally would be.
class SafeRenderManager extends Disposable {
  SafeRenderManagerHelperComponent? _helper;

  /// Whether to automatically add [mountNode] to the document body when
  /// rendered, and remove it when unmounted.
  ///
  /// Useful when manually managing the mount node isn't necessary.
  final bool autoAttachMountNode;

  /// The mount node for content rendered by [render].
  ///
  /// If not specified, a new div will be used.
  final Element mountNode;

  /// The ref to the component rendered by [render].
  ///
  /// Due to react_dom.render calls not being guaranteed to be synchronous.
  /// this may not be populated until later than expected.
  dynamic contentRef;

  _RenderState _state = _RenderState.unmounted;

  /// A list of [render] calls queued up while the component is in the process
  /// of rendering.
  List<ReactElement?> _renderQueue = [];

  SafeRenderManager({Element? mountNode, this.autoAttachMountNode = false})
      : mountNode = mountNode ?? DivElement();

  /// Renders [content] into [mountNode], chaining existing callback refs to
  /// provide access to the rendered component via [contentRef].
  void render(ReactElement? content) {
    _checkDisposalState();

    switch (_state) {
      case _RenderState.mounting:
        _renderQueue.add(content);
        break;
      case _RenderState.mountedOrErrored:
        // Handle if _helper was unmounted due to an uncaught error.
        if (_helper == null) {
          _mountContent(content);
        } else {
          _helper!.renderContent(content);
        }
        break;
      case _RenderState.unmounted:
        _mountContent(content);
        break;
    }
  }

  void _mountContent(ReactElement? content) {
    try {
      _state = _RenderState.mounting;
      // Use document.contains since `.isConnected` isn't supported in IE11.
      if (autoAttachMountNode && !document.contains(mountNode)) {
        document.body!.append(mountNode);
      }
      react_dom.render((SafeRenderManagerHelper()
        ..ref = _helperRef
        ..getInitialContent = () {
          final value = content;
          // Clear this closure variable out so it isn't retained.
          content = null;
          return value;
        }
        ..contentRef = _contentCallbackRef
      )(), mountNode);
    } catch (_) {
      _state = _RenderState.unmounted;
      rethrow;
    }
  }

  /// Attempts to unmount the rendered component, calling [onMaybeUnmounted]
  /// with whether the component was actually unmounted.
  ///
  /// Unmounting could fail if a call to [render] is batched in with this
  /// unmount during the propagation of this event. In that case, some
  /// other call wanted something rendered and trumped the unmount request.
  ///
  /// This behavior allows the same SafeRenderManager instance to be used to
  /// render/unmount a single content area without calls interfering with each
  /// other.
  ///
  /// If nothing is currently rendered, [onMaybeUnmounted] will be called immediately.
  void tryUnmount({void Function(bool isUnmounted)? onMaybeUnmounted}) {
    // Check here since we call _tryUnmountContent in this class's disposal logic.
    _checkDisposalState();
    _safeUnmountContent(onMaybeUnmounted: onMaybeUnmounted, force: false);
  }

  void _unmountContent() {
    try {
      _state = _RenderState.unmounted;
      _renderQueue = [];
      react_dom.unmountComponentAtNode(mountNode);
    } finally {
      if (autoAttachMountNode) {
        mountNode.remove();
      }
    }
  }

  void _safeUnmountContent(
      {void Function(bool isUnmounted)? onMaybeUnmounted, required bool force}) {
    var _hasBeenCalled = false;
    /// Helper to call onMaybeUnmounted at most one time, for cases
    /// where there have to be error handlers at multiple levels
    void callOnMaybeUnmounted(bool value) {
      if (!_hasBeenCalled) {
        _hasBeenCalled = true;
        onMaybeUnmounted?.call(true);
      }
    }

    if (_state == _RenderState.unmounted) {
      callOnMaybeUnmounted(true);
    } else if (_state == _RenderState.mountedOrErrored && _helper != null) {
      try {
        _helper!.tryUnmountContent(onMaybeUnmounted: (isUnmounted) {
          if (isUnmounted || force) {
            try {
              _unmountContent();
            } finally {
              callOnMaybeUnmounted(true);
            }
          } else {
            callOnMaybeUnmounted(false);
          }
        });
      } catch (_) {
        // Handle _helper.tryUnmountContent throwing synchronously without
        // calling onMaybeUnmounted.
        // Don't do this in a finally since onMaybeUnmounted can get called async.
        callOnMaybeUnmounted(true);
        rethrow;
      }
    } else {
      try {
        _unmountContent();
      } finally {
        callOnMaybeUnmounted(true);
      }
    }
  }

  void _checkDisposalState() {
    if (isOrWillBeDisposed) {
      throw ObjectDisposedException();
    }
  }

  void _helperRef(SafeRenderManagerHelperComponent? ref) {
    _helper = ref;
    if (_helper != null) {
      if (_state == _RenderState.mounting) {
        _state = _RenderState.mountedOrErrored;
      }
      _renderQueue.forEach(_helper!.renderContent);
      _renderQueue = [];
    }
  }

  void _contentCallbackRef(ref) {
    contentRef = ref;
  }

  @override
  Future<Null> onDispose() async {
    Completer<Null>? completer = Completer<Null>();
    final completerFuture = completer.future;

    // Set up an onError handler in case onMaybeUnmounted isn't called due to
    // an error, and an async error is thrown instead.
    runZonedGuarded(() {
      // Attempt to unmount the content safely
      _safeUnmountContent(force: true, onMaybeUnmounted: (_) {
        completer?.complete();
        // Clear out to not retain it in the onError closure, which has
        // an indefinitely long lifetime.
        completer = null;
      });
    }, (error, stackTrace) {
      completer?.completeError(error, stackTrace);
      // Clear out to not retain it in the onError closure, which has
      // an indefinitely long lifetime.
      completer = null;
    });

    await completerFuture;

    await super.onDispose();
  }
}

enum _RenderState { mounting, mountedOrErrored, unmounted }
