#!/usr/bin/env zsh

function get_bytes {
    # Find active network interface
    interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
    line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
    eval $line
    now=$(date +%s%N)
}

function get_velocity {
    value=$1
    old_value=$2
    now=$3

    timediff=$(($now - $old_time))
    velKB=$(echo "1000000000*($value-$old_value)/1024/$timediff" | bc)
    if test "$velKB" -gt 1024
    then
        echo $(echo "scale=2; $velKB/1024" | bc)MB/s
    else
        echo ${velKB}KB/s
    fi
}

# Get initial values
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

check_connect(){
    interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
    line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
    sped=$(echo $line | sed -r "s/.*=(.*).*/\1/")
    if ["$sped" -eq 0]; then
        printf ""
    else
        printf ""
    fi
}

print_mem(){
    memfree=$(($(grep -m1 'Cached:' /proc/meminfo | awk '{print $2}') / 1024))
    echo -e "$memfree"
}


print_date(){
    date '+%m/%d | %H:%M'
}


dwm_alsa () {
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    printf "%s" "$SEP1"

    if [ "$VOL" -eq 0 ]; then
        printf "婢"
    elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
        printf "奄 %s" "$VOL"
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
        printf "奔 %s" "$VOL"
    else
        printf "墳 %s" "$VOL"
    fi

    printf "%s\n" "$SEP2"
}


get_bytes

# Calculates speeds
vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

xsetroot -name " $(print_mem) MB | $(check_connect) ⬇$vel_recv ⬆$vel_trans | $(dwm_alsa) |  $(print_date)"

exit 0
