# Synopsis

This Dockerfile will allow one to build a generic nginx container that
serves static content from
```
/usr/share/nginx/html
```

The benefit to using this is that it will allow passing of environmental
variables from docker all the way through to a JavaScript web application.

This is useful for instances when you must control some parameters in a
JavaScript application based on the docker environment.

# Usage

The environmental variables must start with ```SPA_```.
They will be processed by jq into a JS file ```spa-env.js``` inside
of ```/usr/share/nginx/html```.

NOTE that any existing ```spa-env.js``` copied into this directory will be removed.

This JS file, as a result, will be available from the web application to load
via ```<script>```. The JS file exports all of the found environmental variables
into the ```window.__spa.env``` object

# Example
Set the following environmental variable via the docker run command or docker-compose:
```
SPA_HELLO_WORLD=Yes
```

This environmental will then be available under the ```window.__spa_env.env```
object, accessible as ```window.__spa.env['SPA_HELLO_WORLD']```

# Inheriting
To inherit from this Dockerfile within your projects, use the following template:
```
FROM docker-nginx-spa:1.0.0

MAINTAINER Yalda Kako <ykako@pavlovmedia.com>

# Copy our compiled SPA files
COPY ./target/dist /usr/share/nginx/html

EXPOSE 80 443
```