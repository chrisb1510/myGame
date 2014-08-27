Package.describe({
  summary: "REPLACEME - What does this package (or the original one you're wrapping) do?"
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
