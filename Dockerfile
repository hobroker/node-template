FROM node:17-alpine AS BUILD_IMAGE

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

RUN npm prune --production

CMD [ "npm", "start" ]

FROM node:17-slim
ENV NODE_ENV "production"

WORKDIR /usr/src/app

COPY --from=BUILD_IMAGE /usr/src/app/dist ./dist
COPY --from=BUILD_IMAGE /usr/src/app/node_modules ./node_modules

CMD ["node", "dist/index.js"]
