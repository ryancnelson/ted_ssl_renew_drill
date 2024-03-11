#!/bin/bash

for name in `cat /Users/ryan/check-ted-domains.list.txt ` ; do echo $name ------------------;   timeout 5  bash check_expiration.sh $( timeout 5 openssl s_client -connect $name:443 -servername $name < /dev/null 2>/dev/null | timeout 5 openssl x509 -noout -dates  2>/dev/null | grep notAfter );  done
