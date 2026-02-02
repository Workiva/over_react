/// Environment configuration utility for deployment environments.
///
/// Supports multiple deployment environments including prod-ca.
library over_react.util.environment_config;

import 'dart:html' as html;

/// Enumeration of supported deployment environments.
enum DeploymentEnvironment {
  /// Production environment (US)
  prod,

  /// Production environment (Canada)
  prodCa,

  /// Staging environment
  staging,

  /// Development environment
  dev,

  /// QA environment
  qa,
}

/// Configuration for a deployment environment.
class EnvironmentConfig {
  /// The environment name.
  final DeploymentEnvironment environment;

  /// The base URL for this environment.
  final String baseUrl;

  /// The API base URL (defaults to baseUrl if not specified).
  final String? apiBaseUrl;

  /// The authentication/identity endpoint URL.
  final String? authEndpoint;

  /// Whether this is a production environment.
  bool get isProduction =>
      environment == DeploymentEnvironment.prod ||
      environment == DeploymentEnvironment.prodCa;

  const EnvironmentConfig({
    required this.environment,
    required this.baseUrl,
    this.apiBaseUrl,
    this.authEndpoint,
  });

  /// Gets the API base URL, falling back to baseUrl if not specified.
  String get effectiveApiBaseUrl => apiBaseUrl ?? baseUrl;

  /// Gets the authentication endpoint URL, falling back to a default if not specified.
  String get effectiveAuthEndpoint =>
      authEndpoint ?? '$effectiveApiBaseUrl/auth';
}

/// Environment configuration manager.
class EnvironmentManager {
  static EnvironmentManager? _instance;
  static EnvironmentManager get instance =>
      _instance ??= EnvironmentManager._();

  EnvironmentManager._();

  /// Current environment configuration.
  EnvironmentConfig? _currentConfig;

  /// Gets the current environment configuration.
  ///
  /// Detects the environment from the current hostname if not explicitly set.
  EnvironmentConfig getCurrentConfig() {
    if (_currentConfig != null) {
      return _currentConfig!;
    }

    return _detectEnvironmentFromHostname();
  }

  /// Sets the current environment configuration explicitly.
  void setEnvironment(EnvironmentConfig config) {
    _currentConfig = config;
  }

  /// Detects the environment from the current browser hostname.
  EnvironmentConfig _detectEnvironmentFromHostname() {
    final hostname = html.window.location.hostname?.toLowerCase() ?? '';

    // Check for prod-ca environment
    if (hostname.contains('ca.wdesk.com') || hostname == 'ca.wdesk.com') {
      return _getConfigForEnvironment(DeploymentEnvironment.prodCa);
    }

    // Check for other environments
    if (hostname.contains('.wdesk.com')) {
      if (hostname.contains('staging') || hostname.contains('stage')) {
        return _getConfigForEnvironment(DeploymentEnvironment.staging);
      }
      if (hostname.contains('dev') || hostname.contains('local')) {
        return _getConfigForEnvironment(DeploymentEnvironment.dev);
      }
      if (hostname.contains('qa')) {
        return _getConfigForEnvironment(DeploymentEnvironment.qa);
      }
      // Default to prod for *.wdesk.com domains
      return _getConfigForEnvironment(DeploymentEnvironment.prod);
    }

    // Default to dev for localhost or unknown domains
    return _getConfigForEnvironment(DeploymentEnvironment.dev);
  }

  /// Gets the configuration for a specific environment.
  EnvironmentConfig _getConfigForEnvironment(DeploymentEnvironment env) {
    switch (env) {
      case DeploymentEnvironment.prodCa:
        return const EnvironmentConfig(
          environment: DeploymentEnvironment.prodCa,
          baseUrl: 'https://ca.wdesk.com',
          apiBaseUrl: 'https://ca.wdesk.com/api',
          authEndpoint: 'https://ca.wdesk.com/auth',
        );

      case DeploymentEnvironment.prod:
        return const EnvironmentConfig(
          environment: DeploymentEnvironment.prod,
          baseUrl: 'https://www.wdesk.com',
          apiBaseUrl: 'https://www.wdesk.com/api',
          authEndpoint: 'https://www.wdesk.com/auth',
        );

      case DeploymentEnvironment.staging:
        return const EnvironmentConfig(
          environment: DeploymentEnvironment.staging,
          baseUrl: 'https://staging.wdesk.com',
          apiBaseUrl: 'https://staging.wdesk.com/api',
          authEndpoint: 'https://staging.wdesk.com/auth',
        );

      case DeploymentEnvironment.dev:
        return const EnvironmentConfig(
          environment: DeploymentEnvironment.dev,
          baseUrl: 'http://localhost:8080',
          apiBaseUrl: 'http://localhost:8080/api',
          authEndpoint: 'http://localhost:8080/auth',
        );

      case DeploymentEnvironment.qa:
        return const EnvironmentConfig(
          environment: DeploymentEnvironment.qa,
          baseUrl: 'https://qa.wdesk.com',
          apiBaseUrl: 'https://qa.wdesk.com/api',
          authEndpoint: 'https://qa.wdesk.com/auth',
        );
    }
  }

  /// Gets the current environment.
  DeploymentEnvironment getCurrentEnvironment() =>
      getCurrentConfig().environment;

  /// Checks if the current environment is production (including prod-ca).
  bool get isProduction => getCurrentConfig().isProduction;

  /// Gets the current base URL.
  String getCurrentBaseUrl() => getCurrentConfig().baseUrl;

  /// Gets the current API base URL.
  String getCurrentApiBaseUrl() => getCurrentConfig().effectiveApiBaseUrl;

  /// Gets the current authentication endpoint URL.
  String getCurrentAuthEndpoint() => getCurrentConfig().effectiveAuthEndpoint;
}

/// Global instance accessor for convenience.
EnvironmentManager get environmentManager => EnvironmentManager.instance;

/// Gets the current environment configuration.
EnvironmentConfig getCurrentEnvironmentConfig() =>
    environmentManager.getCurrentConfig();

/// Gets the current deployment environment.
DeploymentEnvironment getCurrentEnvironment() =>
    environmentManager.getCurrentEnvironment();

/// Checks if the current environment is production.
bool get isProductionEnvironment => environmentManager.isProduction;

/// Gets the current base URL.
String getCurrentBaseUrl() => environmentManager.getCurrentBaseUrl();

/// Gets the current API base URL.
String getCurrentApiBaseUrl() => environmentManager.getCurrentApiBaseUrl();

/// Gets the current authentication endpoint URL.
String getCurrentAuthEndpoint() => environmentManager.getCurrentAuthEndpoint();
