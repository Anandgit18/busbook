FROM node
WORKDIR /app
COPY * /app/
RUN npm install
COPY . .
EXPOSE 85
CMD [ "npm", "start" ]
