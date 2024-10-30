ARCHITECTURE=$(uname -a)
CPU_PHYSICAL=$(grep "physical id" /proc/cpuinfo | wc -l)
CPU_VIRTUAL=$(grep "processor" /proc/cpuinfo | wc -l)
MEMORY_USAGE=$(free -m | awk '$1 == "Mem:" {printf("%s/%sMB (%.2f%%)", $3, $2, $3/$2*100)}')
DISK_USAGE=$(df -m | grep "root" | awk '{printf("%s/%.2sGB (%.2f%%)", $3, $2, $3/$2*100)}')
CPU_LOAD=$(vmstat | tail -1 | awk '{printf("%s%%", $15)}')
LAST_BOOT=$(who -b | awk '{printf("%s %s", $3, $4)}')
LVM_USE=$(lsblk | grep "lvm" | wc -l | awk '{printf("%s", $1 > 0 ? "yes": "no")}')
CONNECTION_TCP=$(ss -ta | grep ESTAB | wc -l | awk '{printf("%d ESTABLISHED", $1)}')
USER_LOG=$(users | wc -w)
CONNECTIONS=$(ip a show | grep ": <" | cut -d : -f2)
SUDO=$(cat /var/log/sudo/history.log | grep "COMMAND" | wc -l)

echo "#Architecture: $ARCHITECTURE";
echo "#CPU physical: $CPU_PHYSICAL";
echo "#vCPU: $CPU_VIRTUAL";
echo "#Memory Usage: $MEMORY_USAGE";
echo "#Disk Usage: $DISK_USAGE";
echo "#CPU load: $CPU_LOAD";
echo "#Last boot: $LAST_BOOT";
echo "#LVM use: $LVM_USE";
echo "#Connections TCP: $CONNECTION_TCP";
echo "#User log: $USER_LOG";
for CONNECTION in $CONNECTIONS; do
    IP=$(ip a show $CONNECTION | grep "inet " | awk '{print $2}' | cut -d / -f1)
    MAC=$(ip a show $CONNECTION | grep "link/ether" | awk '{print $2}')
    if [[ $IP && $MAC ]]; then
        echo "#Network: IP $IP ($MAC)";
    fi
done
echo "#Sudo: $SUDO";