FROM node
WORKDIR /app
COPY package-lock.json .
COPY . .
RUN npm clean-install --force
EXPOSE 3000
CMD ["npm", "start"]
