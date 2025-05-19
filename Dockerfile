FROM python:3.13-slim

# Metadata
LABEL maintainer="Thomas Verweij <your.email@example.com>"

# Environment variables
ENV VIRTUAL_ENV=/home/robot/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Create a non-root user
RUN useradd -ms /bin/bash robot

# Install system dependencies and Node.js 22 (LTS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root user
USER robot
WORKDIR /home/robot

# Copy requirements.txt
COPY --chown=robot:robot requirements.txt .

# Create virtual environment and install dependencies
RUN python3 -m venv $VIRTUAL_ENV \
    && pip install --upgrade pip \
    && pip install -r requirements.txt

# Initialize robotframework-browser (if present in requirements.txt)
RUN if pip show robotframework-browser > /dev/null 2>&1; then rfbrowser init --with-deps; fi

# Set default command
CMD ["bash"]