# Use Bookworm as the base
FROM balenalib/raspberry-pi-debian:bookworm

# Bring everything up to date
RUN apt update
RUN apt upgrade -y

# Install Python and build tools
RUN apt install -y git python3 python3-pip python3-setuptools curl python3-venv build-essential make

# Create an area to store the s/w
RUN mkdir -p /ql700
WORKDIR /ql700

# Install PyEnv (may go back to this later)
RUN curl https://pyenv.run | /bin/bash
# Set up the PyEnv environment (equivalent of bashrc additions
ENV HOME=/root
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/bin:${PATH}"
RUN pyenv init --path
RUN pyenv init -

# Install Specific Python version
#RUN pyenv install 3.11.2
#RUN pyenv global 3.11.2
#RUN ${PYENV_ROOT}/shims/python -m venv venv

# Create virtual environment for the QL-700 s/w
RUN python3 -m venv venv

# Install all syetem-level dependencies for QL-700 s/w
RUN apt install -y libdeflate-dev libdeflate0 libjbig-dev libjbig0 libjpeg-dev libjpeg62-turbo libjpeg62-turbo-dev liblerc-dev liblerc4 liblzma-dev libtiff-dev libtiff5-dev libtiff6 libtiffxx6 libwebp-dev libwebp7 libwebpdemux2 libwebpmux3 libzstd-dev zlib1g-dev libopenjp2-7-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python3-tk libharfbuzz-dev libfribidi-dev libxcb1-dev python3-dev

# Install QL-700 Python dependencies
ADD requirements.txt /ql700/requirements.txt
RUN /ql700/venv/bin/pip install -r requirements.txt

# Fix for Pillow incompatibility
RUN sed -i 's/ANTIALIAS/LANCZOS/g' /ql700/venv/lib/python3.11/site-packages/brother_ql/conversion.py

# Add lp group to root user so it can use the printer
RUN usermod -aG lp root

# Brother QL-700 Webform
WORKDIR /
# Grab the source from GitHub
RUN git clone https://github.com/pklaus/brother_ql_web.git
# Move into the cloned directory
WORKDIR /brother_ql_web
# Install all required dependencies
RUN /ql700/venv/bin/pip install -r requirements.txt
# Add the config for the QL-700
# (other devices would need specific config)
ADD config.json /brother_ql_web/config.json
# Add extra system-level dependency for the webform
RUN apt install -y fontconfig

# Set the web server as the entrypoint
ENTRYPOINT /ql700/venv/bin/python brother_ql_web.py
