#!/usr/bin/env sh

mkdir -p /opt

INSTALL_PATH=/opt/kibana-${KIBANA_VERSION}-linux-x64

wget -O - "http://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz" | tar xfz - -C /opt

echo "Add group and user 'kibana'"
addgroup kibana
adduser -D -s /bin/false -S -G kibana kibana

chown -R kibana:kibana $INSTALL_PATH

sed -i "s!^NODE=.*!NODE=\"/usr/bin/nodejs\"!g" $INSTALL_PATH/bin/kibana

sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 'http://elasticsearch:9200'!" $INSTALL_PATH/config/kibana.yml
grep -q 'elasticsearch:9200' $INSTALL_PATH/config/kibana.yml
