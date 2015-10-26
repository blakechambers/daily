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

var argArray  = process.argv.slice(4)[0];
var validENVs = ["development", "production"];
var gulpENV;
if(validENVs.indexOf(argArray) != -1 ) {
  gulpENV = argArray;
} else {
  gulpENV = "development";
}

var assets_paths = {
  styles: [
            'app/styles/main.scss',
            "app/styles/foundation_env.scss"
          ]
};

var GLOBAL_ENVS = {
  development: {
    dest: ".tmp"

  },
  production: {
    dest: "dist"
  }
};

var genv = GLOBAL_ENVS[gulpENV];

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
    paths: ['app/scripts'],
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
      // .pipe($.if((gulpENV == "production"), $.uglify()))
      .pipe($.sourcemaps.init({loadMaps: true}))
        .on('error', $.util.log)
      .pipe($.sourcemaps.write('./'))
      .pipe(gulp.dest(genv.dest + '/scripts'));
  }

  bundler.on('update', rebundle);

  return rebundle();
});
//
// // Bundle files with browserify for production
// gulp.task('browserify', function () {
//   // set up the browserify instance on a task basis
//   var bundler = browserify({
//     entries: 'app/scripts/env.coffee',
//     extensions: [
//       ".hamlc",
//       ".haml",
//       ".coffee",
//       ".js",
//       ".json"
//     ],
//     paths: ['app/scripts'],
//     // defining transforms here will avoid crashing your stream
//     transform: [coffeeify, debowerify, hamlcify]
//   });
//
//   return bundler.bundle()
//     .on('error', $.util.log)
//     .pipe(source('env.js'))
//     .pipe(buffer())
//     .pipe($.if((gulpENV == "production"), $.uglify()))
//     .pipe(gulp.dest(genv.dest + '/scripts');
// });

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
    'app/fonts/**/*'
  ])
    .pipe($.flatten())
    .pipe(gulp.dest(genv.dest + '/fonts'));
});

// Copy images to dist
gulp.task('images', function () {
  return gulp.src([
    'app/images/**/*'
  ])
    .pipe($.flatten())
    .pipe(gulp.dest('dist/images'));
});

gulp.task('styles', function () {
  return gulp.src(assets_paths.styles)
    .pipe($.sourcemaps.init())
    .pipe($.sass({
      includePaths: ['./bower_components/foundation/scss']
    }).on('error', $.sass.logError))
    .pipe($.sourcemaps.write())
    .pipe(gulp.dest('.tmp/styles'))
    .pipe(reload({ stream: true }));
});

gulp.task('haml', function () {
  return gulp.src('app/*.haml')
    .pipe($.haml())
    .pipe(gulp.dest(genv.dest));
});

gulp.task('usemin', ['haml', 'styles', 'browserify'], function() {
  return gulp.src('dist/*.html')
    .pipe($.replace('/bower_components/', '../bower_components/'))
    .pipe($.usemin({
      assetsDir: 'dist',
      css:       [$.csso,   'concat', $.rev],
      inlinejs:  [$.uglify],
      js:        [$.uglify, 'concat', $.rev]
    }))
    .pipe(gulp.dest(genv.dest));
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
  }).pipe(gulp.dest(genv.dest));
});

gulp.task('dev', ['haml', 'styles', 'fonts', 'browserify'], function () {
  browserSync({
    notify: false,
    port:   9000,
    ui:     { port: 9001 },
    server: {
      baseDir: [genv.dest, 'app'],
      routes: {
        '/bower_components': 'bower_components'
      },
      middleware: [ historyApiFallback() ]
    }
  });

  gulp.watch([
    'app/images/**/*',
    './.tmp/scripts/**/*.js',
    './.tmp/*.html'
  ]).on('change', reload);

  gulp.watch('app/scripts/**/*.coffee', ["browserify"])
  gulp.watch('app/scripts/**/*.hamlc',  ["browserify"])
  gulp.watch('app/*.haml', ["haml"]);
  gulp.watch('app/styles/**/*.scss', ["styles"]);
});

gulp.task('serve:dist', function() {
  browserSync({
    notify: false,
    port: 9000,
    server: {
      baseDir: [genv.dest]
    }
  });
});

gulp.task('cleanup:deps', ['usemin'], function() {
  return del([
    genv.dest + '/scripts/**',
    genv.dest + '/styles/**',
    genv.dest + '/*.haml'
  ]);
})

// Build the project for distribution
gulp.task('build', ['jshint', 'fonts', 'images', 'extras', 'cleanup:deps']);

// Clean all and build from scratch
gulp.task('default', ['clean'], function () {
  gulp.start('build');
});
