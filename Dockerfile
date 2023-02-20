FROM node:16
WORKDIR /app
COPY package.json package.json
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 3000:3000
CMD ["npm", "start"]
