FROM node:14-alpine AS BUILD_IMAGE

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

CMD [ "npm", "start" ]

FROM node:14
ENV NODE_ENV "production"

WORKDIR /usr/src/app

COPY --from=BUILD_IMAGE /usr/src/app .

CMD ["dist/index.js"]
