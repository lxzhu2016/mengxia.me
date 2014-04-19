var async=require('async');
var context=require('../dataAccess.js');
var login=require('../dataAccess.login.js');

var c=context.create();
var l=login.create().username('lxzhu').password('norikos');
async.waterfall([c.open,l.login,c.close],
	function(e,d){
    console.log("this is the final ");
});

