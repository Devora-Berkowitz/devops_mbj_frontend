#!/bin/bash

# Navigate to your app directory
cd /path/to/your/app

# Stage, Commit, and Push to GitHub
if [[ `git status --porcelain` ]]; then
  echo "There are changes to commit."
  
  # Stage all changes
  git add .

  # Commit changes
  git commit -m "Automated commit"

  # Push to GitHub
  git push origin main
else
  echo "No changes to commit."
fi

# Install dependencies and build the app
echo "Installing dependencies..."
npm install

echo "Building the app..."
npm run build

# Deploy to Google Cloud Storage
BUCKET_NAME="gs://your-bucket-name"
echo "Deploying to GCS..."
gsutil -m rsync -r ./build/ $BUCKET_NAME

echo "Deployment complete!"

#!/bin/bash

# הגדרת נתיב ה-build ו-GCS bucket
BUILD_DIR="./build"
BUCKET_NAME="gs://your-bucket-name"

# טיפול בשגיאות: אם יש שגיאה, הסקריפט יפסיק
set -e

# הדפסת לוג שמתחילים את התהליך
echo "Starting the deployment process..."

# העלאת קבצים ל-GCS
echo "Uploading build files to GCS..."
if ! gsutil -m rsync -r $BUILD_DIR $BUCKET_NAME; then
  echo "Error: Failed to upload build files to GCS." >&2
  exit 1
fi

# הדפסת לוג לאחר הצלחה
echo "Files uploaded successfully to GCS."

# אתה יכול להוסיף כאן לוגים נוספים או פעולות נוספות של deploy אם צריך.
