# base image

FROM node:alpine as builder
#download dependencies
WORKDIR /app

copy package.json .
RUN npm set strict-ssl false
RUN npm config set ca=""
RUN npm install
COPY . .
ENV NODE_ENV=development
ENV CHOKIDAR_USEPOLLING=true
ENV WATCHPACK_POLLING=true
RUN npm run build
# Command on startup


# 2nd phase

from nginx
WORKDIR /app
COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=builder /app /app