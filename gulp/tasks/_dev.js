'use strict';

var gulp = require('gulp');
var config = require('../config');

var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var historyApiFallback = require('connect-history-api-fallback');

var browserSync = require('../util/browser_sync');

gulp.task('dev', ['haml', 'styles', 'extras', 'browserify'], function () {
  browserSync.configure({
    notify: false,
    port:   config.port,
    ui:     { port: 9001 },
    server: {
      baseDir: [config.dist, 'app'],
      routes: {

        '/bower_components': 'bower_components'
      },
      middleware: [ historyApiFallback() ]
    }
  });

  gulp.watch([
    './.tmp/scripts/**/*.js',
    './.tmp/*.html'
  ]).on('change', browserSync.reload);

  gulp.watch('app/scripts/**/*.coffee', ["browserify"])
  gulp.watch('app/scripts/**/*.hamlc',  ["browserify"])
  gulp.watch('app/*.haml', ["haml"]);
  gulp.watch('app/styles/**/*.scss', ["styles"]);
});
