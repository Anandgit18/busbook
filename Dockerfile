FROM node:16
WORKDIR /code
COPY ./public /code/public
RUN npm install --legacy-peer-deps
COPY ./src /code/src
COPY ./package-lock.json /code/package-lock.json
COPY ./package.json /code/package.json
CMD ["npm", "start", "--host", "0.0.0.0", "--port", "80"]
