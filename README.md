# Laravel CI Image

Pre-Built Laravel Docker Images on CI services.
https://hub.docker.com/r/euclid1990/laravel-ci-image

## TO DO List

- [x] Circle CI
- [] Scrutinizer CI
- [] Sun CI

## Build

- Circle CI
```console
$ docker build --file circleci/Dockerfile --tag laravel-ci-image:circleci . --rm
```
