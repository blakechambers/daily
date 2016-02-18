'use strict';

var gulp = require('gulp');
var config = require('../config');

gulp.task('build', ['extras', 'clean:deps']);
