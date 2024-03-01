# docker

Docker base images for running Kord Native applications

This image can be used as a base for the upcoming Kord Native target, please read kordlib/kord#69 for more information

# Example Usage
```Dockerfile
FROM ghcr.io/kordlib/docker:main

WORKDIR /usr/app
COPY yourbinary /usr/app/yourbinary

ENTRYPOINT ["/usr/app/yourbinary"]
```
