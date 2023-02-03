FROM node:16
WORKDIR /code
COPY ./public /code/public
COPY ./src /code/src
COPY ./package-lock.json /code/package-lock.json
COPY ./package.json /code/package.json
RUN npm install --legacy-peer-deps
CMD ["npm", "start", "--host", "0.0.0.0", "--port", "80"]
