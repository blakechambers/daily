'use strict';

var gulp = require('gulp');
var config = require('../config');

var replace = require('gulp-replace');
var usemin  = require('gulp-usemin');
var csso    = require('gulp-csso');
var uglify  = require('gulp-uglify');
var rev     = require('gulp-rev');

gulp.task('usemin', ['haml', 'styles', 'browserify'], function() {
  return gulp.src('dist/*.html')
    .pipe(replace('/bower_components/', '../bower_components/'))
    .pipe(usemin({
      assetsDir: 'dist',
      css:       [csso,   'concat', rev],
      inlinejs:  [uglify],
      js:        [uglify, 'concat', rev]
    }))
    .pipe(gulp.dest(config.dist));
});
