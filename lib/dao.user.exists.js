module.exports={
	create:function(){
		var pri={};
		var pub={};
		
		pub.username=function(name){
			pri.username=name;
		}
		pub.exists=function(ctx,callback){
			var sql="select 1 from user where username=?";
			ctx.connection.query(sql,
				[pri.username],
				function(e,rows){
					ctx.exists=false};
					if(!e){
						if(rows && rows.length>0){
							ctx.exists=true;
						}
					}else{
						console.log(e);
					}
					callback(e,ctx);
				});
		}
	}
};
