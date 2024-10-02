# Part of the article: Build Your Own Trading Bot Dev Environment that works from Anywhere and includes TA Lib, AI
# TradeOxy URL to access article: https://www.tradeoxy.com/blog/build-your-own-trading-bot-dev-environment-that-works-from-anywhere-includes-technical-indicators-from-ta-lib-and-cutting-edge-ai/
# Medium URL to access article: https://medium.com/@appnologyjames/build-your-own-trading-bot-development-environment-5163443da220
# Main GitHub Repo: https://github.com/jimtin/something-cool/blob/main/README.md


# Use the official image as a parent image.
FROM mcr.microsoft.com/vscode/devcontainers/python:3.10

# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc \
        default-libmysqlclient-dev \
        build-essential \
        wget

# Download TA-Lib to the /tmp directory
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz -O /tmp/ta-lib-0.4.0-src.tar.gz

# Extract TA-Lib files
RUN tar xvzf /tmp/ta-lib-0.4.0-src.tar.gz -C /tmp

# Navigate into the extracted TA-Lib source code directory
WORKDIR /tmp/ta-lib/

# Build and install TA-Lib
RUN ./configure --prefix=/usr && make && make install

# Navigate back to the root directory
WORKDIR /

# Copy the requirements.txt file to the root directory
COPY requirements.txt /

# Install the Python dependencies
RUN pip install --upgrade pip && pip install -r /requirements.txt

# Install TA-Lib python wrapper
RUN pip install TA-Lib
