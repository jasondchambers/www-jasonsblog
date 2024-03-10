# www-jasonsblog
Website for articles. Will eventually be used to replace my Medium subscription.

To run, you can simply pull down the image from GHCR:

    $ docker login ghcr.io -u yzxbmlf
    $ docker run -p 8080:80 ghcr.io/jasondchambers/www-jasonsblog:latest

The pipeline also publishes to DockerHub, as this is supported by GCP (Google Cloud Run). It is published at this [location](https://hub.docker.com/repository/docker/yzxbmlf/www-jasonsblog/general).

Deployments are managed in [GCP](https://console.cloud.google.com/home/dashboard?hl=en&project=micro-spanner-416713).

The domain circleinaspiral.com is managed using [SquareSpace](https://account.squarespace.com/domains).
