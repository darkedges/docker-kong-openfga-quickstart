# docker kong quickstart

## Init

```console
docker compose --profile init up -d
```

### Terraform update

```console
docker compose up terraform 
```

## Access Admin UI

<http://kong.7f000001.nip.io:8002>


## Access API

<http://kong.7f000001.nip.io:8000/provider/api/records>

## Cleanup

```console
docker compose down
```
