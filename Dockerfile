# Build phase
FROM node:alpine AS builder

WORKDIR '/usr/app'
COPY package.json .
RUN npm install
COPY . .

CMD ["npm", "run", "build:prod"]

# Run phase
FROM nginx:alpine

EXPOSE 80

WORKDIR /usr/share/nginx/html

COPY --from=builder /usr/app/dist/ng6-app/ .

