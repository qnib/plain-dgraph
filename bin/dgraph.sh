#!/bin/bash
set -ex

: "${DGRAPH_ZERO_ADDR:=tasks.zero}"
: "${DGRAPH_IDX:=1}"


if [[ "X${2}" != "X" ]];then
  DGRAPH_ZERO_ADDR=${2}
fi

MY_IP=$(ip -o -4 addr |awk '/eth0/{print $4}' |awk -F/ '{print $1}')
if [[ "${1}" == "zero" ]];then
  dgraph zero --bindall=true --my=${MY_IP}:7080
elif [[ "${1}" == "server" ]]; then
  dgraph server --port_offset 1 --memory_mb=1024 --zero=${DGRAPH_ZERO_ADDR}:7080 --my=${MY_IP}:7081 --idx ${DGRAPH_IDX}
elif [[ "${1}" == "ratel" ]]; then
  dgraph-ratel -p 8082
fi
