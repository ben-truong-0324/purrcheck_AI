#!/bin/bash

# Get current branch name
branch_name=$(git symbolic-ref --short HEAD)
echo "Current branch: $branch_name"

# Prompt for commit message until a non-empty one is entered
while true; do
    read -p "Enter commit message: " commit_message
    if [ -n "$commit_message" ]; then
        break
    else
        echo "Commit message cannot be empty. Please try again."
    fi
done

# Add all changes
git add .

# Commit with the provided message
git commit -m "$commit_message"

# Push to the current branch
git push origin "$branch_name"
