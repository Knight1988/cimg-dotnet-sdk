# Use the circleci/runner:launch-agent image as the base image
FROM circleci/runner:launch-agent

# Install dependencies for .NET SDK 7
RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
        wget \
        apt-transport-https \
        software-properties-common

# Download and install the Microsoft GPG key in /tmp
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /tmp/microsoft-archive-keyring.gpg

# Move the GPG key to the appropriate directory
RUN sudo mv /tmp/microsoft-archive-keyring.gpg /usr/share/keyrings/

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
RUN sudo dpkg -i /tmp/packages-microsoft-prod.deb

# Install .NET SDK 7
RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
        dotnet-sdk-7.0

# Clean up
RUN sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*