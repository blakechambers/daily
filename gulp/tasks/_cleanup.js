'use strict';

var gulp = require('gulp');
var config = require('../config');

var cache = require('gulp-cache');
var del = require('del');

gulp.task('clean', function (callback) {
  del(['.tmp', 'dist'], function () {
    $.cache.clearAll(callback);
  });
});

gulp.task('clean:deps', ['usemin'], function() {
  return del([
    config.dist + '/scripts/**',
    config.dist + '/styles/**',
    config.dist + '/*.haml'
  ]);
})
