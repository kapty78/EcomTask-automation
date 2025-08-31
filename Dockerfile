FROM n8nio/n8n:1.74.1

# Switch to root temporarily to copy files
USER root

# Create branding directory and copy local branding files
COPY branding/ /tmp/branding/

# Copy branding files to all likely static public directories
RUN mkdir -p /usr/local/lib/node_modules/n8n/packages/cli/dist/public && \
    mkdir -p /usr/local/lib/node_modules/n8n/dist/public && \
    mkdir -p /app/packages/cli/dist/public && \
    mkdir -p /app/dist/public

# Copy favicon and logo to all public directories
RUN cp /tmp/branding/favicon.ico /usr/local/lib/node_modules/n8n/packages/cli/dist/public/ && \
    cp /tmp/branding/logo.svg /usr/local/lib/node_modules/n8n/packages/cli/dist/public/ && \
    cp /tmp/branding/robots.txt /usr/local/lib/node_modules/n8n/packages/cli/dist/public/ && \
    cp /tmp/branding/favicon.ico /usr/local/lib/node_modules/n8n/dist/public/ && \
    cp /tmp/branding/logo.svg /usr/local/lib/node_modules/n8n/dist/public/ && \
    cp /tmp/branding/robots.txt /usr/local/lib/node_modules/n8n/dist/public/ && \
    cp /tmp/branding/favicon.ico /app/packages/cli/dist/public/ && \
    cp /tmp/branding/logo.svg /app/packages/cli/dist/public/ && \
    cp /tmp/branding/robots.txt /app/packages/cli/dist/public/ && \
    cp /tmp/branding/favicon.ico /app/dist/public/ && \
    cp /tmp/branding/logo.svg /app/dist/public/ && \
    cp /tmp/branding/robots.txt /app/dist/public/

# Clean up temporary files
RUN rm -rf /tmp/branding

# Switch back to node user
USER node

# Expose port 5678
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:5678/ || exit 1

# Use the CMD from the base image
