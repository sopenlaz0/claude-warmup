#!/bin/zsh
launchctl load ~/Library/LaunchAgents/com.user.claude-warmup.plist 2>/dev/null || true
sudo pmset repeat wakeorpoweron MTWRF 06:10:00
export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"
mkdir -p ~/.claude
echo '{"hasCompletedOnboarding":true}' > ~/.claude.json
claude -p "hi" --model haiku --no-session-persistence
echo "Done! Mac wakes 6:10 AM, warmup 6:15 AM Mon-Fri"
