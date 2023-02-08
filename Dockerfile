FROM node
WORKDIR /app
COPY package-lock.json .
COPY . .
RUN npm install 
EXPOSE 3000
CMD ["npm", "start"]
