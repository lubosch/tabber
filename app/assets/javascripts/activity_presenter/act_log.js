$(function () {
    start_date = new Date(Number(start_date) * 1000)

    draw_graph();

    $('.icon-zoom-in').bind("click", function () {
        step = step * 2
        x_size = x_size / 2
        $('.graph-container-inner').first().width($('.graph-container-inner').first().width() / 2)
        draw_graph();
    });

    $('.icon-zoom-out').bind("click", function () {
        if (step > 1) {
            step = step / 2
            x_size = x_size * 2
            $('.graph-container-inner').first().width($('.graph-container-inner').first().width() * 2)
            draw_graph();
        }
    });
    $("#timepicker").datetimepicker(
        {
            getDate: new Date(),
            timeFormat: "HH:mm",
            onSelect: function (selectedDateTime) {
                $('#time_ago').text(jQuery.timeago(selectedDateTime))
            }
        }
    );

    $("#timepicker").datepicker('setDate', start_date);
    $('#time_ago').text(jQuery.timeago(start_date));


    $("#change_tabber_range").click(function () {
        console.log("prve")
        var selected_date = new Date($('#timepicker').val());


        $("#change_tabber_range").submit(function () {
            $(".params").remove()
            console.log("druhe")

            var params = [
                {name: "range", value: selected_date}
            ]

            $.each(params, function (i, param) {
                console.log('pridavam');
                $("#change_tabber_range").after($('<input class ="params"/>').attr('type', 'hidden')
                    .attr('name', param.name)
                    .attr('value', param.value)
                );
            });
        });

        $("#change_tabber_range").submit();

        return false;
    });


});


draw_graph = function () {
    scheduler.locale.labels.timeline_tab = "Timeline";
    scheduler.locale.labels.section_custom = "Section";
    scheduler.config.details_on_create = true;
    scheduler.config.details_on_dblclick = true;
    scheduler.config.xml_date = "%Y-%m-%d %H:%i.%s";
    scheduler.xy.scale_height = 20;

    var format = scheduler.date.date_to_str("%H:%i");
    scheduler.templates.event_bar_text = function (sd, ed, ev) {
        return ev.text;
    }

    //===============
    //Configuration
    //===============
//    var sections = labels;

    var sections = labels

    scheduler.createTimelineView({
        name: "timeline",
        x_unit: "minute",
        x_date: "%i",
        x_step: step,
        x_size: x_size,
        y_unit: sections,
        y_property: "section_id",
        render: "bar",
        second_scale: {
            x_unit: "hour",
            x_date: "%H"
        }
    });

//    scheduler.ignore_timeline = function (date) {
//        //non-work hours
//        if (date < start_date) return true;
//    };


    scheduler.templates.tooltip_text = function (start, end, event) {
        for (var i = 0; i < labels.length; i++) {
            if (labels[i]["key"] == event.section_id) {
                return "<b>Event:</b> " + event.text + "<br/><b>Application:</b>" + labels[i]["label"];
            }
        }
    };

    //===============
    //Data loading
    //===============
    scheduler.config.lightbox.sections = [
        {name: "description", height: 130, map_to: "text", type: "textarea", focus: true},
        {name: "custom", height: 23, type: "select", options: sections, map_to: "section_id" },
        {name: "time", height: 72, type: "time", map_to: "auto"}
    ];

//    scheduler.init('scheduler_here',new Date(2009,5,30),"timeline");
    scheduler.init('scheduler_here', start_date, "timeline");
    scheduler.parse(log_data, "json");

    $('.dhx_cal_navline').width($('.dhx_cal_navline').parent().parent().parent().width())

}