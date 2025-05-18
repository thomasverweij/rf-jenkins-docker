FROM mcr.microsoft.com/playwright:v1.52.0-noble

# Use root for package installs
USER root

# Update apt and install Python tools
RUN apt-get update && \
    apt-get install -y python3-pip python3.12-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PATH="/usr/local/bin:$PATH"
ENV NODE_PATH=/usr/lib/node_modules

# Install pip dependencies globally
RUN pip3 install --no-cache-dir --upgrade pip wheel uv && \
    uv pip install --no-cache-dir --upgrade robotframework robotframework-browser==19.5.1

# Initialize Browser library without downloading browser binaries
RUN python3 -m Browser.entry init --skip-browsers

# Set non-root user (optional, safe for Playwright use)
USER pwuser

# Set default working directory
WORKDIR /home/pwuser/app