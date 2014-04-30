module.exports = function() {
	var pri = {};
	var pub = {};
	pub.productCode = function(code) {
		pri.productCode = code;
		return this;
	};

	pub.exists = function(ctx, callback) {
		var sql = "select 1 from proto_product_code where proto_product_code=?";
		ctx.connection.query(sql, [pri.productCode],
			function(e, rows) {
				ctx.productCodeExists=false;
				if(rows && rows.length>0){
					ctx.productCodeExists=true
				}
				callback(e,ctx);
			}
		);
	};

	return pub;
};
