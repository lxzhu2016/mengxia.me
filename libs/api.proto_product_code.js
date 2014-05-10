var async=require('async');
var dataClass=require('./data_access');
var existsClass=require('./data_access.proto_product_code.exists');
var addClass=require('./data_access.proto_product_code.add');

module.exports.handle=function(req,res){
	var code=req.body.proto_product_code;
	var mobileClass=req.body.mobile_class;
	var backendWebClass=req.body.backend_web_class;
	var frontendWebClass=req.body.frontend_web_class;
	var data=dataClass.create();
	var exists=existsClass.create();
	exists.productCode(code);

	var add=addClass.create();
	
	add.productCode(code);
	add.mobileClass(mobileClass);
	add.backendWebClass(backendWebClass);
	add.frontendWebClass(frontendWebClass);
	
	async.waterfall([data.open,
			function(data,callback){
				exists.productCodeExists(data,function(e,d){
					if(e){
						callback(e,d);
					}else{
					  if(d.exists){
							callback({
								faultCode:-1,
								faultMessage:'The product code already exists. Please do update.'
							},d);
						}else{
							callback(null,d);
						}
				});
			},
			add.addProductCode,
			data.close],
			function(e,d){				
				res.json(d);
			}		
	});
}
