// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    var loadSelect2 = function() {
        $("#task_tag_ids").select2();
    }

    var completedShown = false;
    var toggleCompleted = function(e) {
        var completeToggle = e.currentTarget;
        var completed = $("#completed-tasks");

        if (completedShown) {
            $(completed).hide();
            $(completeToggle).html("Show completed");
        } else {
            $(completed).show();
            $(completeToggle).html("Hide completed");
        }

        completedShown = !completedShown;
    }

    var setupCompleteHandlers = function() {
        $(".task-item input[type=checkbox]").change(function(event) {
            var id = event.target.id.substr(5);
            var target = $(event.target);

            if (target.prop("checked")) {
                window.location = "/tasks/" + id + "/complete"
            } else {
                window.location = "/tasks/" + id + "/uncomplete"
            }
        });
    }

    $(document).on("turbolinks:load", function() {
        $("#complete-toggle").click(toggleCompleted);
        $("#task_start_datetimepicker").datetimepicker({ format: "L" });
        $("#task_due_datetimepicker").datetimepicker({ format: "L" });
        setupCompleteHandlers();
        loadSelect2();
    });
});
