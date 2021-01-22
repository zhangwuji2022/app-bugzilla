#!/bin/bash
echo "Config!"

sed -i '29s/apache/www-data/' localconfig
sed -i '53s/localhost/172.17.0.3/' localconfig
sed -i '60s/bugs/root/' localconfig
sed -i 67s#\'\'#\'bugsopenEuler\'#  localconfig
sed -i 73s#db_port\ =\ 0#db_port\ =\ 3306#  localconfig

