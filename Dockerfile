ARG BUILDER_IMAGE=bitpoke/wordpress-runtime:bedrock-build-php-8.1
ARG RUNTIME_IMAGE=bitpoke/wordpress-runtime:bedrock-php-8.1
ARG NODE_VERSION=18
FROM ${BUILDER_IMAGE} as builder
FROM ${RUNTIME_IMAGE} as runtime
COPY --from=builder --chown=www-data:www-data /app /app

EXPOSE 8080
WORKDIR /app
FROM node:${NODE_VERSION} as node
FROM ${BUILDER_IMAGE} as dev
USER root
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN chsh -s /bin/bash www-data \
&& mkdir -p /home/www-data \
&& chown www-data:www-data /home/www-data \
&& usermod -d /home/www-data www-data
COPY --from=builder --chown=www-data:www-data /app/.bashrc /home/www-data/.bashrc
RUN apt-get update \
&& apt-get install default-mysql-client -y
RUN mkdir /.devspace
RUN chown -R www-data:www-data /.devspace
RUN set -ex \
&& touch /usr/local/bin/devspace \
&& touch /usr/local/bin/kubectl \
&& touch /usr/local/bin/helm \
&& chown www-data:www-data /usr/local/bin/devspace \
&& chown www-data:www-data /usr/local/bin/kubectl \
&& chown www-data:www-data /usr/local/bin/helm \
&& chmod 700 /usr/local/bin/devspace \
&& chmod 700 /usr/local/bin/kubectl \
&& chmod 700 /usr/local/bin/helm
USER www-data
WORKDIR /app