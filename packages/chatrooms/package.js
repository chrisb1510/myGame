Package.describe({
  summary: "REPLACEME - What does this package (or the original one you're wrapping) do?"
});

Package.on_use(function (api, where) {
  api.use('underscore');
  api.use('ejson');
  api.use('coffeescript');
  api.use('templating', 'client');
  api.use('handlebars', 'client');
  api.use('pixijs');
  api.export('testplayer',['client','server'])
  api.add_files('lib/collections.coffee',['client','server']);
  api.add_files('Server/chatroom_Server.coffee',['server']);
  api.add_files('Public/chat.html',['client']);
  api.add_files('Client/chatrooms_Client.coffee', ['client']);

});

Package.on_test(function (api) {
  api.use('coffeescript');
  api.use('chatrooms');
});
