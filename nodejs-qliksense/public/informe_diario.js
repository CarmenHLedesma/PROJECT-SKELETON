var app;
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
    app = qlik.openApp('96dda1f5-98ee-4387-8a6b-52d6f8af9a1b', config);
    app.clearAll();
    //get objects -- inserted here --


    app.getObject('QV01','HLBVx');

    //create cubes and lists -- inser
    setTimeout(function(){
        app.field('Dia').selectValues([{qText: "d" + String(day)},{qText: "d" + String((day - 1))}], true, true);
        app.field('Semana').selectValues([{qText: "w" + String(week)}], true, true);
        app.field('Mes').selectValues([{qText: "m" + String(month)}], true, true);
    }, 1000);

} );
setTimeout(function(){
    $('.qv-grid-object-scroll-area').attr('style','overflow-y: auto');
    $('#CurrentSelections').css('z-index','1');
}, 3000);



function loadCss(url) {
    var link = document.createElement("link");
    link.type = "text/css";
    link.rel = "stylesheet";
    link.href = url;
    document.getElementsByTagName("head")[0].appendChild(link);
}


