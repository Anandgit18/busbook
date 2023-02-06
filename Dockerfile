FROM node:16
WORKDIR /code
COPY ./public /code/public
COPY ./src /code/src
COPY ./package-lock.json /code/package-lock.json
COPY ./package.json /code/package.json
COPY ./pod.yaml /code/pod.yaml
RUN npm install --legacy-peer-deps
EXPOSE 3000
CMD ["npm", "start"]
