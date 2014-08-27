

Package.describe({
  summary: "my project trying to get testing and metoer working - noob"
  
});

Package.on_use(function (api, where) {
  var both = ['client', 'server']
  api.use('ejson');
  api.use('coffeescript');
  api.use('accounts-ui');
  
  api.add_files('client/myUsers.coffee','server' );
  api.add_files('client/User.coffee','server');

  
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
