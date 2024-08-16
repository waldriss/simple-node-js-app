FROM node:alpine
COPY ./ ./
RUN npm install
EXPOSE 8085
CMD [ "npm","start" ]