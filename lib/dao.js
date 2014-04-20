var mysql=require('mysql');
var pool=mysql.createPool({
	host:'localhost',
	user:'root',
	password:'root',
	database:'lxzhu'
});
module.exports={
	create:function(){
		var pri={};
    var pub={};
    pub.open=function(callback){
			pool.getConnection(function(e,connection){
				pri.connection=connection;
				callback(e,pri);
			});
		};
    
		pub.close=function(ctx,callback){
			console.log("pub.close");
			if(pri.connection){
				console.log("we're releasing  connection");
				pri.connection.release();
				callback(null,ctx);
			}
		};
		return pub;		
	}
};
