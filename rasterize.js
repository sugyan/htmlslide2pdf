(function (window) {
    var page = new window.WebPage();
    var address = window.phantom.args[0];
    var output  = window.phantom.args[1];
    var width   = window.phantom.args[2];
    var height  = window.phantom.args[3];
    var paperwidth  = window.phantom.args[4];
    var paperheight = window.phantom.args[5];

    page.viewportSize = { width: width, height: height };
    page.paperSize = { width: paperwidth, height: paperheight, border: '0px' };

    page.open(address, function (status) {
        console.log(status);
        if (status !== 'success') {
            console.log('Unable to load the address!');
        } else {
            window.setTimeout(function () {
                page.render('png/' + output);
                window.phantom.exit();
            }, 1000);
        }
    });
}(this));
