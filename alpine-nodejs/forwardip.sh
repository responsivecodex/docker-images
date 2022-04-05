#!/bin/ash
if [ -e /etc/sysctl.d/ipv4.conf ]
then
    isInFile=$(cat /etc/sysctl.d/ipv4.conf | grep -c "net.ipv4.ip_forward = 1")
    if [ $isInFile -eq 0 ]; then
        # code if found
        echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/ipv4.conf
        sysctl -p /etc/sysctl.d/ipv4.conf
        iptables -P FORWARD ACCEPT
        echo "Finish forwarding..."
    else
        # code if not found
        echo "Already configurated:  Forwarding IP"
    fi
else
   # code if found
    echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/ipv4.conf
    sysctl -p /etc/sysctl.d/ipv4.conf
    iptables -P FORWARD ACCEPT
    echo "Finish forwarding..."
fi


/bin/ash