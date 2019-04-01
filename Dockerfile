FROM autocaseimpact/alpine-uwsgi-postgresql:latest

# Update packages and install node.js, python-docx deps
# and wkhtmltopdf
RUN echo '@edgecommunity http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN apk update
RUN apk --no-cache add nodejs=8.14.0-r0 npm=8.14.0-r0 \
		       libxslt-dev libxml2-dev git \
		       ca-certificates gcc g++ curl openblas-dev \
		       wkhtmltopdf@edgecommunity coreutils xvfb dbus \
		       libpng-dev freetype-dev

# Install xvfb to use wkhtmltopdf without X server
ADD ./packages/wkhtmltopdf /usr/local/bin/
ADD ./packages/xvfb-run /usr/bin/

RUN chmod a+x /usr/local/bin/wkhtmltopdf
RUN chmod +x /usr/bin/xvfb-run

# Intall NPM Dev Dependencies
RUN npm set progress=false
RUN npm install -g npm

# Install Chromium and run Chrome as non-privileged
RUN apk --no-cache add chromium
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Install Numpy
RUN pip install --upgrade --no-cache-dir matplotlib==3.0.*
