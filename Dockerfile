FROM node:dubnium

WORKDIR /app

# Checkout and build unmock-server
RUN git clone --single-branch --branch snicallback https://github.com/unmock/unmock-js.git
RUN cd unmock-js && npm i && npm run compile

# Prepare folders where to read services
RUN mkdir -p __unmock__

EXPOSE 8000 8008 8443

CMD DEBUG=* node unmock-js/packages/unmock-server/index.js
