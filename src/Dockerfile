FROM node
WORKDIR /app
COPY --from busbook/ /app/
RUN npm install --legacy-peer-deps
COPY . .
EXPOSE 3000
CMD [ "npm", "start" ]
