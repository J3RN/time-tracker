// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  var hideOrShowFields = function() {
    const checked = $("#time_entry_running").is(':checked');

    if (checked) {
      $('#time_entry_duration').parent().hide();
      $('#time_entry_result').parent().hide();
      $('#time_entry_start_time').parents(".form-group").hide();
    } else {
      $('#time_entry_duration').parent().show();
      $('#time_entry_result').parent().show();
      $('#time_entry_start_time').parents(".form-group").show();
    }
  }

  $(document).on("turbolinks:load", function() {
    hideOrShowFields();
    $('#te_datetimepicker').datetimepicker();
    $('input[name="time_entry[running]"]').change(hideOrShowFields);
  })
});

(function poll(){
  setTimeout(function() {
    var filterDate = $('.js-update-entries').data('filterDate');

    if (filterDate) {
      $.get({
        url: '/time_entries/updates_all_time_entries',
        data: { date: filterDate },
        complete: function(data) {
          $('.js-update-entries').html(data.responseText);
          poll();
        },
        timeout: 60000 });
    }
  }, 60000);
})();
