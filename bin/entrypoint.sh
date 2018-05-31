#!/usr/bin/env bash

set -e

export SPA_ENV_ENABLED=1

LIVE_JS_PATH="/usr/share/nginx/html/spa-env.js"
LIVE_JS_HEADER="(function () {window['__spa'] = window['__spa'] || {};  window['__spa'].env = "
LIVE_JS_FOOTER=";})();"

rm -f $LIVE_JS_PATH;

# -a parameter to jq enforces ascii output
LIVE_JS_OBJ=`printenv | grep "^SPA_.*=.*$" | jq -a -R . | jq -a -c -s '.'`

echo "$LIVE_JS_HEADER$LIVE_JS_OBJ$LIVE_JS_FOOTER" > $LIVE_JS_PATH;

exec "$@"
