#!/usr/bin/env bash

iface=$(ip route | awk '/default/ {print $5; exit}') || { echo "--/--"; exit; }

rx1=$(< /sys/class/net/$iface/statistics/rx_bytes)
tx1=$(< /sys/class/net/$iface/statistics/tx_bytes)
sleep 1
rx2=$(< /sys/class/net/$iface/statistics/rx_bytes)
tx2=$(< /sys/class/net/$iface/statistics/tx_bytes)

down=$(( (rx2 - rx1) * 8 ))   # Bits/s
up=$(( (tx2 - tx1) * 8 ))     # Bits/s


format_speed() {
    local value=$1
    if (( value < 1000 )); then
        echo "${value} bit/s"
    elif (( value < 1000*1000 )); then
        awk -v v="$value" 'BEGIN { printf "%.1f kbit/s", v/1000 }'
    elif (( value < 1000*1000*1000 )); then
        awk -v v="$value" 'BEGIN { printf "%.1f Mbit/s", v/1000000 }'
    else
        awk -v v="$value" 'BEGIN { printf "%.1f Gbit/s", v/1000000000 }'
    fi
}


bitDown=$(format_speed $down)
bitUp=$(format_speed $up)

echo "<span color='#cb8ae4'> ${bitUp}</span>&#10;<span color='#2596be'> ${bitDown}</span>"
