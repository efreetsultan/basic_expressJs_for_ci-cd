FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install --only=dev
RUN npm install --save-dev chai
COPY express.test.js .
CMD [ "npm", "run", "test" ]
