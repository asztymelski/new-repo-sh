# Make executable with chmod +x <<filename.sh>>

CURRENTDIR=${pwd}

echo "Please provide the name of repo?"
read REPO_NAME

echo "Please enter a repo description (SINGLE WORD ..or...separate with hyphens): "
read DESCRIPTION

echo "what is the absolute path to your local project directory?"
read PROJECT_PATH

echo "What is your github username?"
read USERNAME

cd "$PROJECT_PATH"

# initialise the repo locally, create blank README, add and commit
git init
touch README.MD
git add README.MD
git commit -m 'initial commit - setup repo with .sh script'


# use github API to log the user in
curl -u ${USERNAME} https://api.github.com/user/repos -d "{\"name\": \"${REPO_NAME}\", \"description\": \"${DESCRIPTION}\"}"

#  add the remote github repo to local repo and push
git remote add origin https://github.com/${USERNAME}/${REPO_NAME}.git
git push --set-upstream origin main

# change to your project's root directory.
cd "$PROJECT_PATH"

echo "Done. Go to https://github.com/$USERNAME/$REPO_NAME to see." 
echo " *** You're now in your project root. ***"
