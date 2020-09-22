FROM mcr.microsoft.com/dotnet/core/sdk:3.1
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN apt-get update -y
RUN apt-get install unzip -y
RUN apt-get -y install zip
RUN unzip awscliv2.zip
RUN ./aws/install
RUN apt-get install jq -y
RUN dotnet tool install -g Amazon.Lambda.Tools
RUN export PATH="$PATH:/root/.dotnet/tools"
RUN git --version
RUN apt-get install --reinstall ca-certificates
RUN mkdir /usr/local/share/ca-certificates/cacert.org
RUN wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt
RUN update-ca-certificates
RUN git config --global http.sslCAinfo /etc/ssl/certs/ca-certificates.crt
RUN curl --remote-name --time-cond cacert.pem https://curl.haxx.se/ca/cacert.pem
RUN /bin/bash -c "$(curl -k -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
RUN test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
RUN test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
RUN echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
# RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
# RUN mkdir ~/.linuxbrew/bin
# RUN ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
# RUN eval $(~/.linuxbrew/bin/brew shellenv)
RUN brew --version
RUN brew tap aws/tap
RUN brew install aws-sam-cli
RUN sam --version
