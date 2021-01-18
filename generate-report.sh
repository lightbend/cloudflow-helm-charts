#!/bin/bash
set -euo pipefail

REPORT_NAME="$1"

REPORT_PAYLOAD=$(mktemp /tmp/report-payload.json.XXXXXX)

# Create report payload header
cat > $REPORT_PAYLOAD << EOF
{
  "name": "${REPORT_NAME}",
  "resources": {
    "repositories": [
      {
        "name": "docker-local",
        "include_path_patterns": [
EOF

# Tag and push the images to JFrog Artifactory for scanning
while read IMAGE TAG; do
    echo "Pushing $IMAGE:$TAG to JFrog Artifactory"
    JFROG_IMAGE="${IMAGE//./-}"
    docker pull "$IMAGE:$TAG"
    docker tag "$IMAGE:$TAG" "lightbendcloudflow-docker-local.jfrog.io/$JFROG_IMAGE:$TAG"
    docker push "lightbendcloudflow-docker-local.jfrog.io/$JFROG_IMAGE:$TAG"

    # Add path pattern for image to report payload
    echo "          \"/${JFROG_IMAGE}/${TAG}/*\"," >> $REPORT_PAYLOAD
done

# Remove the trailing comma from the last path pattern
sed -i '$ s/.$//' $REPORT_PAYLOAD

# Add report payload footer
cat >> $REPORT_PAYLOAD << EOF
        ]
      }
    ]
  }
}
EOF

# Wait for Artifactory to recognise any new images
sleep 10

echo ""
echo "Final report payload:"
cat $REPORT_PAYLOAD

echo ""

# Submit report for processing
REPORT_ID=$(curl -s -H "Content-Type: application/json" -XPOST -d @$REPORT_PAYLOAD \
    --user ${JFROG_USERNAME}:${JFROG_API_KEY} \
    https://lightbendcloudflow.jfrog.io/xray/api/v1/reports/vulnerabilities |
    grep -oP '(?<="report_id":)[0-9]+')


echo "${REPORT_ID}"
    
rm $REPORT_PAYLOAD

# echo "$IMAGES"