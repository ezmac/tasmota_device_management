#!/bin/bash
#tasmotas=(dehumidifier bluetoothreceiver roku cattoy) #xbox   I don't wanna reboot right now.
tasmotas=( aircon xbox ) #xbox   I don't wanna reboot right now.

# should be your local host.  you can get it better, but this whole thing could be rewritten.
# 
OTAHost="http://192.168.1.115:8000"

# Fill this in with ordered bins to flash.  the order and suggested ones are on the tasmota documentation site.
upgradePaths=("tasmota-11.1.0-minimal.bin.gz" "tasmota-11.1.0.bin")

for upgradePath in ${upgradePaths[@]}; do
  for tasmota in ${tasmotas[@]}; do
  set -x
    docker run -t -v $PWD/.home:/root/ hivemq/mqtt-cli pub -h ${MQTT_HOST} -p 1883 --topic cmnd/$tasmota/OtaUrl -m "${OTAHost}/${upgradePath}"
    sleep 10
    docker run -t -v $PWD/.home:/root/ hivemq/mqtt-cli pub -h ${MQTT_HOST} -p 1883 --topic cmnd/$tasmota/Upgrade -m 1
  done
  set +x
  echo "finished with $upgradePath; resting 2 minutes"
  sleep 120
done
