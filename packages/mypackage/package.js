Package.describe({
  summary: "my project trying to get testing and metoer working - noob"
});

Package.on_use(function (api, where) {
  api.use('coffeescript')
  api.add_files('mypackage.coffee', ['client', 'server']);

});

Package.on_test(function (api) {
  api.use('mypackage');
  api.use(['coffeescript','munit','chai']);
  api.add_files('lib/mypackage_tests.coffee', ['client', 'server']);
});
