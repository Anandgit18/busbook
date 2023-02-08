FROM node
WORKDIR /app
COPY package-lock.json .
COPY . .
RUN npm cache clean --force
RUN npm install --legacy-peer-deps
EXPOSE 3000
CMD ["npm", "start"]
