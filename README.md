# Example App

## Local

Setup:

```shell
bin/app setup
```

Run:

```shell
bin/app start
```

Sinatra console:

```shell
bin/app console
```

## Production

```shell
# Generate a key to be used as the signing secret
export SESSION_SECRET=$(ruby -rsecurerandom -e 'p SecureRandom.hex(32)' | tr -d '"')

# [OPTIONAL] Specify a port. Defaults to 8080
export APP_PORT=4567
```

```shell
docker compose build
docker compose up
```
