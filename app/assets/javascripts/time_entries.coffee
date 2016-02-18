# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('input[name="time_entry[running]"]').change ->
    $('#time_entry_duration').val(null)
    $('#time_entry_duration').prop('disabled', $(this).is(':checked'))
    $('#time_entry_result').val(null)
    $('#time_entry_result').prop('disabled', $(this).is(':checked'))
