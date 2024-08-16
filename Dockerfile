FROM node:19.5.0-alpine
COPY ./ ./
RUN npm install
EXPOSE 3000
CMD [ "npm","start" ]