Package.describe({
  summary: "Main Program"
});

Package.on_use(function (api, where) {
    var both = ['client', 'server'];

    api.use('coffeescript');
    api.use('templating', 'client');
	api.use('jquery');
	api.use('less');
	
	api.use('less-bootstrap-3');
	api.use('less-fontawesome-4');
	api.use('pixijs','client');
	api.use('accounts-base');
	api.use('accounts-password');
	
	
	
	api.add_files('public/img/bunny.png', 'client');
	

	api.add_files('public/Templates/main.html', 'client');
	api.add_files('public/Stylesheets/main.less', 'client');
	api.add_files('public/collections.coffee', ['client','server']);
	api.add_files('server/mainServer.coffee', 'server');
	
	api.add_files('client/Board.coffee', 'client');
	
	
});

Package.on_test(function (api) {
	api.use(['coffeescript','munit','chai']);
	api.use('main');
	//api.add_files('lib/main_tests.coffee', ['client', 'server']);
	
});
