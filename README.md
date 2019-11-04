# Unmock server Docker image

## Instructions

### 1. Prepare mocked APIs

Prepare OpenAPI specifications you want to mock in `__unmock__` folder. For example, to mock `api.github.com`:

```bash
# Prepare directory
mkdir -p __unmock__/githubv3
# Write openapi.yaml to the directory
wget https://raw.githubusercontent.com/unmock/golang-example/master/__unmock__/githubv3/openapi.yaml -O __unmock__/githubv3/openapi.yaml
```

### 2. Start Unmock container

Run `unmock-server` image, mounting `__unmock__` folder you just prepared:

```bash
docker run -d --rm -p 8000:8000 -p 8008:8008 -p 8443:8443 -v $(pwd)/__unmock__:/app/__unmock__ --name unmock-server unmock/unmock-server
```

### 3. HTTPS only: trust Unmock certificates

To mock HTTPS APIs, Unmock generates a self-signed certificate for the signed domain on the fly. Because the certificate is not signed by your root CA, your HTTP client will fail the call (and that's good).

To use Unmock with HTTPS, you need to

1. Fetch the Unmock certificate used for signing the certificates

   > `wget https://raw.githubusercontent.com/unmock/unmock-js/dev/packages/unmock-server/certs/ca.pem`

1. Trust the certificate when using Unmock

   > For cURL, you would set
   >
   > - `SSL_CERT_FILE=ca.pem`, or
   > - `CURL_CA_BUNDLE=ca.pem`.

### 4. Start making calls

Make a call to `api.github.com` with `curl` using the proxy server:

```bash
https_proxy=http://localhost:8008 SSL_CERT_FILE=ca.pem curl -i https://api.github.com/user/repos
```

### 5. Stop the container

```bash
docker stop unmock-server
```

## Development

Build image:

```
./build.sh
```

Run image:

```
./run.sh
```

Publish:

```bash
docker login
docker push unmock/unmock-server:<tag>
```
