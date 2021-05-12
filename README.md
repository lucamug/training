# Functional Programming with Elm - Basics

## Development Environment

* Install Node.js: https://nodejs.org/en/download/
* Execute these commands to install other tools:

```
npm i -g elm
npm i -g elm-format
npm i -g elm-go
npm i -g terser
```

If you get permission error installing there packages globally, follow one of these three steps: http://npm.github.io/installation-setup-docs/installing/a-note-on-permissions.html

* Clone the repository and cd in it

```
git clone https://git.rakuten-it.com/scm/elm/training.git
cd training
```

For the webserver, there are two main options. In both cases you can access the app at http://localhost:8000/ once the server started.

### 1. Elm Reactor

* Now you can start the Elm built-in web server with:

```
elm reactor
```

### 2. Elm Go

* Alternatively you can use `elm-go` as web server:

```
elm-go src/Main.elm --dir=docs --start-page=200.html --pushstate --hot -- --output=docs/elm.js --debug
```

This activate several extra features such as:

* Use a specific HTML page (`docs/200.html`)
* Ignore the path of the URL, so that it works with SPA based on `history.pushState`
* Activate hot reload. The page change without the browser reloading it
* Activate the Elm debugger

This command is also available as

```
cmd/start
```

## Deployment Process

* Run these optional commands to generate an optimized version of the JavaScript and to minify it. This will remove the Elm debugger. Skip this step if you would like to keep the Elm debugger in the deployed version.

```
elm make src/Main.elm --optimize --output=docs/elm.js

terser docs/elm.js --no-rename --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters=true,keep_fargs=false,unsafe_comps=true,unsafe=true,passes=2' --mangle --output=docs/elm.js
```

These commands are also available as

```
cmd/build
```

* You can deploy the docs folder using your favorite system. If you have a Surge account you can

```
surge docs you-sub-domain.surge.sh
```

These commands are also available as

```
cmd/publish
```

## More info

More info at https://confluence.rakuten-it.com/confluence/x/w-FJnQ
If you have Windows, read [WINDOWS.md](WINDOWS.md)

# **❤️😃 HAPPY CODING! 😃❤️**
