docker run -d --rm -p 8000:8000 -p 8008:8008 -p 8443:8443 -v $(pwd)/__unmock__:/app/__unmock__ --name unmock-server unmock/unmock-server
