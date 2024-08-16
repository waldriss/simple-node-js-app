FROM node:19.5.0-alpine
COPY ./ ./
RUN npm install
EXPOSE 8085
CMD [ "npm","start" ]