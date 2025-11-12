# Stage 1: build frontend
FROM node:18-alpine AS frontend
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# Stage 2: build backend + copy frontend build
FROM node:18-alpine
WORKDIR /app
COPY server/package*.json ./server/
RUN cd ./server && npm install
COPY server/ ./server
# Copy static frontend build into backend public/static folder
COPY --from=frontend /app/client/build ./server/public

WORKDIR /app/server
ENV PORT= 5000
EXPOSE 5000
CMD ["node", "index.js"]

