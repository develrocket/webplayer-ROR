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
//= require jquery2
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap
//= require jquery.form
//= require bootbox
//= require jquery.validate
//= require plugins/metisMenu/jquery.metisMenu
//= require plugins/slimscroll/jquery.slimscroll.min
//= require inspinia
//= require plugins/pace/pace.min
//= require 'plugins/dataTables/jquery.dataTables.js'
//= require 'plugins/dataTables/dataTables.bootstrap.js'
//= require 'plugins/dataTables/dataTables.responsive.js'
//= require 'plugins/dataTables/dataTables.tableTools.min.js'
//= require wice_grid
//= require nprogress
//= require nprogress-turbolinks
//= require backend/main
//= require local_time
//= require turbolinks

NProgress.configure({
    showSpinner: true,
    ease: 'ease',
    speed: 500
});
main = new Main;

$(function () {

    // in client side form submit result message show define for tour page
    main.form_submit_result('form.edit-webplayer-basic');

    // edit client form submit result message show define for client page
    main.form_submit_result('form.edit-client');

    $('ul.nav-tabs.custom li a').click(function(e) {
        var thisObj = $(this);
        if (thisObj.attr('rel') == 'visitor')
            return true;
        //prevent href event
        e.preventDefault();

        // progress bar start
        NProgress.start();

        $.get(thisObj.attr('href'), function(response, status) {
            // progress bar done
            NProgress.done();

            // notice bar initialize(hide and content blank)
            $('div.result-notice').fadeOut().html('');

            // tab ux initialize
            $('ul.nav-tabs.custom li').removeClass('active');
            thisObj.parent().addClass('active');

            // ajax get result html show in tab content
            $('div.ibox-content.custom').html(response);

            //form ajax submit result define(to show success or error message)
            var formSelector = 'form.edit-' + thisObj.attr('rel');
            main.form_submit_result(formSelector);

            /*$('form.edit-agent-branding').on('submit', function(e) {
                $.rails.handleRemote( $(this) );
                e.preventDefault();
            });*/

        });
        return false;
    })
});
