#!/bin/bash

# In case that `REPO DESCRIPTION` doesn't contain one of the cases insensitive choices.
# Choices are: react, django, phoenix, and fastapi.
export SELECTED_FRAMEWORK_NAME=$(echo "react|django|phoenix|fastapi" | grep -E -i -o -w "$REPO_DESCRIPTION")
export SELECTED_APP=$([[ -z "$SELECTED_FRAMEWORK_NAME" ]] && echo "django" || echo "$SELECTED_FRAMEWORK_NAME")

# Check that environment varialbes were correctly set.
echo "REPO_DESCRIPTION: $REPO_DESCRIPTION"
echo "REPO_NAME: $REPO_NAME"
echo "SELECTED_APP: $SELECTED_APP"
echo "SELECTED_FRAMEWORK_NAME: $SELECTED_FRAMEWORK_NAME"

# Temp file to keep selected-app files.
mkdir ./selected-app
mv ./templates/$SELECTED_APP-app/* ./selected-app

# Remove unecessary files from `cookier-cutter` project.
find ./ -maxdepth 1 -regextype posix-extended  -not -regex "./.git|./|./selected-app" -exec rm -fr {} +
mv ./selected-app/* ./
rm -fr ./selected-app

# Substituting variables in the selected project.
find ./ -type f -exec sed -i "s/<REPO_NAME>/$REPO_NAME/g" {} +
find ./ -type f -exec sed -i "s/<REPO_DESCRIPTION>/$REPO_DESCRIPTION/g" {} +
