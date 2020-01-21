FROM node:dubnium

WORKDIR /app

RUN npm install -g unmock-server

# Prepare folders where to read services
RUN mkdir -p __unmock__

# Proxy port and two mock server ports
EXPOSE 8000 8008 8443

# Enable DEBUG logs
ENV DEBUG=*

ENTRYPOINT [ "unmock-server" ]
CMD [ "start" ]
