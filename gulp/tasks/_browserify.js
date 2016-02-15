'use strict';

var gulp           = require('gulp');
var config         = require('../config');

var browserify = require('browserify');
var buffer = require('vinyl-buffer');
var coffeeify = require('coffeeify');
var debowerify = require('debowerify');
var gutil = require('gulp-util');
var hamlcify = require('haml-coffee-browserify');
var source = require('vinyl-source-stream');
var sourcemaps = require('gulp-sourcemaps');

// Bundle files with browserify
gulp.task('browserify', function () {
  // set up the browserify instance on a task basis
  var bundler = browserify({
    entries: 'app/scripts/env.coffee',
    extensions: [
      ".hamlc",
      ".haml",
      ".coffee"
    ],
    paths: ['app/scripts'],
    debug: true,
    // defining transforms here will avoid crashing your stream
    transform: [coffeeify, debowerify, hamlcify]
  });

  var rebundle = function() {
    return bundler.bundle()
      .on('error', gutil.log)
      .pipe(source('env.js'))
      .pipe(buffer())
      .pipe(sourcemaps.init({loadMaps: true}))
        .on('error', gutil.log)
      .pipe(sourcemaps.write('./'))
      .pipe(gulp.dest(config.dist + '/scripts'));
  }

  // bundler.on('update', rebundle);

  return rebundle();
});
