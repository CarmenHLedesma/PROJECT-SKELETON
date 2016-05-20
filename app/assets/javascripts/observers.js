// Esto además de para simplificar y ponerlo bonito, sirve para que turbo-link no impida cargar el js...
var ready;
ready = function() {
    observers();
};
$(document).ready(ready );
$(document).ajaxComplete(ready);

function nested_fields_observer() {
    $(document).off('nested:fieldAdded').on('nested:fieldAdded', function (event) {
        var field = event.field;

        field.find('.pickadate-format').pickadate({
            // Escape any “rule” characters with an exclamation mark (!).
            format: 'dddd, dd mmm, yyyy',
            formatSubmit: 'yyyy/mm/dd',
            hiddenPrefix: '',
            hiddenSuffix: ''
        });
    });
}

function btn_limpiar_observer(){
    $('.btn-limpiar').on('click.btn_limpiar',function() {
        $(this).parents('form').find('input').val('').attr('value', '');
        $(this).parents('form').find('select').each(function() {
            $(this).find('option:selected').removeAttr('selected');
            $(this).select2('destroy');
            $(this).select2({
                placeholder: "Selecciona opcion",
                allowClear: true
            });
        })
        $('#limpiar').attr('value','true');
    })
}

// Añadir todos los observers a partir de aquí.
function observers () {
    //observers "locales"
    //accesibilidades_observers();
    emails_observers();
    select_disable_observers();
    //observers "globales"
    //report_observers();
    nested_fields_observer();
    btn_limpiar_observer();
    js_select_style();
    select_disable_observers_change();
    etiquetas_observers();
    ajuste_row();
    //select2_observer();

}