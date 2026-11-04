# Browser-based Ubuntu 24.04 terminal with Claude Code pre-installed.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl wget gnupg git ripgrep \
        python3 python3-pip python3-venv build-essential \
        vim nano less jq unzip zip htop tree tmux sudo \
        net-tools iproute2 iputils-ping dnsutils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.js 22 LTS, for project work. Claude Code itself ships a native binary
# and does not depend on Node at runtime.
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Claude Code, from Anthropic's signed apt repository.
#
# Deliberately NOT the curl|bash installer: that installs into ~/.local/bin,
# and /root is a mounted volume at runtime, so the binary would be shadowed
# the moment the volume mounts and `claude` would vanish on first boot.
# The apt package installs system-wide, outside the volume.
#
# The key fingerprint is verified before the repo is trusted; if Anthropic's
# key ever changes, this build fails loudly instead of installing silently.
RUN install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://downloads.claude.ai/keys/claude-code.asc \
         -o /etc/apt/keyrings/claude-code.asc \
    && gpg --show-keys --with-colons /etc/apt/keyrings/claude-code.asc \
         | grep -q '31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE' \
    && echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" \
         > /etc/apt/sources.list.d/claude-code.list \
    && apt-get update && apt-get install -y --no-install-recommends claude-code \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ttyd: the browser terminal front end.
RUN wget -qO /usr/local/bin/ttyd \
        https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

EXPOSE 7681

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
