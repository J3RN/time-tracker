// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    var hideOrShowDueDate = function() {
        const checked = $("#task_due").is(':checked');

        if (checked) {
            const date = new Date();

            $("#task_due_date_1i").val(String(1900 + date.getYear()));
            $("#task_due_date_2i").val(String(1 + date.getMonth()));
            $("#task_due_date_3i").val(String(date.getDate()));

            $("#task_due_date_1i").show();
            $("#task_due_date_2i").show();
            $("#task_due_date_3i").show();
        } else {
            $("#task_due_date_1i").val(null);
            $("#task_due_date_2i").val(null);
            $("#task_due_date_3i").val(null);

            $("#task_due_date_1i").hide();
            $("#task_due_date_2i").hide();
            $("#task_due_date_3i").hide();
        }
    }

    var loadSelect2 = function() {
        $("#task_tag_ids").select2();
    }

    $(document).on("page:change", function() {
        $("#task_due").change(hideOrShowDueDate);
        hideOrShowDueDate();
        loadSelect2();
    });

    var archivedShown = false;
    var archiveToggle = $("#archive-toggle");
    $(archiveToggle).click(function() {
        var archived = $("#archived-tasks");

        if (archivedShown) {
            $(archived).hide();
            $(archiveToggle).html("Show archived");
        } else {
            $(archived).show();
            $(archiveToggle).html("Hide archived");
        }

        archivedShown = !archivedShown;
    });
});
