FROM node:20-alpine

ARG N8N_VERSION=1.109.1

RUN apk add --update graphicsmagick tzdata

USER root

RUN apk --update add --virtual build-dependencies python3 build-base && \
    npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
    apk del build-dependencies

WORKDIR /data

# Railway assigns a dynamic port via PORT env var
EXPOSE ${PORT}

ENV N8N_USER_ID=root
ENV NODE_ENV=production
ENV N8N_PROTOCOL=https
ENV N8N_DISABLE_PRODUCTION_MAIN_PROCESS=false
ENV N8N_RUNNERS_ENABLED=true

# Add startup script that uses PORT env var
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
