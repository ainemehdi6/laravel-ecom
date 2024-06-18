FROM php:7.4.33-fpm

# Set the Node.js version to install
ENV NODE_VERSION=12.6.0

# Update package list and install necessary packages
RUN apt update && apt install -y \
    curl \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip

# Copy project files to the container
COPY project ./

# Copy environment example file to the container
COPY project/.env.example ./.env

# Install NVM and Node.js
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH="/usr/local/bin:${PATH}"

# Set the working directory
WORKDIR /var/www
