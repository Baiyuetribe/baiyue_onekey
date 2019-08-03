FROM nginx:1.17.1-alpine

LABEL MAINTAINER azure https://baiyue.one 

COPY . /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

