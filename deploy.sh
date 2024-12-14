#!/bin/bash

# Step 1: Build the React app
echo "Building the React app..."
npm install
npm run build

# Step 2: Check if there are changes in the build folder to commit
if [ -n "$(git status --porcelain build)" ]; then
  echo "Changes detected in the build folder. Committing changes..."
  git add build
  git commit -m "Automated commit"
  git push origin main
else
  echo "No changes to commit."
fi

# Step 3: Deploy the build folder to Google Cloud Storage using gcloud storage
BUCKET_NAME="my-project-first--bucket"  # Replace with your actual bucket name
echo "Uploading build folder to Google Cloud Storage bucket: $BUCKET_NAME"

# This command uses `gcloud storage` and avoids any Python-related issues
# gcloud storage cp -r build gs://$BUCKET_NAME
gsutil -D rsync -r "$C:\Users\משתמש\Desktop\devops\devops_mbj_frontend\build" gs://$BUCKET_NAME 
# Step 4: Verify deployment
if [ $? -eq 0 ]; then
  echo "Deployment completed successfully!"
else
  echo "Error: Failed to upload to Google Cloud Storage."
  exit 1
fi