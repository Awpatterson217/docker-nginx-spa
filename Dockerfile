FROM nginx:1.10.3

MAINTAINER Yalda Kako <ykako@pavlovmedia.com>

# Install jq to do SPA_ environment variable parsing at runtime
RUN apt-get install --no-install-recommends --no-install-suggests -y jq

# Instruct nginx to not run as daemon, required for Docker
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy our entrypoint script that generates the environmental variable JavaScript
COPY ./bin/entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Copy our compiled SPA files
COPY ./target/dist /usr/share/nginx/html

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["nginx"]
