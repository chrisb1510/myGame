Package.describe({
  summary: "blah blah",
  version:"0.1.0"
});

Package.on_use(function (api, where) {
  
  
  api.use('coffeescript');
  api.use('templating', 'client');
  api.use('pixijs');
  
  

});

Package.on_test(function (api) {
  api.use('coffeescript');
  api.use('chatrooms');
});
