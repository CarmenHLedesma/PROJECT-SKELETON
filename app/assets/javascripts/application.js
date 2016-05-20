// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require plugins/loaders/pace.min
//= require core/libraries/jquery.min
//= require core/libraries/bootstrap.min
//= require plugins/loaders/blockui.min
//= require core/libraries/jquery_ui/interactions.min
//= require core/libraries/jquery_ui/datepicker.min
//= require core/libraries/jquery_ui/effects.min
//= require plugins/forms/selects/select2.min
//= require jquery_ujs
//= require core/app
//= require pages/form_select2
//= require plugins/ui/moment/moment.min
//= require plugins/ui/fullcalendar/fullcalendar.min
//= require plugins/ui/fullcalendar/lang/es
//= require plugins/pickers/pickadate/picker
//= require plugins/pickers/daterangepicker
//= require plugins/pickers/pickadate/picker.date
//= require plugins/pickers/pickadate/picker.time
//= require plugins/pickers/anytime.min
//= require pages/picker_date
//= require plugins/pickers/pickadate/translations/es_ES
//= require jquery_nested_form
//= require auxiliary-rpage/responsive-paginate
//= require core/libraries/jquery.mask.min
//= require pages/form_checkboxes_radios
//= require pages/picker_color
//= require plugins/forms/styling/switch.min
//= require plugins/forms/styling/switchery.min
//= require plugins/forms/styling/uniform.min
//= require plugins/pickers/color/spectrum
//= require observers



function clear_login_form(){
    $('input[type="text"],input[type="password"]').val('');
    $('div.alert').hide();
}

//function autocss_general(){
//    $('.form-horizontal input, .form-control-js input').addClass('form-control');
//}

// Realiza el toggle de la ventana modal con id, ejecutando la accion con la hash de parametros
function modal_confirm(id, accion, parametros){
    if ( $(id) != null && typeof(accion) == "function") {
        $(id).modal();
        $(id).find('.btn-aceptar-modal').off('click.control_aceptar_modal').on('click.control_aceptar_modal', function () {
            accion(parametros);
            return true;
        });

        $(id).find('.btn-cancelar-modal').off('click.control_cancelar_modal').on('click.control_cancelar_modal', function () {
            $(id).modal('hide');
        });
    } else
        console.log( "Problema en modal_confirm(id, accion, parametros): el \'id\' debe existir ("+id.toString()+")  y \'action\' debe ser una función ("+accion.toString()+")." );
}

// Simula enlaces con divs
function control_click_linked_div(){
    $('[data-linked-div]').on('click',function(){
        document.location = $('[data-linked-div]').attr('data-linked-div');
    })
}

(function() {
    var proxied = window.alert;
    window.alert = function() {
        // do something here
        $('#custom-alert').find('#text-custom-alert').html(arguments[0]);
        $('#custom-alert').modal('show');

    };
})();

$(document).ready(function(){
    //autocss_general();
    $(".pagination").rPage();
    control_click_linked_div();
    marcar_campos_obligatorios();
    observers();
});

function marcar_campos_obligatorios() {
    // Sin saltar el error de la validación
    $('.obligatorio').parent().prev().each(function(index, obj) {
        if ($(this).text().contains('*') == false){
            $(this).text('* ' + $(this).text());
        }
    });

    // Tras saltar el error de la validación
    $('.field_with_errors').find('label').each(function(index, obj) {
        if ($(this).text().contains('*') == false) {
            $(this).text('* ' + $(this).text());
        }
    });
}
