#!/bin/sh
set -e
PORT_VAL="${PORT:-3000}"
if [ -z "$XRAY_UUID" ] || [ -z "$XRAY_WS_PATH" ]; then
  echo "XRAY_UUID and XRAY_WS_PATH env vars are required" >&2
  exit 1
fi
sed -e "s/__PORT__/$PORT_VAL/" -e "s/__UUID__/$XRAY_UUID/" -e "s#__WS_PATH__#$XRAY_WS_PATH#" \
  /etc/xray/config.template.json > /etc/xray/config.json
exec /usr/bin/xray -c /etc/xray/config.json
