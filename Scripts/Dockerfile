FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Update system
RUN apt-get update -y && \
    apt-get upgrade -y

# Create runner user
RUN useradd -m -s /bin/bash docker

# Install required packages
RUN apt-get install -y --no-install-recommends \
    rpm \
    wget \
    curl \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    gnupg \
    unzip \
    maven && \
    \
    # Docker repository
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
      | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" \
      > /etc/apt/sources.list.d/docker.list && \
    apt-get update -y && \
    apt-get install -y docker-ce=5:24.0.7-1~ubuntu.20.04~focal && \
    \
    # AWS CLI
    curl -fsSL \
      https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
      -o /tmp/awscliv2.zip && \
    cd /tmp && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download the latest GitHub Actions runner
RUN set -eux; \
    RUNNER_VERSION="$(curl -fsSL \
      https://api.github.com/repos/actions/runner/releases/latest \
      | jq -r '.tag_name' \
      | sed 's/^v//')"; \
    echo "Installing GitHub Actions Runner ${RUNNER_VERSION}"; \
    mkdir -p /home/docker/actions-runner; \
    cd /home/docker/actions-runner; \
    curl -fsSL \
      -o actions-runner.tar.gz \
      "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"; \
    tar -xzf actions-runner.tar.gz; \
    rm actions-runner.tar.gz

# Install runner dependencies
RUN /home/docker/actions-runner/bin/installdependencies.sh

# Set ownership
RUN chown -R docker:docker /home/docker

# Copy startup script
COPY --chmod=755 start.sh /start.sh

# Run as non-root user
USER docker

ENTRYPOINT ["/start.sh"]
