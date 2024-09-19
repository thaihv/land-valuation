FROM node:20.16.0

WORKDIR /app
COPY package*.json ./
RUN npm i --legacy-peer-deps
COPY . .
EXPOSE 9000
CMD ["node", "index.js"]