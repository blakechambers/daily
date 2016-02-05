//
// gulp.task('usemin', ['haml', 'styles', 'browserify'], function() {
//   return gulp.src('dist/*.html')
//     .pipe($.replace('/bower_components/', '../bower_components/'))
//     .pipe($.usemin({
//       assetsDir: 'dist',
//       css:       [$.csso,   'concat', $.rev],
//       inlinejs:  [$.uglify],
//       js:        [$.uglify, 'concat', $.rev]
//     }))
//     .pipe(gulp.dest(config.dist));
// });
