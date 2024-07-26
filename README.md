# nginx-rtmp-docker
Docker image with Nginx using the [nginx-rtmp-module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) for live multimedia (video/audio) streaming.

## How to use
>docker build -t nginx-rtmp .
docker run -d -p 1935:1935 -p 80:80 --name nginx-rtmp nginx-rtmp
## How to configure nginx
See the document of [nginx-rtmp-module (sergey-dryabzhinsky)](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) and [nginx-rtmp-module (aurt)](https://github.com/arut/nginx-rtmp-module)
You could start the container with customized configure file
>docker run -d -v my_nginx.conf:/usr/local/nginx/conf/nginx.conf -p 1935:1935 -p 80:80 --name nginx-rtmp nginx-rtmp
