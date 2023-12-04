#!/bin/bash
cd executor || { echo "Failure: executor directory not found!"; exit 1; }
curl -H  "Content-Type: application/json" -X POST -d @file.json 'https://portal.muuktest.com:8081/generate_token_executer' -o "token.json"
curl -X POST https://portal.muuktest.com:8081/api/v1/downloadpwfiles -k -d @file.json -H "Content-Type: application/json" -o ./config.zip
unzip -o config.zip -d .
MUUK1_TOKEN=$(jq --raw-output .token token.json)
printf "Authorization: Bearer %s" "$MUUK1_TOKEN" > header.txt
MUUK_USERID_TOKEN=$(jq --raw-output .userId token.json)
FIXED_TAG_VALUE=$MUUKTEST_TAG_VALUE
[[ $FIXED_TAG_VALUE != "#"* ]] && FIXED_TAG_VALUE="#$FIXED_TAG_VALUE"
printf '{"property": "%s", "value": ["%s"], "platform": "pw", "userId": "%s"}' "$MUUKTEST_TAG_PROPERTY" "$FIXED_TAG_VALUE" "$MUUK_USERID_TOKEN" > body.json
curl -X POST https://portal.muuktest.com:8081/download_byproperty -H @header.txt -d @body.json -H "Content-Type: application/json" -o ./test.zip
[ -d "./test" ] && rm -r test
unzip -o test.zip -d ./test
ls -l
