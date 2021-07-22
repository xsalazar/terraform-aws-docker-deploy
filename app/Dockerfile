FROM node:14

COPY dist/out-tsc package*.json ./

# Install NPM dependencies for function
RUN npm ci

# Set NODE_ENV for deployed images
ENV NODE_ENV=production

# Expose the port used by the service
EXPOSE 8400

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "node", "index.js" ]