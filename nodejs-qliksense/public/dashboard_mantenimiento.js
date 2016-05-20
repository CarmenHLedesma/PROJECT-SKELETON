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
        var app = qlik.openApp('41cb79d3-1a60-4a81-b190-5b6dba6b98c0', config);


        //get objects -- inserted here --
        app.getObject('CurrentSelections','CurrentSelections');
        //get objects -- inserted here --
        app.getObject('QV01','RUpta');
        app.getObject('QV02','aMznmm');

        app.getObject('QV04','pknrgH');
        app.getObject('QV03','pJhEDT');

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

