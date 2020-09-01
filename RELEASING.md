## Releasing a new version of the Cloudflow Helm charts

This guide shows how to release a new version of the Cloudflow Helm charts.

Make sure that you have Helm v3 or later installed before proceeding.

1. Checkout the repo, create a new branch from the master branch
1. Make any changes needed to the Helm chart.
1. Make sure to update both the `version` and `appVersion` in the `Chart.yaml` file.
1. Package the new version using the following command:
    - `helm package cloudflow -d charts/`
    
    This creates a new compressed archive with the current version of the chart.
    Add this file to your commit to git.
1. Update the repo index using the following command:
    - `helm repo index charts`
  
    This adds the new version of the chart to the index file read by Helm to find chart versions.
1. Commit the new compressed repo in `charts/` and all updated files, and push the branch to Github.
1. Create a PR in Github detailing the changes and assign a committer to review the changes.
1. Done
