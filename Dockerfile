FROM node:dubnium

WORKDIR /app
RUN git clone --single-branch --branch dev https://github.com/unmock/unmock-js.git
RUN cd unmock-js && npm i && npm run compile
RUN bash unmock-js/packages/unmock-server/scripts/prepare-cert.sh api.github.com
RUN mkdir -p __unmock__ && mkdir -p certs
EXPOSE 8000 8008 8443
CMD DEBUG=* PUBLIC_KEY_PATH=certs/cert.pem  PRIVATE_KEY_PATH=certs/key.pem node unmock-js/packages/unmock-server/index.js
