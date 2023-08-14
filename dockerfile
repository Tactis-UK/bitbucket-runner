FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

# dependencies
RUN apt-get update && apt-get install -q -y curl git wget openjdk-11-jdk 

# powershell 7 & powershell-yaml module
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/powershell_7.3.6-1.deb_amd64.deb && \
    dpkg -i powershell_7.3.6-1.deb_amd64.deb && \
    rm powershell_7.3.6-1.deb_amd64.deb

RUN /usr/bin/pwsh -nologo -command "Install-Module powershell-yaml -Force"

# bitbucket runner
RUN curl https://product-downloads.atlassian.com/software/bitbucket/pipelines/atlassian-bitbucket-pipelines-runner-1.492.tar.gz --output atlassian-bitbucket-pipelines-runner.tar.gz && \
    mkdir atlassian-bitbucket-pipelines-runner && tar -xzvf atlassian-bitbucket-pipelines-runner.tar.gz -C atlassian-bitbucket-pipelines-runner && \
    rm atlassian-bitbucket-pipelines-runner.tar.gz

WORKDIR /atlassian-bitbucket-pipelines-runner/bin