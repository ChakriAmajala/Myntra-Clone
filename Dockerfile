# -------------------------------
# Stage 1 — Build React frontend
# -------------------------------
FROM node:18-alpine AS build
WORKDIR /app
COPY client ./client
WORKDIR /app/client
RUN npm install
RUN npm run build

# -------------------------------
# Stage 2 — Run backend (Node.js)
# -------------------------------
FROM node:18-alpine
WORKDIR /app

# Copy backend code
COPY server ./server
WORKDIR /app/server
RUN npm install

# Copy frontend build output into backend's public folder
COPY --from=build /app/client/build ./public

# Set environment variables
ENV PORT=5000
EXPOSE 5000

# Start the server
CMD ["node", "index.js"]
