Package.describe({
  summary: "Main Program"
});

Package.on_use(function (api, where) {
	var both = ['client', 'server']

	api.use('standard-app-packages', both);
	
	
	api.use('less');
	api.use('coffeescript');
	api.use('less-bootstrap-3');
	api.use('less-fontawesome-4');
	api.use('chatrooms');
	api.use('myUsers');
	
	api.add_files('Public/Templates/main.html','client');
	api.add_files('Public/Common.coffee', both);
	api.add_files('Public/Stylesheets/main.less','client');
	
	api.add_files('Client/mainClient.coffee', 'client');
	api.add_files('Server/mainServer.coffee', 'server');


});

Package.on_test(function (api) {
	api.use(['coffeescript','munit','chai']);
	api.use('main');
	api.add_files('lib/main_tests.coffee', ['client', 'server']);
	
});

