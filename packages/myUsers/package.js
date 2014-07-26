

Package.describe({
  summary: "my project trying to get testing and meteor working - noob"
  
});

Package.on_use(function (api, where) {
  var both = ['client', 'server']
  api.use('standard-app-packages');
  api.use('coffeescript');
  api.use('accounts-ui');
  api.use('modernizr-meteor');
  api.use('templating', 'client');
  
  
  api.add_files('server/accountsConfig.coffee', both);
  api.add_files('client/login.html','client');
  api.add_files('client/login.coffee','client');
  api.add_files('client/User.coffee','server');
  api.export('User');
  api.export('myUsers');
//export package when 
});

Package.on_test(function (api) {
	var both = ['client','server']
	api.use(['coffeescript','munit','chai']);
  api.use('myUsers');

  api.add_files('client/User.coffee','server')
  api.add_files('lib/myUser_tests.coffee', 'server');
  //api.add_files('lib/TestSuiteExample.coffee',both);
    
});
