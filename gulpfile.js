/* jshint node:true */
'use strict';

var gulp           = require('gulp');
var $              = require('gulp-load-plugins')();

var browserSync    = require('browser-sync');
var browserify     = require('browserify');
var buffer         = require('vinyl-buffer');
var coffeeify      = require('coffeeify');
var debowerify     = require('debowerify');
var del            = require('del');
var hamlcify       = require('haml-coffee-browserify');
var source         = require('vinyl-source-stream');
var watchify       = require('watchify');

var historyApiFallback = require('connect-history-api-fallback');

var reload         = browserSync.reload;

// Bundle files with browserify
gulp.task('browserify', function () {
  // set up the browserify instance on a task basis
  var bundler = browserify({
    entries: 'app/scripts/env.coffee',
    extensions: [
      ".hamlc",
      ".haml",
      ".coffee",
      ".js",
      ".json"
    ],
    debug: true,
    // defining transforms here will avoid crashing your stream
    transform: [coffeeify, debowerify, hamlcify]
  });

  bundler = watchify(bundler);

  var rebundle = function() {
    return bundler.bundle()
      .on('error', $.util.log)
      .pipe(source('env.js'))
      .pipe(buffer())
      .pipe($.sourcemaps.init({loadMaps: true}))
        // Add transformation tasks to the pipeline here.
        .on('error', $.util.log)
      .pipe($.sourcemaps.write('./'))
      .pipe(gulp.dest('.tmp/scripts'));
  }

  bundler.on('update', rebundle);

  return rebundle();
});

// Bundle files with browserify for production
gulp.task('browserify:dist', function () {
  // set up the browserify instance on a task basis
  var bundler = browserify({
    entries: 'app/scripts/env.coffee',
    extensions: [
      ".hamlc",
      ".haml",
      ".coffee",
      ".js",
      ".json"
    ],
    // defining transforms here will avoid crashing your stream
    transform: [coffeeify, debowerify, hamlcify]
  });

  return bundler.bundle()
    .on('error', $.util.log)
    .pipe(source('env.js'))
    .pipe(buffer())
    .pipe($.uglify())
    .pipe(gulp.dest('dist/scripts'));
});

// Lint Javascript
gulp.task('jshint', function () {
  return gulp.src([
      'app/scripts/**/*.js',
      '!app/scripts/config.js',
      '!app/scripts/vendor/**/*.js'
  ])
    .pipe(reload({stream: true, once: true}))
    .pipe($.jshint())
    .pipe($.jshint.reporter('jshint-stylish'))
    .pipe($.if(!browserSync.active, $.jshint.reporter('fail')));
});

// Copy web fonts to dist
gulp.task('fonts', function () {
  return gulp.src([
    'app/{,styles/}fonts/**/*'
  ])
    .pipe($.flatten())
    .pipe(gulp.dest('dist/fonts'));
});

gulp.task('styles', function () {
  return gulp.src(['app/styles/main.scss', "app/styles/foundation_env.scss"])
    .pipe($.sourcemaps.init())
    .pipe($.sass({
      includePaths: ['./bower_components/foundation/scss']
    }).on('error', $.sass.logError))
    .pipe($.sourcemaps.write())
    .pipe(gulp.dest('.tmp/styles'))
    .pipe(reload({ stream: true }));
});

gulp.task('styles:dist', function () {
  return gulp.src(['app/styles/main.scss', "app/styles/foundation_env.scss"])
    .pipe($.sourcemaps.init())
    .pipe($.sass({
      includePaths: ['./bower_components/foundation/scss']
    }).on('error', $.sass.logError))
    .pipe($.sourcemaps.write())
    .pipe(gulp.dest('dist/styles'))
    .pipe(reload({ stream: true }));
});

gulp.task('haml', function () {
  return gulp.src('app/*.haml')
    .pipe($.haml())
    .pipe(gulp.dest('./.tmp'));
});

gulp.task('haml:dist', function () {
  return gulp.src('app/*.haml')
    .pipe($.haml())
    .pipe(gulp.dest('dist'));
});

gulp.task('usemin', ['haml:dist', 'styles:dist', 'browserify:dist'], function() {
  return gulp.src('dist/*.html')
    .pipe($.replace('/bower_components/', '../bower_components/'))
    .pipe($.usemin({
      assetsDir: 'dist',
      css:       [$.csso,   'concat', $.rev],
      inlinejs:  [$.uglify],
      js:        [$.uglify, 'concat', $.rev]
    }))
    .pipe(gulp.dest('dist/'))
});

// Clean output directory and cached images
gulp.task('clean', function (callback) {
  del(['.tmp', 'dist'], function () {
    $.cache.clearAll(callback);
  });
});

// Copy assets to distribution path
gulp.task('extras', function () {
  return gulp.src([
    'app/*.*'
  ], {
    dot: true
  }).pipe(gulp.dest('dist'));
});

gulp.task('serve', ['haml', 'styles', 'browserify'], function () {
  browserSync({
    notify: false,
    port: 9000,
    ui: {
      port: 9001
    },
    server: {
      baseDir: ['.tmp', 'app'],
      routes: {
        '/bower_components': 'bower_components'
      },
      middleware: [ historyApiFallback() ]
    }
  });

  gulp.watch([
    'app/scripts/**/*.coffee',
    'app/scripts/**/*.hamlc',
    'app/images/**/*',
    './.tmp/scripts/**/*.js',
    './.tmp/*.html'
  ]).on('change', reload);

  gulp.watch('app/*.haml', ['haml']);
  gulp.watch('app/styles/**/*.scss', ['styles']);
});

gulp.task('serve:dist', function() {
  browserSync({
    notify: false,
    port: 9000,
    server: {
      baseDir: ['dist']
    }
  });
});

// gulp.task('addbowerdeps', function() {
//   return $.bower().pipe(gulp.dest('dist/bower_components/'))
// });

gulp.task('cleanup:deps', ['usemin'], function() {
  return del([
    // 'dist/bower_components/**',
    'dist/scripts/**',
    'dist/styles/**',
    'dist/*.haml'
  ]);
})

// Build the project for distribution
gulp.task('build', ['jshint', 'fonts', 'extras', 'cleanup:deps']);

// Clean all and build from scratch
gulp.task('default', ['clean'], function () {
  gulp.start('build');
});
