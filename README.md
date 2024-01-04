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

Generate a key to be used as the signing secret

```shell
export SESSION_SECRET=$(ruby -rsecurerandom -e 'p SecureRandom.hex(32)' | tr -d '"')
```

```shell
docker compose build
docker compose up
```
