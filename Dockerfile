FROM node
WORKDIR /app
COPY * /app/
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 85
CMD [ "npm", "start" ]
