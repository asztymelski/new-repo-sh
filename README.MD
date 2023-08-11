readme2

#!/bin/bash

# GitHub API endpoint for creating a repository
API_URL="https://api.github.com/user/repos"

# Your GitHub Personal Access Token
TOKEN="YOUR_ACCESS_TOKEN"

# Repository name
REPO_NAME="new-repo"

# Other optional parameters
DESCRIPTION="My new repository"
PRIVATE="true"  # Set to "false" for public repository
HAS_ISSUES="true"

# JSON payload for creating the repository
JSON_DATA=$(cat <<EOF
{
  "name": "$REPO_NAME",
  "description": "$DESCRIPTION",
  "private": $PRIVATE,
  "has_issues": $HAS_ISSUES
}
EOF
)

# Create the repository using GitHub API
curl -X POST "$API_URL" \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -d "$JSON_DATA"
