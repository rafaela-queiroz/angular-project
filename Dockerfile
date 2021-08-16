FROM node:14.17.0 as build

WORKDIR /app

COPY . .

RUN npm ci --silent
RUN npx ng build --deploy-url /angular/

FROM nginx

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/dist/angular-project /usr/share/nginx/html
