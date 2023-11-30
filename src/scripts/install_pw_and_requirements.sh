#!/bin/bash
cd executor || { echo "Failure: executor directory not found!"; exit 1; }
npm install -D @playwright/test
npx playwright install --with-deps "$MUUKTEST_BROWSER"
npm install axios
npm install archiver
npm install cheerio
npm install xpath
npm install @xmldom/xmldom