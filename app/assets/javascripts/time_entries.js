// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    var hideOrShowFields = function() {
        const checked = $("#time_entry_running").is(':checked');
        console.log(checked);
        if (checked) {
            $('#time_entry_duration').val(null);
            $('#time_entry_duration').parent().hide();

            $('#time_entry_result').val(null);
            $('#time_entry_result').parent().hide();
        } else {
            $('#time_entry_duration').parent().show();
            $('#time_entry_result').parent().show();
        }
    }

    $('input[name="time_entry[running]"]').change(hideOrShowFields);
    $(document).on("page:change", hideOrShowFields)
});
