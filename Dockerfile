# Use the official Debian base image
FROM debian:latest

# Install required dependencies
RUN apt-get update && apt-get install -y wget unzip

# Download and install GoLang
RUN wget -O go.tar.gz https://golang.org/dl/go1.19.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz

# Set the Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV GOBIN="/go/bin"

# Create a workspace for Go projects
RUN mkdir -p /go/src /go/bin

# Download and extract Cosmovisor
RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

# Copy the local binary to the container
COPY build/dydxprotocold-v0.0.1-rc1-linux-amd64 /bin/dydxprotocold

# Set the PATH environment variable
ENV PATH="/cosmovisor:${PATH}"
