# 🚀 QUICK START - Deploy in 5 Minutes!

## Method 1: Automatic Script (Easiest!)

```bash
# Extract the zip file
unzip stb-emu-player-deploy-ready.zip
cd stb-emu-player

# Run the deployment script
./deploy-github.sh
```

Follow the prompts! The script will:
- ✅ Ask for your GitHub username and repo name
- ✅ Initialize git
- ✅ Push to GitHub
- ✅ Set up deployment

---

## Method 2: Manual (Step by Step)

### 1️⃣ Create GitHub Repository
- Go to github.com/new
- Name: `stb-emu-player` (or any name)
- Don't initialize with README
- Create repository

### 2️⃣ Push Code

```bash
# Extract and navigate to folder
cd stb-emu-player

# Initialize git
git init
git add .
git commit -m "Initial commit"

# Add your repo (replace YOUR-USERNAME and YOUR-REPO)
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git
git branch -M main
git push -u origin main
```

### 3️⃣ Enable GitHub Pages

Go to your repo on GitHub:
1. Click **Settings** → **Pages**
2. Under "Source" select: **GitHub Actions**
3. Wait 2-3 minutes

### 4️⃣ Visit Your App!

```
https://YOUR-USERNAME.github.io/YOUR-REPO
```

---

## ✨ What's Fixed?

✅ HashRouter for GitHub Pages compatibility
✅ GitHub Actions workflow (no yarn.lock needed)
✅ Caching optimized for faster builds
✅ CI=false to ignore warnings
✅ Complete deployment documentation

---

## 🐛 Troubleshooting

### Build fails on GitHub Actions?
- Check Actions tab for errors
- Verify package.json is committed
- Try running `yarn build` locally first

### Blank page after deploy?
- Check browser console (F12)
- Hard refresh: Ctrl+Shift+R
- Wait 5 minutes for deployment

### Need help?
- Read: `GITHUB_DEPLOY.md` (detailed guide)
- Read: `DEPLOYMENT.md` (other platforms)

---

## 📦 What's Included

```
stb-emu-player/
├── frontend/              ← React app
│   ├── src/              ← Source code
│   ├── package.json      ← Dependencies
│   └── yarn.lock         ← Lock file (included!)
├── backend/              ← FastAPI (optional)
├── .github/workflows/    ← Auto-deploy config
├── GITHUB_DEPLOY.md      ← Detailed guide
├── deploy-github.sh      ← Auto setup script
└── README.md             ← Project info
```

---

## 🎯 Features

- ✅ Portal authentication (URL + MAC)
- ✅ Live TV with 12 channels
- ✅ Movies library (8 films)
- ✅ TV Series (3 shows)
- ✅ EPG guide
- ✅ Video player
- ✅ Search & favorites

Currently uses **mock data** - ready for backend integration!

---

**Made with Emergent** 🚀
