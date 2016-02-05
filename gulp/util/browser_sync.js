var config = require('../config');

var _browserSync = require('browser-sync');
var reload         = _browserSync.reload;

module.exports = {
  reload:    reload,
  configure: _browserSync
};
