var path = require('path');
var production = (process.env.NODE_ENV === 'production');

module.exports = {
  dist:   production ? 'dist' : '.tmp',
  port:   9000,
  root:   path.resolve('./')
};
