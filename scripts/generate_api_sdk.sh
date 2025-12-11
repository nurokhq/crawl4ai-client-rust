#!/bin/bash

set -e

openapi-generator-cli generate \
  -i ./api/crawl4ai-openapi.json \
  -g rust \
  -o ./api/crawl4ai-client \
  -t ./templates
  
# find ./api/crawl4ai-client -type f -name "*.rs" -exec sed -i '' 's/use crate::models;/use crate::generated::models;/g' {} \;
# find ./api/crawl4ai-client -type f -name "*.rs" -exec sed -i '' 's/crate::apis/crate::generated::apis/g' {} \;
# find ./api/crawl4ai-client -type f -name "*.rs" -exec sed -i '' 's/use crate::{apis::ResponseContent, models};/use crate::generated::{apis::ResponseContent, models};/g' {} \;

rm -rf ./src/generated/apis
rm -rf ./src/generated/models
cp -r ./api/crawl4ai-client/src/apis ./src/generated/apis
cp -r ./api/crawl4ai-client/src/models ./src/generated/models
rm -rf ./api/crawl4ai-client

cargo fmt
