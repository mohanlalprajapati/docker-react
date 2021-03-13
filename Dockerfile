#We need to give it some tag to use to start nginx
FROM node:alpine as builder

WORKDIR "/app"

COPY package.json .

RUN npm install

COPY . .

RUN ["npm", "run", "build"]

FROM nginx
#We need to expose 80 beacuse aws looks it specifically
EXPOSE 80
# --from is intermediate container name as builder
# nginx will be automatically started
COPY --from=builder /app/build /usr/share/nginx/html
