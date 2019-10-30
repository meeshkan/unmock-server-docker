# Unmock server Docker image

## Instructions

### 1. Prepare self-signed certificates

Write certificates to `certs/` folder using the `build-cert.sh` script in `unmock/unmock-server` image:

```bash
docker run -v `pwd`/certs:/app/certs unmock/unmock-server bash build-cert.sh api.github.com certs/
```

> Why is this step needed? If you make HTTPS calls to the mock server, the server needs to return a public certificate matching the expected domain name. You currently need to specify the domain name before-hand as we don't generate certificates on-fly.

> Construction work ahead 👷‍♀️: We're working on removing the need to manually create the certificates .

### 2. Prepare mocked APIs

Prepare OpenAPI specifications you want to mock in `__unmock__` folder. For example, to mock `api.github.com`:

```bash
# Prepare directory
mkdir -p __unmock__/githubv3
# Write openapi.yaml to the directory
wget https://raw.githubusercontent.com/unmock/golang-example/master/__unmock__/githubv3/openapi.yaml -O __unmock__/githubv3/openapi.yaml
```

### 3. Run image

Run image, mounting `certs` and `__unmock__` folders you just prepared:

```bash
docker run -v $(pwd)/certs:/app/certs -v $(pwd)/__unmock__:/app/__unmock__ unmock/unmock-server
```

> Construction work ahead 👷‍♂️: Image currently expects to find `cert.pem` and `key.pem` in `certs/` folder. We're working on alternative ways to supply the certificate. We are also working on removing the need to supply a certificate if you're only using HTTP.

## Development

Build image:

```
./build.sh
```

Run image

```
./run.sh
```
