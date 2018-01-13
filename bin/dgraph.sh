#!/bin/bash
set -ex

ZERO_ADDR=tasks.zero
if [[ "X${2}" != "X" ]];then
  ZERO_ADDR=${2}
fi

MY_IP=$(ip -o -4 addr |awk '/eth0/{print $4}' |awk -F/ '{print $1}')
if [[ "${1}" == "zero" ]];then
  dgraph zero --bindall=true --my=${MY_IP}:7080
elif [[ "${1}" == "server" ]]; then
  dgraph server --port_offset 1 --memory_mb=1024 --zero=${ZERO_ADDR}:7080 --my=${MY_IP}:7081 --idx 01234
elif [[ "${1}" == "ratel" ]]; then
  dgraph-ratel -p 8082
fi
