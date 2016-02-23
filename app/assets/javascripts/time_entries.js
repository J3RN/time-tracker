// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    $('input[name="time_entry[running]"]').change(function(event) {
        const checked = $(event.currentTarget).is(':checked');

        $('#time_entry_duration').val(null);
        $('#time_entry_duration').prop('disabled', checked);

        $('#time_entry_result').val(null);
        $('#time_entry_result').prop('disabled', checked);
    });
});
