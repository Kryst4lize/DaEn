#! /bin/bash
cqlsh 172.21.20.241 9042 --username root --password 0JAXGpbEBAFxigHo86wrm1OB << EOF
show host
show version
describe keyspaces
cls
exit
EOF