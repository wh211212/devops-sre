# 配置Jenkins服务器


# Nginx反向代理Jenkins
```
server {
    listen 80;
    server_name jenkins.domain.tld;
    return 301 https://$host$request_uri;
}

server {

    listen 80;
    server_name jenkins.domain.tld;

    location / {

      proxy_set_header        Host $host:$server_port;
      proxy_set_header        X-Real-IP $remote_addr;
      proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header        X-Forwarded-Proto $scheme;

      # Fix the "It appears that your reverse proxy set up is broken" error.
      proxy_pass          http://127.0.0.1:8080;
      proxy_read_timeout  90;

      proxy_redirect      http://127.0.0.1:8080 https://jenkins.domain.tld;
    }
  }
```
##  使用SSl

```
upstream jenkins {
  server 127.0.0.1:8080 fail_timeout=0;
}

server {
  listen 80;
  server_name jenkins.domain.tld;
  return 301 https://$host$request_uri;
}

server {
  listen 443 ssl;
  server_name jenkins.domain.tld;

  ssl_certificate /etc/nginx/ssl/server.crt;
  ssl_certificate_key /etc/nginx/ssl/server.key;

  location / {
    proxy_set_header        Host $host:$server_port;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_redirect http:// https://;
    proxy_pass              http://jenkins;
  }
}
```

##

```
server {
  listen          80;
  server_name     jenkins.aniu.co;

  #this is the jenkins web root directory
  root            /var/cache/jenkins/war;

  access_log      /var/log/nginx/jenkins/access.log;
  error_log       /var/log/nginx/jenkins/error.log;
  ignore_invalid_headers off; # pass through headers from Jenkins which are considered invalid by Nginx server.
  location ~ "^/static/[0-9a-fA-F]{8}\/(.*)$" {

    #rewrite all static files into requests to the root
    #E.g /static/12345678/css/something.css will become /css/something.css
    rewrite "^/static/[0-9a-fA-F]{8}\/(.*)" /$1 last;
  }

  location /userContent {
        #have nginx handle all the static requests to the userContent folder files
        #note : This is the $JENKINS_HOME dir
	root /var/lib/jenkins/;
        if (!-f $request_filename){
           #this file does not exist, might be a directory or a /**view** url
           rewrite (.*) /$1 last;
	   break;
        }
	sendfile on;
  }

  location @jenkins {
      sendfile off;
      proxy_pass         http://127.0.0.1:8080;
      proxy_redirect     default;

      proxy_set_header   Host             $host;
      proxy_set_header   X-Real-IP        $remote_addr;
      proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
      proxy_max_temp_file_size 0;

      #this is the maximum upload size
      client_max_body_size       10m;
      client_body_buffer_size    128k;

      proxy_connect_timeout      90;
      proxy_send_timeout         90;
      proxy_read_timeout         90;

      proxy_buffer_size          4k;
      proxy_buffers              4 32k;
      proxy_busy_buffers_size    64k;
      proxy_temp_file_write_size 64k;
}

  location / {

     # Optional configuration to detect and redirect iPhones
      if ($http_user_agent ~* '(iPhone|iPod)') {
          rewrite ^/$ /view/iphone/ redirect;
      }

      try_files $uri @jenkins;
   }
}
```

# 相关插件安装
