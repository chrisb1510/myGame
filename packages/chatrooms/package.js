Package.describe({
  summary: "REPLACEME - What does this package (or the original one you're wrapping) do?"
});

Package.on_use(function (api, where) {
  api.use('coffeescript');
  api.add_files('chat.html',['client']);
  api.use('templating', 'client');
  api.use('handlebars', 'client');
  api.add_files('chatrooms.coffee', ['client', 'server']);
  
  api.export('Mainchatmessages');
});

Package.on_test(function (api) {
  api.use('coffeescript');
  api.use('chatrooms');

  api.add_files('chatrooms_tests.js', ['client', 'server']);
});
