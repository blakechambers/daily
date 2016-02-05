'use strict';

var gulp           = require('gulp');
var config         = require('../config');

// // Lint Javascript
// gulp.task('jshint', function () {
//   return gulp.src([
//       'app/scripts/**/*.js',
//       '!app/scripts/config.js',
//       '!app/scripts/vendor/**/*.js'
//   ])
//     .pipe(reload({stream: true, once: true}))
//     .pipe($.jshint())
//     .pipe($.jshint.reporter('jshint-stylish'))
//     .pipe($.if(!browserSync.active, $.jshint.reporter('fail')));
// });
