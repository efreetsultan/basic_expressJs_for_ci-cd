FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY schema.js ./
EXPOSE 3003
CMD ["sh", "-c", "node schema.js && node express.js"]

