

Package.describe({
  summary: "my project trying to get testing and metoer working - noob",
  internal:true
});

Package.on_use(function (api, where) {
  api.use('coffeescript');
  api.add_files('client/mypackage.coffee', ['client', 'server']);
  
  api.export('mypackage');
//export package when 
});

Package.on_test(function (api) {
	var both = ['client','server']
	api.use(['coffeescript','munit','chai']);
  	api.use('mypackage');
  	api.add_files('lib/mypackage_tests.coffee', both);
  	api.add_files('lib/TestSuiteExample.coffee',both);
});
