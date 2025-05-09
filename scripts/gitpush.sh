#!/bin/bash

# Prompt for commit message
read -p "Enter commit message: " commit_message

# Add all changes
git add .

# Commit with the provided message
git commit -m "$commit_message"

# Push to the current branch
git push
