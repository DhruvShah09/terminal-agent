# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install common utilities and tools
RUN apt-get update && apt-get install -y \
    sudo \
    vim \
    nano \
    curl \
    wget \
    net-tools \
    iputils-ping \
    iproute2 \
    htop \
    tmux \
    openssh-client \
    man \
    less \
    unzip \
    psmisc \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    --no-install-recommends

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up a non-root user with sudo privileges
RUN useradd -ms /bin/bash user && echo "user:user" | chpasswd && adduser user sudo

# Switch to the non-root user
USER user

# Set the working directory
WORKDIR /home/user

# Add mock text and CSV files
RUN echo "Hello, this is a mock text file." > /home/user/mock.txt
RUN echo "id,name,age\n1,Alice,30\n2,Bob,25\n3,Charlie,35" > /home/user/mock.csv

# Expose a port for SSH (optional)
EXPOSE 22

RUN mkdir source 
ADD src source 
# Start with a Bash shell
CMD ["/bin/bash"]
