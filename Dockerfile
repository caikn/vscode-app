FROM redhat/ubi8

RUN dnf install -y glibc-langpack-en \
	git \
	python39

RUN pip3 install dumb-init

# We cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LC_ALL=en_US.UTF-8 \
	SHELL=/bin/bash

# install the latest version
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version 4.23.1

RUN groupadd -g 666 coder && \
    useradd -r -u 666 -g coder coder && \
    mkdir /home/coder && \
    chown coder:coder /home/coder

USER 666:666
EXPOSE 3000
ENV HOME /home/coder
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM 1

# install vscode extensions
RUN code-server --install-extension donjayamanne.githistory
RUN code-server --install-extension eamodio.gitlens
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-python.pylint

ENTRYPOINT ["dumb-init", "--"]
CMD ["bash", "-c", "exec code-server --host 0.0.0.0 --port 3000 --auth none /vhome"]
