# Stage 1: Build React Frontend
FROM node:18-alpine AS client-build
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/ ./
# FIX APPLIED HERE:
RUN export NODE_OPTIONS=--openssl-legacy-provider && npm run build

# Stage 2: Build Node.js Backend
FROM node:18-alpine
WORKDIR /app
COPY server/package*.json ./server/
RUN cd server && npm install
COPY server/ ./server/

# Copy React build to the server's static files directory
COPY --from=client-build /app/client/build ./server/public

EXPOSE 8090
ENV PORT=8090

CMD ["node", "server/index.js"]
