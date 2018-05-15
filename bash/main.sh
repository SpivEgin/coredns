#!/bin/bash

cd /opt/dns/
wget -O adfreezone.list https://raw.githubusercontent.com/adbegon/sourcelist/master/adfreezone.list.txt
adfree init 
coredns
