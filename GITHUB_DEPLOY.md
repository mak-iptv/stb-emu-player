# 🚀 Quick GitHub Pages Deployment

## ⚠️ IMPORTANT: Before You Start

GitHub Actions needs access to your code and dependencies. Make sure you **DO NOT** add these to `.gitignore`:
- ✅ `frontend/package.json` (required)
- ✅ `frontend/yarn.lock` (optional but recommended)
- ✅ `.github/workflows/deploy.yml` (required for auto-deploy)

## Option 1: Using GitHub Actions (Easiest - Automatic Deploy)

### Step 1: Create GitHub Repository

1. Go to GitHub and create a new repository
2. **DO NOT initialize with README** (we already have one)

### Step 2: Push Your Code

```bash
# Navigate to project root
cd /path/to/stb-emu-player

# Initialize git
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: STB EMU Player"

# Add remote (replace with your details)
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git

# Push to main branch
git branch -M main
git push -u origin main
```

### Step 3: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under "Source", select: **GitHub Actions**
4. That's it! GitHub will automatically build and deploy

### Step 4: Access Your App

After deployment completes (2-3 minutes), visit:
```
https://YOUR-USERNAME.github.io/YOUR-REPO-NAME
```

The app will automatically redeploy every time you push to `main` branch!

---

## Option 2: Manual Deploy with gh-pages Package

### Step 1: Install gh-pages

```bash
cd frontend
yarn add -D gh-pages
```

### Step 2: Update package.json

Edit `frontend/package.json` and add:

```json
{
  "homepage": "https://YOUR-USERNAME.github.io/YOUR-REPO-NAME",
  "scripts": {
    "start": "craco start",
    "build": "craco build",
    "test": "craco test",
    "predeploy": "yarn build",
    "deploy": "gh-pages -d build"
  }
}
```

### Step 3: Deploy

```bash
# First time setup
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
git push -u origin main

# Deploy to GitHub Pages
cd frontend
yarn deploy
```

### Step 4: Enable GitHub Pages

1. Go to repository Settings → Pages
2. Source: **Deploy from branch**
3. Branch: **gh-pages** / **(root)**
4. Click Save

Your app will be live at: `https://YOUR-USERNAME.github.io/YOUR-REPO-NAME`

---

## Quick Test Before Deploy

Test the production build locally:

```bash
cd frontend
yarn build
npx serve -s build -p 3000
```

Visit `http://localhost:3000` - if it works, it will work on GitHub Pages!

---

## Troubleshooting

### ❌ GitHub Actions Build Fails

**Error: "No existing directories found containing cache-dependency-path"**

✅ **Fixed!** The workflow now caches based on `package.json` instead of `yarn.lock`

**Error: "CI=true treating warnings as errors"**

✅ **Fixed!** The workflow sets `CI=false` to ignore warnings

**Still failing?**

Check the Actions tab on GitHub for detailed logs:
1. Go to your repo → **Actions** tab
2. Click on the failed workflow
3. Check the error messages
4. Common fixes:
   - Make sure `package.json` is committed
   - Verify Node.js version compatibility
   - Check for syntax errors in code

### ❌ Blank Page After Deploy

**Check these:**

1. Open browser console (F12) - look for errors
2. Verify the URL matches your `homepage` in package.json
3. Hard refresh: `Ctrl+Shift+R` (Windows) or `Cmd+Shift+R` (Mac)
4. Check if files are in `gh-pages` branch
5. Wait 2-3 minutes for DNS propagation

### ❌ Routes Show 404

✅ **Already Fixed!** The app uses `HashRouter` which works perfectly with GitHub Pages.

URLs will look like:
- `https://yoursite.github.io/repo/#/` (login)
- `https://yoursite.github.io/repo/#/dashboard` (dashboard)
- `https://yoursite.github.io/repo/#/player` (player)

The `#` is normal and required for GitHub Pages!

### ❌ Images Not Loading

Check image URLs in `mock.js` - they should be accessible from the deployed site.

---

## 🎯 Pro Tips

1. **Custom Domain**: Want `yourname.com` instead of `github.io`?
   - Add a `CNAME` file in `frontend/public/` with your domain
   - Configure DNS with your domain provider
   - Enable HTTPS in GitHub Pages settings

2. **Environment Variables**: 
   - For GitHub Actions, add secrets in repo Settings → Secrets
   - Add `REACT_APP_BACKEND_URL` if you have a backend

3. **Faster Deploys**:
   - The workflow caches `node_modules` 
   - Subsequent builds will be faster

4. **View Deployment Status**:
   - Go to Actions tab on GitHub
   - See real-time build progress
   - Get notified of failures

---

## Need Help?

- Check [DEPLOYMENT.md](./DEPLOYMENT.md) for other deployment options (Vercel, Netlify)
- GitHub Pages limits: 100GB bandwidth/month, 1GB storage
- For heavy traffic, consider Vercel or Netlify (unlimited bandwidth)

---

**Made with Emergent** 🚀
