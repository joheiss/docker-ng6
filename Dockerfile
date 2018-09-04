# Build phase
FROM node:alpine AS builder

WORKDIR '/usr/app'
COPY package*.json /usr/app/
RUN npm install
COPY ./ /usr/app/

ARG configuration=production

RUN npm run build -- --output-path=/usr/app/dist/out --configuration $configuration

# Run phase
FROM nginx:alpine

EXPOSE 80

COPY --from=builder /usr/app/dist/out/ /usr/share/nginx/html


