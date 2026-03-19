#!/bin/bash

java -Xms1g -Dfile.encoding=UTF-8 -Dapple.awt.UIElement=true \
  -jar ~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-8.4.1-2026-02-03-e9f77eeaa/bin/monkeybrains.jar \
  -o bin/garminqrcode.prg \
  -f "$(pwd)/monkey.jungle" \
  -y ~/.Garmin/keys/developer_key \
  -d instincte45mm_sim -w
