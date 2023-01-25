FROM node
WORKDIR /app
COPY * /app/
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 3000:3000
CMD [ "npm", "start" ]
