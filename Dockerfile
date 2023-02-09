FROM node
WORKDIR /app
COPY package-lock.json .
COPY . .
RUN npm install --legacy-peer-deps
EXPOSE 3000
CMD ["npm", "start"]
