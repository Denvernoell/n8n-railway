#!/bin/sh

# Set n8n port to the PORT environment variable provided by Railway
export N8N_PORT=${PORT}

# Set database connection from environment variables
if [ -n "$DB_POSTGRESDB_HOST" ]; then
  echo "Using external PostgreSQL database"
fi

# Set the host if defined
if [ -n "$SUBDOMAIN" ] && [ -n "$DOMAIN_NAME" ]; then
  export N8N_HOST=${SUBDOMAIN}.${DOMAIN_NAME}
  export WEBHOOK_URL=https://${SUBDOMAIN}.${DOMAIN_NAME}/
fi

# Start n8n
echo "Starting n8n..."
exec n8n start
