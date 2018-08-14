$(function() {
  var hideOrShowFields = function() {
    const checked = $("#time_entry_running").is(':checked');

    const elements_to_update = [
      $('#time_entry_duration').parent(),
      $('#time_entry_result').parent()
    ];

    if (checked) {
      elements_to_update.forEach(element => element.hide());
    } else {
      elements_to_update.forEach(element => element.show());
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
