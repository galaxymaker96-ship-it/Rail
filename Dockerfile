FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    xrdp \
    dbus-x11 \
    sudo curl \
    && rm -rf /var/lib/apt/lists/*

# Install Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Create a non-root user for the desktop session
RUN useradd -m -s /bin/bash devuser && \
    echo "devuser:2752" | chpasswd && \
    adduser devuser sudo

# xrdp needs this to find the session
RUN echo "xfce4-session" > /home/devuser/.xsession && \
    chown devuser:devuser /home/devuser/.xsession

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3389
CMD ["/start.sh"]