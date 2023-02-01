FROM node
WORKDIR /app
COPY --from=BUILD_IMAGE busbook/ /app/
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 3000
CMD [ "npm", "start" ]
