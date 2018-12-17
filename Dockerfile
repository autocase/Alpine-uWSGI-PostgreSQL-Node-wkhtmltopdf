FROM autocaseimpact/alpine-uwsgi-postgresql:latest

# Install Node.js
RUN apk --no-cache add nodejs=8.14.0-r0 npm=8.14.0-r0

# Install dependencies for python-docx
RUN apk add libxslt-dev libxml2-dev

# Bower needs git installed
RUN apk --no-cache add git

# Install Chromium and run Chrome as non-privileged
RUN apk add chromium
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

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
