# first phase
FROM node:16-alpine as builder
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
COPY --chown=node:node ./package.json ./
RUN npm install
RUN chown -R node:node /home/node/app/node_modules
COPY --chown=node:node ./ ./
RUN npm run build

# second phase
FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html