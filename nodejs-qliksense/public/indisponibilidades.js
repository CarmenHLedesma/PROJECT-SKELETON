$(document).ready(function(){
    var config = {
        host: "http://qlikdiebold.es/",
        prefix: "/sabadell/",	//this should be the name of the virtual proxy. For example "/nodeexample/"
        port: 80,
        isSecure: false
    };


    require.config( {
        baseUrl: ( config.isSecure ? "https://" : "https://" ) + config.host + (config.port ? ":" + config.port: "") + config.prefix + "resources"
    } );
    require( ["js/qlik"], function ( qlik ) {
        qlik.setOnError( function ( error ) {
            alert( error.message );
        } );
        var app = qlik.openApp('6e84a68e-de46-4808-987b-2ea7cc658f46', config);


        //get objects -- inserted here --

        //get objects -- inserted here --
        app.getObject('CurrentSelections','CurrentSelections');
        app.getObject('QV01','bTNdprK');
        app.getObject('QV02','AdhDx');
        app.getObject('QV03','ZVSyx');
        app.getObject('QV04','nntdTt');
        //create cubes and lists -- inser

    } );
    setTimeout(function(){
        $('.qv-grid-object-scroll-area').attr('style','overflow-y: auto');
        $('#CurrentSelections').css('z-index','1');
    }, 2000);

    function loadCss(url) {
        var link = document.createElement("link");
        link.type = "text/css";
        link.rel = "stylesheet";
        link.href = url;
        document.getElementsByTagName("head")[0].appendChild(link);
    }
});

