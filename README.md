# Frontend Boilerplate

Simple boilerplate for building static sites in marionette.

included:

- browser-sync
- Gulp
- Browserify
- Coffeeify
- Foundation
- jQuery
- Lodash
- Backbone
- Marionette
- Hamlc
- Usemin

This is originally inspired by [ES6 Marionette](https://github.com/abiee/es6-marionette) gulpfile.

## Todo

- [ ] add jadeify for templating.
- [x] add debowerify
- [ ] add [https://github.com/taptapship/wiredep](https://github.com/taptapship/wiredep) for index file deps.
- [ ] test font includes.
- [ ] autoprefixer.
- [ ] consider gulp-include for managing the file tree of various apps.

## Setup

Make sure you have node version 0.12.x.  Usemin and some other libs throw errors without it.

~~~
$ npm install
$ bower install
$ gulp serve
~~~

Do not forget to install globally gulp if not installed yet.  And in case of emergency:

~~~
$ npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install
~~~

## Build

If you want to build the project run.

~~~
$ gulp build
~~~

It will compile the project and put the result under `dist` directory. You can run the compiled project also.

~~~
$ gulp serve:dist
~~~

## Licence

Licensed under the MIT license.
