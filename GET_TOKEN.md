# Headless OAuth Token Extraction

## Method 1: Copy from Claude.ai Web (Easiest)

1. Open https://claude.ai/code in your browser
2. Open DevTools (F12 or Cmd+Opt+I)
3. Go to **Application** (Chrome) or **Storage** (Firefox) tab
4. Expand **Local Storage** → **https://claude.ai**
5. Look for key: `oauthToken` or `anthropic.oauthToken`
6. Copy the value (starts with `sk-ant-oat01-...`)

## Method 2: Network Tab (If Local Storage is empty)

1. Open https://claude.ai/code
2. Open DevTools → **Network** tab
3. Refresh the page
4. Look for requests to `claude.ai`
5. Check **Request Headers** → **Authorization**
6. The token will be in format: `Bearer sk-ant-oat01-...`
7. Copy just the part after `Bearer ` (starts with `sk-ant-oat01-`)

## Method 3: curl (Advanced)

If you have a valid browser session:

```bash
# Get cookies from your browser and use them
curl -s 'https://claude.ai/api/auth/session' \
  -H 'Cookie: your_session_cookie_here' \
  | grep -o '"token":"[^"]*"' | cut -d'"' -f4
```

---

## Complete Setup Steps

Once you have the token:

```bash
cd /Users/sopen/Documents/norm/claude-warmup

# 1. Set the GitHub secret
gh auth login  # If not already logged in
gh secret set CLAUDE_OAUTH_TOKEN --repo sopenlaz0/claude-warmup
# Paste your token when prompted

# 2. Push the schedule changes
git push origin main

# 3. Enable GitHub Actions
# Visit: https://github.com/sopenlaz0/claude-warmup/actions
# Click "I understand my workflows..."

# 4. Test it
gh workflow run warmup.yml --repo sopenlaz0/claude-warmup

# 5. Check the run
gh run list --workflow warmup.yml --repo sopenlaz0/claude-warmup
```

---

## What This Does

- **Schedule**: Runs at 6:15 AM Cambodia time (UTC+7)
- **Effect**: Anchors your 5-hour window starting at 6 AM
- **Result**: Fresh budget resets at 11 AM Cambodia time
- **Pattern**: Work 8:30 AM - 11 AM → reset → work 11 AM - 4 PM → reset → work 4 PM - 6 PM

---

## Troubleshooting

**Token not found in Local Storage?**

- Make sure you're logged into claude.ai/code
- Try the Network tab method instead

**Workflow fails?**

- Check: https://github.com/sopenlaz0/claude-warmup/actions
- Common issue: Secret not set properly
- Re-run: `gh secret set CLAUDE_OAUTH_TOKEN --repo sopenlaz0/claude-warmup`

**Token expired?**

- Tokens last about 1 year
- Re-run the extraction steps above to get a new one

---

Your fork: https://github.com/sopenlaz0/claude-warmup
