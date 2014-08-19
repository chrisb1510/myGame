Package.describe({
  summary: "Main Program"
});

Package.on_use(function (api, where) {
	var both = ['client', 'server']

	api.use('standard-app-packages', both);
	api.use('templating', 'client');
	api.use('appcache');
	api.use('jquery');
	api.use('less');
	api.use('coffeescript');
	api.use('less-bootstrap-3');
	api.use('less-fontawesome-4');
	api.use('chatrooms');
	api.use('myUsers');
	api.use('pixijs');
	api.use('phaserio');
	api.use('livedata');
	api.add_files('public/Templates/main.html','client');
	api.add_files('lib/pixirunner.coffee', 'client');
	api.add_files('public/Stylesheets/main.less','client');
	api.add_files('public/astarBG.png','client');
	api.add_files('client/mainClient.coffee', 'client');
	api.add_files('server/mainServer.coffee', 'server');
	api.export('pixiobject','client');

});

Package.on_test(function (api) {
	api.use(['coffeescript','munit','chai']);
	api.use('main');
	//api.add_files('lib/main_tests.coffee', ['client', 'server']);
	
});

