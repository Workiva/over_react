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
  }
});
