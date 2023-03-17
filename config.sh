#!/bin/bash
# load secrets from parent then here.
# might need to be done differently if used outside unified_network
source ../.env || true
source .env || true

HOSTNAME=$1
IP="$(dig +short @192.168.1.1 ${HOSTNAME})"

MQTT_TOPIC=${DEVICENAME}
MQTT_USER=${MQTT_USER:-default_user}
MQTT_PASSWORD=${MQTT_PASSWORD:-}

if [[ -z ${TASMOTA_USERNAME:-} ]]; then
  echo "WARNING: No tasmota username.  this is probably broken"
fi

if [[ -z ${TASMOTA_PASSWORD:-} ]]; then
  echo "WARNING: No tasmota password.  this is probably broken"
fi

if [[ $MQTT_PASSWORD == "" ]]; then
  echo "WARNING: Empty password.  Not going to stop but you should really use one."
fi

MQTT_HOST=debian
MQTT_HOST=192.168.1.188

# Be really careful with semicolon.  Would be better if I used join, but it's not simple in bash.
options=()
options+=("Backlog ")
options+=("hostname ${HOSTNAME}")
options+=("topic ${HOSTNAME}")
options+=("Timezone 99")
options+=("TimeStd 0,1,11,1,2,-300")
options+=("TimeDst 0,2,3,1,2,-240") # America/New_York
options+=("setOption 52") # - be pedantic about iso8601
options+=("time 0")
options+=("deviceName ${HOSTNAME}")
options+=("friendlyname1 ${HOSTNAME}")
options+=("MqttHost ${MQTT_HOST}")
options+=("MqttUser ${MQTT_USER}")
options+=("MqttPassword ${MQTT_PASSWORD}")
options+=("Topic ${MQTT_TOPIC}")
options+=("SetOption53 1")
options+=("PowerRetain on")

joined_options=""
for item in "${options[@]}"
do
  joined_options+="$item; "
done
curl "http://${TASMOTA_USERNAME}:${TASMOTA_PASSWORD}@${IP}/cm" --data-urlencode "cmnd=${joined_options}"


