'use strict';

var gulp = require('gulp');
var config = require('../config');

var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');

var browserSync = require('../util/browser_sync');

var assets_paths = {
  styles: [
    'app/styles/app.scss'
  ]
};

gulp.task('styles', function () {
  return gulp.src(assets_paths.styles)
    .pipe(sourcemaps.init())
    .pipe(sass({
      includePaths: ['../bower_components/foundation/scss']
    }).on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(config.dist + '/styles'))
    .pipe(browserSync.reload({ stream: true }));
});
