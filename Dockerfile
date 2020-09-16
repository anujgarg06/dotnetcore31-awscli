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