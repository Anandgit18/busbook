FROM node
WORKDIR /app
COPY * /app/
RUN npm install
COPY . .
EXPOSE 85
CMD [ "node", "server.js" ]
