FROM node:22

WORKDIR /app


# Copy package files
COPY package*.json ./
COPY tsconfig.json ./
COPY nest-cli.json ./

# Install dependencies
RUN npm install -g pnpm
RUN pnpm install


# Copy source code
COPY src/ ./src/

EXPOSE 3000

CMD ["npm", "run", "start:prod"]