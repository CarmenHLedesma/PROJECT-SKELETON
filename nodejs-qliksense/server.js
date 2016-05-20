var https = require('https');
var http = require('http');
var fs = require('fs');
var urlParser = require('url');
var qlikAuth = require('qlik-auth');
var cors = require('cors');
var express = require('express');
var bodyParser = require('body-parser');
var filter_deployment = './public/js/filter_deployment.js';
var path = require('path');

app = express()
app.use(express.static('public'));
app.use(express.static('icomoon'));
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
app.options('*', cors());



app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});



app.get('/dashboard_despliegues', function(req,res){
    res.sendFile('/home/ubuntu/nodejs-qliksense/public/dashboard_despliegues.html');
});

app.post('/informe_diario', function(req,res){
    var username = req.body.username;
    var day = req.body.day;
    var week = req.body.week;
    var month = req.body.month;
    filter_values = "var username='" + username + "'; var day='" + day + "'; var week='" + week + "';var month='" + month + "';"
    fs.closeSync(fs.openSync(filter_deployment, 'w'));
    fs.writeFile(filter_deployment, filter_values, function(err) {
        if(err) {
            return console.log(err);
        }
        console.log("The file was saved!");
    });

    res.sendFile(__dirname + '/public/informe_diario.html');
});

app.post('/informe_semanal', function(req,res){
    var username = req.body.username;
    var day = req.body.day;
    var week = req.body.week;
    var month = req.body.month;
    filter_values = "var username='" + username + "'; var day='" + day + "'; var week='" + week + "';var month='" + month + "';"
    fs.closeSync(fs.openSync(filter_deployment, 'w'));
    fs.writeFile(filter_deployment, filter_values, function(err) {
        if(err) {
            return console.log(err);
        }
        console.log("The file was saved!");
    });

    res.sendFile(__dirname + '/public/informe_semanal.html');
});

app.post('/informe_mensual', function(req,res){
    var username = req.body.username;
    var day = req.body.day;
    var week = req.body.week;
    var month = req.body.month;
    filter_values = "var username='" + username + "'; var day='" + day + "'; var week='" + week + "';var month='" + month + "';"
    fs.closeSync(fs.openSync(filter_deployment, 'w'));
    fs.writeFile(filter_deployment, filter_values, function(err) {
        if(err) {
            return console.log(err);
        }
        console.log("The file was saved!");
    });

    res.sendFile(__dirname + '/public/informe_mensual.html');
});

app.get('/indisponibilidades', function(req,res){
    res.sendFile(__dirname + '/public/indisponibilidades.html');
});

app.get('/dashboard_mantenimiento', function(req,res){
    res.sendFile(__dirname + '/public/dashboard_mantenimiento.html');
});

app.get('/authenticate?', function(req,res){
    var profile = {
        UserDirectory: 'WIN-OCODJUU7EQD',
        UserId: 'administrator',
        Attributes: []
    };

    var options = {
        Certificate: './client.pfx',
        PassPhrase: 'dmsQlik2015',
    };
    qlikAuth.requestTicket(req, res, profile, options);
});


var server = http.createServer(app);
server.listen(3000, function() {
    console.log('server listening');
});
