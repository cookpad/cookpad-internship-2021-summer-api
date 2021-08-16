FROM node:16-slim

COPY package.json yarn.lock /tmp/
RUN cd /tmp && yarn install --frozen-lockfile --production

WORKDIR /app
COPY . /app
RUN cp -a /tmp/node_modules /app/

CMD ["yarn", "run", "start"]
