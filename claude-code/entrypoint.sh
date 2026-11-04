#!/bin/bash
set -e

PORT="${PORT:-7681}"
USERNAME="${USERNAME:-root}"

# /root is a mounted volume, so anything written here at build time is hidden
# once the volume mounts. Seed the shell config on first boot instead, and only
# once -- appending on every restart would grow .bashrc without bound.
if ! grep -q 'claude-terminal-init' /root/.bashrc 2>/dev/null; then
  cat >> /root/.bashrc <<'BASHRC'
# claude-terminal-init
export PS1='\[\033[01;32m\]\u@claude-code\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
cd /root

if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo
  echo "  Claude Code is installed. Run 'claude' to start."
  echo "  You'll be prompted to sign in with your Claude account the first time."
  echo "  (Claude Code needs a Pro, Max, Team, Enterprise or Console account.)"
  echo
else
  echo
  echo "  Claude Code is installed and ANTHROPIC_API_KEY is set. Run 'claude' to start."
  echo
fi
BASHRC
fi

mkdir -p /root/workspace

echo "[claude-terminal] ============================================"
echo "[claude-terminal] Ubuntu 24.04 + Claude Code"
echo "[claude-terminal] claude: $(claude --version 2>/dev/null || echo 'not found')"
echo "[claude-terminal] node:   $(node --version 2>/dev/null || echo 'not found')"
echo "[claude-terminal] port:   $PORT"
echo "[claude-terminal] API key set: $([ -n "$ANTHROPIC_API_KEY" ] && echo yes || echo 'no - sign in with: claude')"
echo "[claude-terminal] ============================================"

# Both values are quoted: ttyd takes the credential as a single argument, and
# an unquoted password containing a space or shell metacharacter would split
# into extra argv entries and stop ttyd from starting at all.
exec /usr/local/bin/ttyd -p "$PORT" -c "$USERNAME:$PASSWORD" /bin/bash
