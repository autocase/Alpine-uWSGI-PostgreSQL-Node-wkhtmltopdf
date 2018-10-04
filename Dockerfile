
FROM autocaseimpact / alpine-uwsgi-postgresql:latest

# Install Node.js
RUN apk --no-cache add nodejs=8.11.4-r0 npm=8.11.4-r0

# Bower needs git installed
RUN apk --no-cache add git

# Download and install wkhtmltopdf
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories; apk upgrade --update-cache --available
RUN apk --no-cache add wkhtmltopdf coreutils xvfb dbus

# Install xvfb to use wkhtmltopdf without X server
ADD ./packages/wkhtmltopdf /usr/local/bin/
ADD ./packages/xvfb-run /usr/bin/

RUN chmod a+x /usr/local/bin/wkhtmltopdf
RUN chmod +x /usr/bin/xvfb-run

# Intall NPM Dev Dependencies
RUN npm set progress=false
RUN npm install -g npm
