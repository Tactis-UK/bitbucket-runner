FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

# dependencies
RUN apt-get update && apt-get install -q -y curl git wget openjdk-11-jdk 

# powershell 7 & powershell-yaml module
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.5.0/powershell_7.5.0-1.deb_amd64.deb && \
    dpkg -i powershell_7.5.0-1.deb_amd64.deb && \
    rm powershell_7.5.0-1.deb_amd64.deb

RUN /usr/bin/pwsh -command "Install-Module powershell-yaml -Force"

# bitbucket runner
RUN curl --remote-name https://product-downloads.atlassian.com/software/bitbucket/pipelines/atlassian-bitbucket-pipelines-runner.tar.gz && \
    mkdir atlassian-bitbucket-pipelines-runner && tar -xzvf atlassian-bitbucket-pipelines-runner.tar.gz -C atlassian-bitbucket-pipelines-runner && \
    rm atlassian-bitbucket-pipelines-runner.tar.gz

WORKDIR /atlassian-bitbucket-pipelines-runner/bin