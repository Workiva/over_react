var contentPlaceholders = $('.content-placeholder__bg');
var waitFn;

contentPlaceholders.each(function() {
  waitFn = $(this).waitForImages(function() {
    $(this).addClass('content-placeholder__bg--content-loaded');
    $('.content-placeholder__bg-masks-container', this).remove();

    waitFn = null;
  });
});
