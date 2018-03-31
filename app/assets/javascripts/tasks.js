// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    var loadSelect2 = function() {
        $("#task_tag_ids").select2();
    }

    var completedShown = false;
    var toggleCompleted = function(e) {
        var archiveToggle = e.currentTarget;
        var completed = $("#completed-tasks");

        if (completedShown) {
            $(completed).hide();
            $(archiveToggle).html("Show completed");
        } else {
            $(completed).show();
            $(archiveToggle).html("Hide completed");
        }

        completedShown = !completedShown;
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

    $(document).on("turbolinks:load", function() {
        $("#archive-toggle").click(toggleCompleted);
        $("#task_start_datetimepicker").datetimepicker({ format: "L" });
        $("#task_due_datetimepicker").datetimepicker({ format: "L" });
        setupCompleteHandlers();
        loadSelect2();
    });
});
