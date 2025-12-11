#!/bin/bash

set -e

openapi-generator-cli generate \
  -i ./api/crawl4ai-openapi.json \
  -g rust \
  -o ./api/crawl4ai-client \
  -t ./templates
  
rm -rf ./src/generated/apis
rm -rf ./src/generated/models
cp -r ./api/crawl4ai-client/src/apis ./src/generated/apis
cp -r ./api/crawl4ai-client/src/models ./src/generated/models
rm -rf ./api/crawl4ai-client

cargo fmt
