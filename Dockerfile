FROM node:18-alpine
COPY ./ ./
RUN npm install
EXPOSE 8085
CMD [ "npm","start" ]