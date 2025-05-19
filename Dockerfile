FROM python:3.13-slim

ENV VIRTUAL_ENV=/home/robot/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN useradd -ms /bin/bash robot

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/robot

COPY --chown=robot:robot requirements.txt .

RUN python3 -m venv $VIRTUAL_ENV \
    && pip install --upgrade pip \
    && pip install -r requirements.txt

RUN if pip show robotframework-browser > /dev/null 2>&1; then rfbrowser init --with-deps; fi

RUN chown -R robot:robot /home/robot

USER robot
CMD ["bash"]