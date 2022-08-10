// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.form
//= require bootbox
//= require jquery.validate
//= require ahoy
//= require main
//= require turbolinks

$("body").on("shown.bs.modal", ".modal", function() {
    var modal_dialog = $(this).find('.modal-dialog');
    var modal_height = modal_dialog.height();
    var window_height = $(window).height();
    modal_dialog.animate({ marginTop: (window_height/2) - (modal_height/2) }, 300);
});