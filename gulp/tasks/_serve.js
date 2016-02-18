'use strict';

var gulp = require('gulp');
var config = require('../config');

var browserSync = require('../util/browser_sync');

gulp.task('serve', function() {
  browserSync.configure({
    notify: false,
    port:   config.port,
    ui:     { port: 9001 },
    server: {
      baseDir: [config.dist, 'app']
    }
  });
});
