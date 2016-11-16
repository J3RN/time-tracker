// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
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
        $("#archive-toggle").click(toggleArchived);
	$("#task_start_datetimepicker").datetimepicker({ format: "L" });
	$("#task_due_datetimepicker").datetimepicker({ format: "L" });
	setupCompleteHandlers();
        loadSelect2();
    });
});
