'use strict';

var gulp = require('gulp');
var config = require('../config');

var coffee = require('gulp-coffee');
var gutil  = require('gulp-util');

gulp.task('extras', ["manifest"], function () {
  return gulp.src([
    'app/sw.coffee'
  ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest(config.dist));
});

gulp.task('manifest', function () {
  return gulp.src([
    'app/manifest.json'
  ])
  .pipe(gulp.dest(config.dist));
});
