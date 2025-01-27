
# Build stage for React
FROM node:18-alpine AS frontend-build

WORKDIR /app/frontend

COPY app/ ./
RUN npm install
RUN npm run build

# Final stage
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1

# Copy from the cache instead of linking since it's a mounted volume
ENV UV_LINK_MODE=copy

COPY services/ ./
RUN uv sync --frozen --no-dev

# Copy React build files to appropriate location
COPY --from=frontend-build /app/frontend/dist ./static

EXPOSE 8000

CMD ["uv", "run", "main.py"]
