//
//var mysql=require('mysql');

module.exports={
	create:function(){
		var pri={};
    var pub={};
		pub.username=function(name){
			pri.username=name;
			return pub;
		};
		
		pub.password=function(pwd){
			pri.password=pwd;
			return pub;
		};
   
    pub.login=function(ctx,callback){
			var sql="select 1 from user where username=? and password=?";
			console.log("username:"+pri.username);
			console.log("password:"+pri.password);
			ctx.connection.query(sql,
				[pri.username,pri.password],
				function(e,rows){
					if(!e){
						console.log("rows:"+rows);
						if(rows && rows.length>0){
							ctx.login={
								ticket:pri.username
							};
						}else{
							ctx.login={
								ticket:''
							}
						}
					}else{
						console.log(e);
					}
					callback(e,ctx);
				});
		};

		return pub;
	}
}
