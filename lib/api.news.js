var news = [{
		id: 1,
		title: "这是我的在线消息平台，测试一下",
		intro: "Hello",
		content: "第一步 服务端硬编码 客户端定时查询 \
第二步 服务端读取数据库 客户端可以添加消息 \
第三步 服务端和客户端通过websocket实时通讯",
		postOn: "2014-04-26"
	},

	{
		id: 2,
		title: "这是我的在线消息平台，测试一下",
		intro: "Hello",
		content: "第一步 服务端硬编码 客户端定时查询 \
第二步 服务端读取数据库 客户端可以添加消息 \
第三步 服务端和客户端通过websocket实时通讯",
		postOn: "2014-04-26"
	},

	{
		id: 3,
		title: "这是我的在线消息平台，测试一下",
		intro: "Hello",
		content: "第一步 服务端硬编码 客户端定时查询 \
第二步 服务端读取数据库 客户端可以添加消息 \
第三步 服务端和客户端通过websocket实时通讯",
		postOn: "2014-04-26"
	},

	{
		id: 4,
		title: "这是我的在线消息平台，测试一下",
		intro: "Hello",
		content: "第一步 服务端硬编码 客户端定时查询 \
第二步 服务端读取数据库 客户端可以添加消息 \
第三步 服务端和客户端通过websocket实时通讯",
		postOn: "2014-04-26"
	},
];
var api= {
	route: function(app) {
		app.get('/api/news', function(req, res) {
			res.writeHead(200, {
				'Content-Type': 'application/json;charset=utf-8'
			});
			res.end(JSON.stringify(news));
		});
		app.get('/api/news/:id', function(req, res) {
			var matched = false;
			for (var idx = 0; idx < news.length; idx++) {
				var item = news[idx];
				if (item.id == req.params["id"]) {
					matched = true;
					res.writeHead(200, {
						'Content-Type': 'application/json;charset=utf-8'
					});
					res.end(JSON.stringify(item));
				}
			}
			if (!matched) {
				res.writeHead(200, {
					'Content-Type': 'application/json;charset=utf-8'
				});
				res.end(JSON.stringify({
					fault: "没有找到id为" + req.params["id"] + "的消息"
				}));
			}
		});
		app.post("/api/news", function(req, res) {
			console.log("req.body.id:"+req.body.id);
			var item=api.find(req.body.id);
			if(item==null){
				console.log("does not find news by id");
				item={
					id:news.length+1
				};
				news[item.id]=item;
			}
			
			item.title=req.body.title;
			item.intro=req.body.intro;
			item.content=req.body.content;
      
			res.writeHead(200,{"Content-Type":"application/json;charset=utf-8"});
			res.end(JSON.stringify(news));
		});
	},
	find: function(id) {
		var ret = null;
		if (!id) {
			return ret;
		}
		for (var idx = 0; idx < news.length; idx++) {
			var item = news[idx];
			if (item.id == id) {
				ret = item;
				break;
			}
		}
		return ret;
	}

};
module.exports=api;
