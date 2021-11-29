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
git clone https://github.com/lucamug/training
cd training
```

For the webserver, there are two main options:

### 1. Elm Reactor

* Execute

```
elm reactor
```

Access http://localhost:8000/src/Main.elm

### 2. Elm Go

* Execute

```
elm-go src/Main.elm --dir=docs --start-page=200.html --pushstate --hot -- --output=docs/elm.js --debug
```

Access http://localhost:8000/

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

* You can deploy the docs folder using your favorite system. If you have a Surge account you can run this command (change "your-sub-domain" to something else):

```
surge docs your-sub-domain.surge.sh
```

You should then be able to access the Elm app at

https://your-sub-domain.surge.sh/


## Notes about Windows

* Install git https://git-scm.com/downloads
* Install NodeJs and the npm modules as explained in the [README.md](README.md).

In Windows is better to use the Git Bash terminal (installed together with git) instead of the Windows shell.

If the commands installed with npm are not working, is probably because the path is missing.

Check https://stackoverflow.com/questions/30710550/node-js-npm-modules-installed-but-command-not-recognized

## More info

More info at https://confluence.rakuten-it.com/confluence/x/7smNmw

# **❤️😃 HAPPY CODING! 😃❤️**
