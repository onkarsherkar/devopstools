#!/bin/bash
# Check if the script is run inside a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
echo "Error: This is not a Git repository. Please run this script
inside a Git repository."
exit 1
fi
# Check for changes in the repository
if git diff --quiet && git diff --cached --quiet; then
echo "No changes detected in the repository. Exiting."
exit 0
fi
# Prompt for a new branch name
read -p "Enter the name of the new branch: " branch_name
# Create a new branch
git checkout -b "$branch_name"
if [ $? -ne 0 ]; then
echo "Error: Failed to create a new branch. Exiting."
exit 1
fi
# Stage all changes
git add .
# Prompt for a commit message
read -p "Enter the commit message: " commit_message
# Commit the changes
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
echo "Error: Failed to commit changes. Exiting."
exit 1
fi

# Push the new branch to the remote repository
git push origin "$branch_name"
if [ $? -eq 0 ]; then
echo "Changes successfully pushed to the new branch
'$branch_name'."
else
echo "Error: Failed to push the branch. Please check your remote
repository settings."
exit 1
fi