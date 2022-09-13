FROM node:16.17.0-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginxinc/nginx-unprivileged
COPY --from=builder /app/dist/angular8-springboot-client/* /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 4200
