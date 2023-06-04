FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY schema.js ./
EXPOSE 3003
CMD ["sh", "-c", "node schema.js && node express.js"]

<<<<<<< HEAD
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY schema.js ./
EXPOSE 3003
CMD ["sh", "-c", "node schema.js && node express.js"]
=======
>>>>>>> 40d89e2f26e53ec3c65dce27da44d3b8f9f13bdf
