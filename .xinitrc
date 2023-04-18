# fcitx5
fcitx5 -d

picom &

nitrogen --restore

# set statusbar
while true
do
    VO=`amixer get Master | awk -F'[][]' '/Left:/ { print $2 }' | awk -F'%' '{ print $1 }'`
    DA=`date "+%m-%d %H:%M:%S"`
    xsetroot -name "音量：${VO} 时间：${DA}"
    sleep 1s
done &

exec dwm
