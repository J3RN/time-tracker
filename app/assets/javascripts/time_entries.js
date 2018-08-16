function setTableRows(rows) {
    document.dataTable.clear();
    document.dataTable.rows.add(rows).draw();
}

function loadDataTable () {
        document.dataTable = $("#time-entries-table").DataTable({
            "pageLength": 50,
            "order": [[ 0, "desc" ]],
            "columnDefs": [
              { "orderable": false, "targets": [1,2,3,5] }
            ]
        });
        document.getElementById("time-entries-table_length").innerHTML = "<a data-keybinding=\"n\" href=\"/time_entries/new\"><button type=\"button\" class=\"btn btn-success\">Add time entry</button></a>";
}

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
  $.get({
    url: '/time_entries/updates_all_time_entries',
    data: {},
    complete: function(data) {
      setTableRows(JSON.parse(data.responseText));
      setTimeout(poll, 50000);
    },
    timeout: 50000 });
})();
