'use strict';

var gulp = require('gulp');
var config = require('../config');

var haml = require('gulp-haml');

gulp.task('haml', function () {
  return gulp.src('app/*.haml')
    .pipe(haml())
    .pipe(gulp.dest(config.dist));
});
