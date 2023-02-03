FROM node:16
WORKDIR /code
COPY ./
RUN npm install --legacy-peer-deps
COPY 
EXPOSE 3000
CMD [ "npm", "start" ]
