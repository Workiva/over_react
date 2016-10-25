var gaSourceCodeViewPath = '/over_react/demos/source/';

function handleGaHashLinkClick(hash) {
    initGaPath(hash);
    ga('send', 'pageview');
}

function gaLinkHandler(action, label, isAffiliated, page) {
    // For one reason or another, analytics was not loaded onto the page
    if (!ga) return;

    isAffiliated = isAffiliated || false;

    var evCategory = 'External Link';

    if (isAffiliated) {
        evCategory += ': Affiliated';
    } else {
        evCategory += ': 3rd Party';
    }

    // Track as an event
    ga('send', 'event', evCategory, action, label);

    // Track as pageview if the "external" location is directly
    // related to our library (e.g. click to go to gh repo, click to go to dartdocs, etc.)
    if (isAffiliated) {
        page = page || label;
        ga('send', 'pageview', page);
    }
}

// These link clicks take the user to a 3rd party location, unaffiliated with over_react.
function handleExternalClick(action, label) {
    gaLinkHandler(action, label, false);
}

// These link clicks take the user to a different domain, but one that
// we wish we could track with ga as part of the github.io site...
function handleAffiliatedClick(action, label, page) {
    gaLinkHandler(action, label, true, page);
}

function handleSourceCodeView(componentName) {
    handleAffiliatedClick('View Source Code', componentName, gaSourceCodeViewPath + componentName);
}

function handleBsExternalClick() {
    try {
        var linkText = arguments.callee.caller.arguments[0].target.innerText;

        handleExternalClick("Click: Hero", linkText);
    } catch (err) {
        handleExternalClick("Click: Hero", "Bootstrap component");
    }
}

///////////////////////////////////////////

var contentPlaceholders = $('.content-placeholder__bg');
var waitFn;

contentPlaceholders.each(function() {
    waitFn = $(this).waitForImages(function() {
        $(this).addClass('content-placeholder__bg--content-loaded');
        $('.content-placeholder__bg-masks-container', this).remove();

        waitFn = null;
    });
});

$('.code-example-tabpanel [role="tab"]').click(function (e) {
    if ($(e.target).closest('.code-example-popout-link').length == 0) {
        e.preventDefault();
        $(this).tab('show');

        if (ga) {
            var targetInnerText = e.target.innerText;
            var componentName = targetInnerText.substring(0, targetInnerText.indexOf(' Component'));

            ga('send', 'pageview', gaSourceCodeViewPath + componentName);
        }
    }
});

$('a', '#demo-toc').on('click', function(ev) {
    handleGaHashLinkClick(ev.currentTarget.hash);
});
