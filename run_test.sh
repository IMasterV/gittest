#!/bin/bash
PLC_IP=$1

x=0
while [ $x -lt 10 ]
do
  if mkdir mylock; then
    echo "run_test.sh: locking succeeded $PLC_IP"
    /usr/bin/ssh-keygen -f ~/.ssh/known_hosts -R $PLC_IP || true
    ssh-keyscan -T 10 -t rsa $PLC_IP 2>/dev/null >>  ~/.ssh/known_hosts
    rm -Rf mylock
    x=$(( $x + 20 ))
  else
    echo "run_test.sh: locking failed $PLC_IP"
    sleep 1
  fi
done

sshpass -e ssh -o StrictHostKeyChecking=no root@$PLC_IP "python3 /home/root/scripts/somth.py"