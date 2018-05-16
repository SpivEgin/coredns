#!/bin/bash

cd /opt/dns/
adfree init --url=https://raw.githubusercontent.com/adbegon/sourcelist/master/adfreezone.list.txt
coredns
