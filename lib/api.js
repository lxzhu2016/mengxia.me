var api={
	proto_product_code:{
		add:require('api.proto_product_code.add'),
		exists:require('api.proto_product_code.exists')
	},
	security:{
		login:require('api.security.login'),
		logout:require('api.security.logout'),
		who:require('api.security.who')
	}
};
module.exports=api;

