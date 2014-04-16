var express = require('express');
var redirect =require('express-redirect');
var http = require('http');
var path = require('path');
var app = express();
redirect(app);

	app.set('port', process.env.PORT || 80);
	app.set('views', __dirname + '/views');
	app.set('view engine', 'jade');
	//favicon is removed. could use https://www.npmjs.org/package/static-favicon
	//app.use(express.favicon()); 
	//TODO: how to config so it log to file?
	//app.use(express.logger('dev'));
	//app.use(express.json());
	//TODO: how to config it to allow url rewrite?
	//app.use(express.urlencoded());
	//app.use(express.query());
	//app.use(express.cookieParser());
	//app.use(express.bodyParser());
	//app.use(express.methodOverride());
	//app.use(app.router);
	app.use('/pubs',express.static(path.join(__dirname, 'pubs')));


	//app.use(express.errorHandler());

app.redirect('/','/pubs/index.htm');
/*
app.get('/',function(req,res){
  res.writeHead(200,{'Content-Type':'text/html'});
  res.end("<h1>Hello World</h1>");
});
*/
app.get('/view/:view', function(req, res) {
	res.render(req.params.view, {
		title : 'zhu liangxiong'
	});
});

http.createServer(app).listen(app.get('port'), function(error) {
	if (error) {
		console.log(error);
	} else {
		console.log('server is running on port ' + app.get('port'));
	}
});
