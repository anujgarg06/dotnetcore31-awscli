FROM mcr.microsoft.com/dotnet/core/sdk:3.1
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && apt-get install -y locales debconf unzip zip jq apt-utils \
    && apt-get clean 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && dotnet tool install -g Amazon.Lambda.Tools \
    && export PATH="$PATH:/root/.dotnet/tools"
# RUN ls -lhtr /etc/locale.gen 
RUN apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates curl file g++ git locales make uuid-runtime \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
	&& dpkg-reconfigure locales \
	&& update-locale LANG=en_US.UTF-8 \
	&& useradd -m -s /bin/bash linuxbrew \
	&& echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers


USER linuxbrew
WORKDIR /home/linuxbrew
ENV LANG=en_US.UTF-8 \
	PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
	SHELL=/bin/bash

RUN git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew \
	&& mkdir /home/linuxbrew/.linuxbrew/bin \
	&& ln -s ../Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/ \
	&& brew config

RUN brew --version
RUN brew tap aws/tap
RUN brew install aws-sam-cli




