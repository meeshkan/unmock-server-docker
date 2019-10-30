FROM node:dubnium

WORKDIR /app

# Checkout and build unmock-server
RUN git clone --single-branch --branch dev https://github.com/unmock/unmock-js.git
RUN cd unmock-js && npm i && npm run compile

COPY build-cert.sh .

# Prepare folders where to read services and certificates
RUN mkdir -p __unmock__ && mkdir -p certs

# Add script for preparing certificate
RUN cp unmock-js/packages/unmock-server/scripts/prepare-cert.sh prepare-cert.sh

EXPOSE 8000 8008 8443

CMD DEBUG=* PUBLIC_KEY_PATH=certs/cert.pem  PRIVATE_KEY_PATH=certs/key.pem node unmock-js/packages/unmock-server/index.js
