# docker kong openfga quickstart

## Init

```console
docker compose --profile init up -d
```

### Terraform update

```console
docker compose up terraform 
```

## Access Admin UI

<http://localhost:8002>

## Access API

<http://localhost:8000/provider/api/records>

## Access openFGA Playground

<http://localhost:3000/playground>

## Cleanup

```console
docker compose down
```
