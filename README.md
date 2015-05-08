# laravel-boilerplate
Docker container to get started with Laravel 5, Gulp.js, ES6 and more...

## Prerequisites

Install [Docker](https://www.docker.com/) on your system.

* [Install instructions](https://docs.docker.com/installation/mac/) for Mac OS X
* [Install instructions](https://docs.docker.com/installation/ubuntulinux/) for Ubuntu Linux
* [Install instructions](https://docs.docker.com/installation/) for other platforms

Install [Docker Compose](http://docs.docker.com/compose/) on your system.

* Python/pip: `sudo pip install -U docker-compose`
* Others: ``curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose`` 

## Get up and running

1. Build your Docker development container container: It will pull a base image from the Docker registry and install all necessary dependencies (This might take a while, depending on your host system).

    ```bash
    $ cd code/laravel-boilerplate; docker-compose build
    ```

2. Install PHP dependencies with [Composer](https://getcomposer.org), which you installed during step 1.

    ```bash
    $ docker-compose run web composer update
    ```

3. Install Node.js dependencies with [npm](https://www.npmjs.com), which you did also install during the first step.

    ```bash
    $ docker-compose run web npm install
    ```

4. Build all frontend Javascripts and CSS files from contents of `app/resources/assets` with [Gulp](http://gulpjs.com) through Laravel's [Elixir](http://laravel.com/docs/5.0/elixir).

    ```bash
    $ docker-compose run web gulp
    ```

    What it does:

    * It compiles all [SASS](http://sass-lang.com) stylesheets inside `app/resources/assets/sass` to CSS.
    * It compiles Javascripts inside `app/resources/assets/js` with [Browserify](http://browserify.org). You can use ES6 and ES7 syntax and features, if you want. Browserify takes care of compiling everyhing to 100% browser compatible Javascript.
    * It versions the compiled `main.css` and `main.js`, so they won't accidentally get cached by the browser after when recompiled.

5. Copy `app/.env.example` to `app/.env` so Laravel can use it.

    ```bash
    $ cp app/.env.example app/.env
    ```

6. You can finally launch your Docker container which will start the dev web server.

    ```bash
    $ docker-compose up
    ```

    The app should then be running on your docker daemon on port 8000 (On OS X you can use `boot2docker ip` to find out the IP address). For convenience, I created a `localdocker` entry in my `/etc/hosts` which points to that IP.

    ```bash
    $ open http://localdocker:8000
    ```

7. In a second shell, you can then run `gulp watch` to let Gulp automatically watch your assets and recompile them if they've changed.

    ```bash
    $ docker-compose run web gulp watch
    ```

8. Go and build something awesome! :)

## Maintainer

Pascal Cremer

* Email: <hello@codenugget.co>
* Twitter: [@b00gizm](https://twitter.com/b00gizm)
* Web: [http://codenugget.co](http://codenugget.co)

## License

> The MIT License (MIT)
>
> Copyright (c) 2015 Pascal Cremer
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all
>copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>SOFTWARE.
