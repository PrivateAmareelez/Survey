function progress(poll_id) {
    var progress = setInterval(function () {
        var $bar = $('#progressbar1');
        $.get(poll_id + "/time_left.json", function (data) {
            if (data[1] === 0) {
                clearInterval(progress);
                location.reload();
            } else {
                $bar.width(data[1] + "%");
                $bar.text(data[0]);
            }
        })
            .fail(function () {
                clearInterval(progress);
                location.reload();
            });
    }, 1000);
}