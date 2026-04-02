# Claude Warmup Setup Instructions

## Step 1: Get Your OAuth Token (Headless Method)

Since you use a different browser, you have two options:

### Option A: Manual Token Extraction

1. Open Claude Code in your preferred browser: https://claude.ai/code
2. Open DevTools (F12) → Application/Storage → Local Storage
3. Look for `oauthToken` or similar key
4. Copy the token (starts with `sk-ant-oat01-...`)

### Option B: Export from Local Claude CLI

Run this in your terminal to see if you already have a token:

```bash
cat ~/.claude.json 2>/dev/null | grep -o '"oauthToken":"[^"]*"' | cut -d'"' -f4
```

Or check your Claude CLI config:

```bash
cat ~/.config/claude/settings.json 2>/dev/null | grep token
```

## Step 2: Set GitHub Secret

Once you have the token, run:

```bash
cd /Users/sopen/Documents/norm/claude-warmup
gh secret set CLAUDE_OAUTH_TOKEN --repo sopenlaz0/claude-warmup
# Paste your token when prompted
```

Or set it via GitHub web UI:

1. Go to: https://github.com/sopenlaz0/claude-warmup/settings/secrets/actions
2. Click "New repository secret"
3. Name: `CLAUDE_OAUTH_TOKEN`
4. Value: Your token (sk-ant-oat01-...)

## Step 3: Adjust Schedule for Your Timezone

You're in Cambodia (UTC+7). Current schedule is 9:15 AM UTC (4:15 PM Cambodia time).

### Recommended schedules:

- **Early bird (6:15 AM Cambodia)**: Cron = `15 23 * * 0-4` (11:15 PM UTC previous day)
- **Standard (7:15 AM Cambodia)**: Cron = `15 0 * * 1-5` (12:15 AM UTC)
- **Late start (8:15 AM Cambodia)**: Cron = `15 1 * * 1-5` (1:15 AM UTC)

To change it:

```bash
# Edit the workflow file and update the cron line
# Current: - cron: '15 9 * * 1-5'
# Change to your preferred time
```

## Step 4: Test It

```bash
# Set your fork as default
cd /Users/sopen/Documents/norm/claude-warmup
gh repo set-default sopenlaz0/claude-warmup

# Run the workflow
gh workflow run warmup.yml

# Check status
gh run list --workflow warmup.yml
```

## Step 5: Enable GitHub Actions

1. Visit: https://github.com/sopenlaz0/claude-warmup/actions
2. Click "I understand my workflows, go ahead and enable them"

---

## Quick Start (Once you have the token)

```bash
# 1. Set the secret
gh secret set CLAUDE_OAUTH_TOKEN --repo sopenlaz0/claude-warmup
# Paste token here...

# 2. Update schedule (example: 6:15 AM Cambodia time)
# Edit .github/workflows/warmup.yml line 5:
# Change: - cron: '15 9 * * 1-5'
# To:     - cron: '15 23 * * 0-4'

# 3. Commit and push
git add .github/workflows/warmup.yml
git commit -m "Update warmup schedule for Cambodia timezone"
git push

# 4. Test
gh workflow run warmup.yml --repo sopenlaz0/claude-warmup
```

---

Fork is ready at: https://github.com/sopenlaz0/claude-warmup
