Package.describe({
  summary: "my main project "
});

Package.on_use(function (api, where) {
  api.use('coffeescript');
  api.add_files('client/client.coffee', ['client']);

  api.export('myGame');

});

Package.on_test(function (api) {
	var both = ['client','server']
	api.use(['coffeescript','munit','chai']);
  	api.use('myGame');
  	//api.add_files('lib/myGame_tests.coffee', both);
  	api.add_files('tests/TestSuiteExample2.coffee',both);
});