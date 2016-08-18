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

    var archivedShown = false;
    var toggleArchived = function(e) {
        var archiveToggle = e.currentTarget;
        var archived = $("#archived-tasks");

        if (archivedShown) {
            $(archived).hide();
            $(archiveToggle).html("Show archived");
        } else {
            $(archived).show();
            $(archiveToggle).html("Hide archived");
        }

        archivedShown = !archivedShown;
    }

    var setupCompleteHandlers = function() {
	$(".task-table input[type=checkbox]").change(function(event) {
	    var id = event.target.id.substr(5);
	    var target = $(event.target);

	    if (target.prop("checked")) {
		window.location = "/tasks/" + id + "/archive"
	    } else {
		window.location = "/tasks/" + id + "/unarchive"
	    }
	});
    }

    $(document).on("page:change", function() {
        $("#task_due").change(hideOrShowDueDate);
        $("#archive-toggle").click(toggleArchived);
	setupCompleteHandlers();
        hideOrShowDueDate();
        loadSelect2();
    });
});
