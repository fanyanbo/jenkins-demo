FROM node
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY ./ /app
RUN npm run build

FROM nginx
RUN mkdir /app
COPY --from=0 /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf