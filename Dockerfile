FROM fedora:latest

# Install dependencies + sshd
RUN dnf install -y openssh-server ssh curl tar unzip \
    && dnf clean all

# Install ngrok from official repo
COPY ngrok.tgz /tmp/ngrok.tgz
RUN tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin

# Generate SSH host keys (required before sshd can start)
RUN ssh-keygen -A

# Optional: set root password for SSH login (change this!)
RUN echo 'root:password' | chpasswd

# Allow root login via SSH (for dev/testing only)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Create upload/download working directory
RUN mkdir -p /upload
WORKDIR /upload

# Expose SSH port
EXPOSE 22

# Entrypoint script to start both sshd and ngrok
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]