#!/bin/bash

java -Xms1g -Dfile.encoding=UTF-8 -Dapple.awt.UIElement=true \
  -jar "$(find ~/.Garmin/ConnectIQ/Sdks/ -name "monkeybrains.jar" | grep bin | tail -1)" \
  -o bin/garminqrcode.prg \
  -f "$(pwd)/monkey.jungle" \
  -y ~/.Garmin/keys/developer_key \
  -d instincte45mm_sim -w
