# -------------------------------
# Stage 1 — Build React frontend (if applicable)
# -------------------------------
FROM node:18-alpine AS build
WORKDIR /app
COPY client ./client
WORKDIR /app/client
RUN npm install
RUN npm run build

# -------------------------------
# Stage 2 — Run backend or static site
# -------------------------------
FROM node:18-alpine
WORKDIR /app
COPY server ./server
WORKDIR /app/server
RUN npm install

# Copy React build output into server/public (if backend serves UI)
COPY --from=build /app/client/build ./public

# ✅ Corrected ENV line
ENV PORT=5000

EXPOSE 5000
CMD ["node", "index.js"]
