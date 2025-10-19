#!/bin/bash

# STB EMU Player - GitHub Deployment Setup Script
# This script helps you set up and deploy your app to GitHub Pages

set -e  # Exit on error

echo "🚀 STB EMU Player - GitHub Deployment Setup"
echo "============================================"
echo ""

# Check if we're in the right directory
if [ ! -f "frontend/package.json" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    echo "   (where frontend/ and backend/ folders are located)"
    exit 1
fi

# Get GitHub credentials
echo "📝 GitHub Repository Information"
echo "--------------------------------"
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter your repository name: " REPO_NAME

if [ -z "$GITHUB_USERNAME" ] || [ -z "$REPO_NAME" ]; then
    echo "❌ Error: GitHub username and repository name are required"
    exit 1
fi

REPO_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
PAGES_URL="https://$GITHUB_USERNAME.github.io/$REPO_NAME"

echo ""
echo "✅ Repository URL: $REPO_URL"
echo "✅ GitHub Pages URL: $PAGES_URL"
echo ""

# Ask deployment method
echo "📦 Deployment Method"
echo "--------------------"
echo "1) GitHub Actions (Automatic - Recommended)"
echo "2) gh-pages package (Manual)"
read -p "Choose deployment method (1 or 2): " DEPLOY_METHOD

if [ "$DEPLOY_METHOD" = "2" ]; then
    # Manual deployment with gh-pages
    echo ""
    echo "📦 Setting up manual deployment with gh-pages..."
    
    cd frontend
    
    # Update package.json with homepage
    echo "Updating package.json..."
    if command -v jq &> /dev/null; then
        # Use jq if available
        jq ".homepage = \"$PAGES_URL\"" package.json > package.json.tmp && mv package.json.tmp package.json
    else
        # Manual update
        sed -i.bak "s|\"homepage\": \".\"|\"homepage\": \"$PAGES_URL\"|g" package.json
        rm -f package.json.bak
    fi
    
    # Install gh-pages
    echo "Installing gh-pages..."
    yarn add -D gh-pages
    
    # Update scripts
    echo "Adding deploy scripts..."
    if command -v jq &> /dev/null; then
        jq '.scripts.predeploy = "yarn build" | .scripts.deploy = "gh-pages -d build"' package.json > package.json.tmp && mv package.json.tmp package.json
    fi
    
    cd ..
    
    echo "✅ gh-pages setup complete!"
else
    echo ""
    echo "✅ Using GitHub Actions for automatic deployment"
fi

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    echo ""
    echo "🔧 Initializing Git repository..."
    git init
    echo "✅ Git initialized"
fi

# Check if remote already exists
if git remote | grep -q "origin"; then
    echo ""
    echo "⚠️  Remote 'origin' already exists"
    read -p "Remove and re-add? (y/n): " REMOVE_REMOTE
    if [ "$REMOVE_REMOTE" = "y" ]; then
        git remote remove origin
        git remote add origin "$REPO_URL"
        echo "✅ Remote updated"
    fi
else
    git remote add origin "$REPO_URL"
    echo "✅ Remote added: $REPO_URL"
fi

# Add and commit files
echo ""
echo "📝 Committing files..."
git add .
git commit -m "Initial commit: STB EMU Player ready for deployment" || echo "⚠️  No changes to commit"

# Push to GitHub
echo ""
echo "⬆️  Pushing to GitHub..."
git branch -M main
git push -u origin main

if [ "$DEPLOY_METHOD" = "2" ]; then
    # Deploy with gh-pages
    echo ""
    echo "🚀 Deploying to GitHub Pages..."
    cd frontend
    yarn deploy
    cd ..
    
    echo ""
    echo "✅ Deployment complete!"
    echo ""
    echo "📋 Next Steps:"
    echo "1. Go to: https://github.com/$GITHUB_USERNAME/$REPO_NAME/settings/pages"
    echo "2. Under 'Source', select: Branch 'gh-pages' / (root)"
    echo "3. Click 'Save'"
    echo "4. Wait 2-3 minutes and visit: $PAGES_URL"
else
    echo ""
    echo "✅ Code pushed to GitHub!"
    echo ""
    echo "📋 Next Steps:"
    echo "1. Go to: https://github.com/$GITHUB_USERNAME/$REPO_NAME/settings/pages"
    echo "2. Under 'Source', select: GitHub Actions"
    echo "3. GitHub will automatically build and deploy!"
    echo "4. Check progress: https://github.com/$GITHUB_USERNAME/$REPO_NAME/actions"
    echo "5. Visit your app: $PAGES_URL (after deployment completes)"
fi

echo ""
echo "🎉 All done! Your STB EMU Player is ready!"
echo ""
