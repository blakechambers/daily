'use strict';

var gulp           = require('gulp');

var fs = require('fs');
var onlyScripts = require('./util/scriptFilter');
var tasks = fs.readdirSync('./gulp/tasks/').filter(onlyScripts);

tasks.forEach(function(task) {
  require('./tasks/' + task);
});

gulp.task('default', ['clean'], function () {
  gulp.start('build');
});
