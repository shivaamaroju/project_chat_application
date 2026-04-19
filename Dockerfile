# Stage 1: Build React Frontend
FROM node:18-alpine AS client-build
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# Stage 2: Build Node.js Backend
FROM node:18-alpine
WORKDIR /app
COPY server/package*.json ./server/
RUN cd server && npm install
COPY server/ ./server/

# Copy React build to the server's static files directory
# Note: Ensure your Express app is set to serve the 'build' folder
COPY --from=client-build /app/client/build ./server/public

EXPOSE 8090

# Set environment variable for the port
ENV PORT=8090

CMD ["node", "server/index.js"]
