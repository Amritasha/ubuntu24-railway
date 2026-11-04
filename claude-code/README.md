# Ubuntu 24.04 Terminal + Claude Code

A browser-accessible Ubuntu 24.04 shell with [Claude Code](https://code.claude.com)
already installed. No SSH client, no local setup — open the URL, log in, and you
have a Linux box with Claude Code on the PATH.

## What's inside

- Ubuntu 24.04 LTS
- **Claude Code**, installed from Anthropic's signed apt repository
- Node.js 22 LTS, Python 3, git, build-essential, ripgrep, tmux, jq
- A persistent volume at `/root` — your files, installed packages and Claude
  Code login survive redeploys

## Using Claude Code

Open your Railway domain, sign in to the terminal, then run:

```
claude
```

The first run asks you to sign in. Claude Code needs a **Pro, Max, Team,
Enterprise or Console account** — the free claude.ai plan does not include it.

If you prefer an API key, set `ANTHROPIC_API_KEY` in the service's Variables tab
and Claude Code will use it instead of prompting. Set a spend limit on the key:
an agent left running can consume credit quickly.

## Notes on how this is built

Two things that are easy to get wrong and are handled here:

**Claude Code is installed system-wide, not via `curl | bash`.** The native
installer puts the binary in `~/.local/bin`. `/root` is a mounted volume, so
that directory is replaced by the volume at runtime and the binary disappears
on first boot. The apt package installs outside the volume.

**The terminal password is quoted in the start command.** Passing it unquoted
means any password containing a space or a shell metacharacter splits into
extra arguments and ttyd never starts.

The repository signing key fingerprint is verified during build, so if the key
changes the image fails to build rather than installing something unverified.
