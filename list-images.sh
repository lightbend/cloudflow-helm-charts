#!/bin/bash
set -euo pipefail

for image in $(grep -oP '([a-zA-Z]+)(?=Image)' cloudflow-enterprise-components/values.yaml ); do
    echo $(grep -oP "(?<=${image}Image: ).*" cloudflow-enterprise-components/values.yaml | tr -d "\"") \
        $(grep -oP "(?<=${image}Version: ).*" cloudflow-enterprise-components/values.yaml | tr -d "\"")
done

echo $(grep -oP "(?<=image: ).*" cloudflow-enterprise-components/values.yaml | tr -d "\"") \
    $(grep -oP "(?<=version: ).*" cloudflow-enterprise-components/values.yaml | tr -d "\"")