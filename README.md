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

- [ ] errors on build for some reason around usemin.
- [ ] add jadeify for templating.
- [ ] env should reference backbone/marionette/etc from bower, not npm. remove npm fe dependencies.  possibly use debowerify transform.
- [ ] test font includes.
- [ ] autoprefixer.
- [ ] consider gulp-include for managing the file tree of various apps.

## Setup

    $ npm install
    $ bower install
    $ gulp serve

Do not forget to install globally gulp if not installed yet.

## Build

If you want to build the project run.

    $ gulp build

It will compile the project and put the result under `dist` directory. You can run the compiled project also.

    $ gulp serve:dist

## Licence

Licensed under the MIT license.
