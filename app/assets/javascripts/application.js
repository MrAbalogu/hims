// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require jquery.turbolinks
//= require turbolinks
//= require plugins/bower_components/jquery/dist/jquery.min 
//= require bootstrap/dist/js/tether.min 
//= require bootstrap/dist/js/bootstrap.min 
//= require dataTables/jquery.dataTables
//= require plugins/bower_components/bootstrap-extension/js/bootstrap-extension.min 
//= require plugins/bower_components/lobipanel/dist/js/lobipanel.min
//= require plugins/bower_components/sidebar-nav/dist/sidebar-nav.min 
//= require plugins/bower_components/register-steps/jquery.easing.min 
//= require plugins/bower_components/register-steps/register-init 
//= require js/jquery.slimscroll 
//= require js/waves 

//= require plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min
//= require plugins/bower_components/raphael/raphael-min 
//= require plugins/bower_components/morrisjs/morris 
//= require plugins/bower_components/jquery-sparkline/jquery.sparkline.min 
//= require plugins/bower_components/peity/jquery.peity.min 
//= require plugins/bower_components/peity/jquery.peity.init 
//= require js/custom.min 
//= require js/dashboard1 
//= require plugins/bower_components/toast-master/js/jquery.toast
//= require js/jasny-bootstrap
//= require js/toastr
//= require toastr



/*global toastr*/
toastr.options = {
    "closeButton": true,
    "debug": false,
    "positionClass": "toast-bottom-right",
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "4000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }
