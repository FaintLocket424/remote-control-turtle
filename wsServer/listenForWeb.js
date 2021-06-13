const websocket = require('ws');

const wss = new websocket.Server({ port: 8081 });

wss.on('connection', function connection(ws) {
	ws.on('message', function incoming(data) {
		wss.clients.forEach(function each(client) {
			if (client.readyState === websocket.OPEN) {
				console.log(data);
				client.send(data);
			};
		});
	});
});
