#!/bin/bash

API_URL="https://api.github.com/user/repos"
TOKEN="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"

echo "Please provide the name of repo?"
read REPO_NAME

echo "Please enter a repo description (SINGLE WORD ..or...separate with hyphens): "
read DESCRIPTION

echo "what is the absolute path to your local project directory?"
read PROJECT_PATH

echo "What is your github username?"
read USERNAME

echo "This repository should be private? Type true or false"
read PRIVATE


# Create the repository func
create_repository(){

JSON_DATA=$(cat <<EOF
{
"name": "$REPO_NAME",
"description": "$DESCRIPTION",
"private": $PRIVATE
}
EOF
)

echo $JSON_DATA
  # response=$(curl -s -X POST "https://api.github.com/user/repos" \
  #     -H "Authorization: Bearer $TOKEN" \
  #     -d "{\"name\":\"$REPO_NAME\",\"description\":\"$DESCRIPTION\",\"private\":$PRIVATE}")

  response=$(curl -X POST "$API_URL" -H "Authorization: Bearer $TOKEN" -d "$JSON_DATA")

# Check if repository creation was successful
  if [[ "$response" =~ "created_at" ]]; then
      echo "--------------------------------------------------------------"
      echo "  Repository '$REPO_NAME' created successfully!"
      echo "  URL: https://github.com/$USERNAME/$REPO_NAME.git          |"
      echo "--------------------------------------------------------------"
  else
      echo "-----------------------------------------------------"
      echo "    Error creating repository:" 
      echo $response
      echo "-----------------------------------------------------"
  fi
}

if [ ! -d "$PROJECT_PATH" ]; then
    echo "-------------------------------------------------------------"
    echo "     Directory '$PROJECT_PATH' does not exist. Creating..."
    echo "-------------------------------------------------------------"
    mkdir -p "$PROJECT_PATH"
fi


cd "$PROJECT_PATH" || exit

# Initialize Git repository
if [ -d ".git" ]; then
    echo "------------------------------------------------------"
    echo "  Git repository already exists in '$PROJECT_PATH'    "
    echo "------------------------------------------------------"
else
    git init
    #touch README.md sonar-project.properties
    echo sonar.projectKey=com.dupa.kabanos-${REPO_NAME} > sonar-project.properties
    echo -e "${REPO_NAME}\n${DESCRIPTION}" > README.md
    git add .
    git commit -m 'Initial commit - setup repo with bash script'
    git branch -M main
    create_repository
    git remote add origin git@github.com:${USERNAME}/${REPO_NAME}.git
    git push --set-upstream origin main
fi
