# laravel-boilerplate
Docker container to get started with Laravel 5, Nginx, Gulp.js, ES6 and more...

## What's inside

* PHP 5.6
* Laravel 5
* Nginx
* Node.js
* PostgreSQL
* Redis
* beanstalkd
* Blackfire Profiler

### Gulp.js build system

* Browserify (incl. Babel.js transpiler)
* SASS compilation
* Asset cache busting

## Prerequisites

Install [Docker](https://www.docker.com/) on your system.

* [Install instructions](https://docs.docker.com/installation/mac/) for Mac OS X
* [Install instructions](https://docs.docker.com/installation/ubuntulinux/) for Ubuntu Linux
* [Install instructions](https://docs.docker.com/installation/) for other platforms

Install [Docker Compose](http://docs.docker.com/compose/) on your system.

* Python/pip: `sudo pip install -U docker-compose`
* Homebrew: `brew install docker-compose`
* Others: ``curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose`` 

## Get up and running

0. Copy `app/.env.example` to `app/.env` so Docker (and later Laravel) can use it.

    ```bash
    $ cd code/laravel-boilerplate; cp app/.env.example app/.env
    ```

1. Build your Docker development container container: It will pull a [base image](https://registry.hub.docker.com/_/ubuntu/) from the Docker registry and install all necessary dependencies (This might take a while, depending on your host system).

    ```bash
    $ docker-compose build
    ```

2. Create and start the main Docker container and attach all linked containers. For your very first run, this will also take a while, because docker-compose first needs to pull the images for all linked containers.

    ```bash
    $ docker-compose up -d
    ```

3. Install PHP dependencies with [Composer](https://getcomposer.org), which you installed during step 1.

    ```bash
    $ docker-compose run --no-deps web composer update
    ```

4. Install Node.js dependencies with [npm](https://www.npmjs.com), which you did also install during the first step.

    ```bash
    $ docker-compose run --no-deps web npm install
    ```

5. Build all frontend Javascripts and CSS files from contents of `app/resources/assets` with [Gulp](http://gulpjs.com) through Laravel's [Elixir](http://laravel.com/docs/5.0/elixir).

    ```bash
    $ docker-compose run --no-deps web gulp
    ```

    What it does:

    * It compiles all [SASS](http://sass-lang.com) stylesheets inside `app/resources/assets/sass` to CSS.
    * It compiles Javascripts inside `app/resources/assets/js` with [Browserify](http://browserify.org). You can use ES6 and ES7 syntax and features, if you want. Browserify takes care of compiling everyhing to 100% browser compatible Javascript.
    * It versions the compiled `main.css` and `main.js`, so they won't accidentally get cached by the browser after when recompiled.

6. You can then access the app, which should then be running on your docker daemon, on standard HTTP port 80 (On OS X you can use `boot2docker ip` to find out the IP address). For convenience, I created a `localdocker.dev` entry in my `/etc/hosts` which points to that IP.

    ```bash
    $ open http://localdocker.dev
    ```

![Yay, we did it!](http://i.imgur.com/c0OQdjM.png)

7. If you run `gulp watch`, Gulp will automatically watch your assets and recompile them if changed.

    ```bash
    $ docker-compose run --no-deps web gulp watch
    ```

8. Go and build something awesome! :)

## Alternative Way

Instead of running steps 3) to 5), and 7) als `docker-compose` on/off commands, you can run them directly inside the container:

```bash
$ docker-compose run --no-deps web bash
root@ee746ce03589:/code/app $ composer update
...
root@ee746ce03589:/code/app $ npm install
...
root@ee746ce03589:/code/app $ gulp watch
```

This really is my preferred way, because it involves less typing and it feels more "natural", because you may need to initiate several commands via the CLI on a regular base (creating class skeletons, running database migrations etc.)

## Blackfire.io Support

If you want to use the [Blackfire](https://blackfire.io) profiler, we got you covered as well. Just fill in your Blackfire credentials in `app/.env` (after you copied it from `app/.env.example`) and you're good to go.

```bash
BLACKFIRE_SERVER_ID=YourBlackfireServerID
BLACKFIRE_SERVER_TOKEN=YourBlackfireServerToken
BLACKFIRE_CLIENT_ID=YourBlackfireClientID
BLACKFIRE_CLIENT_TOKEN=YourBlackfireClientToken
BLACKFIRE_LOG_LEVEL=4
```

For further information, please see Blackfire's [Getting Started](https://blackfire.io/getting-started) docs.

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
