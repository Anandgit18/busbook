FROM node:16
WORKDIR /app
COPY * /app/
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 8080
CMD [ "node", "server.js" ]