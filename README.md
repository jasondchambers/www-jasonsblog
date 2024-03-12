# www-jasonsblog
Website for articles. Will eventually be used to replace my Medium subscription.

During development, simply run the following:

    $ hugo server

To run, you can simply pull down the image from GHCR:

    $ docker login ghcr.io -u yzxbmlf
    $ docker run -p 8080:80 ghcr.io/jasondchambers/www-jasonsblog:<tag>

Replace tag with the desired number. You can find these on [GitHub](https://github.com/jasondchambers/www-jasonsblog/pkgs/container/www-jasonsblog).

The image is also pushed to Docker Hub. Run as follows:

    $ docker run -p 8080:80 yzxbmlf/www-jasonsblog:<tag>

Replace tag with the desired number. You can find these on [Docker Hub](https://hub.docker.com/repository/docker/yzxbmlf/www-jasonsblog/general).

The pipeline also publishes to DockerHub, as this is supported by GCP (Google Cloud Run). It is published at this [location](https://hub.docker.com/repository/docker/yzxbmlf/www-jasonsblog/general).

Deployments are managed in [GCP](https://console.cloud.google.com/home/dashboard?hl=en&project=micro-spanner-416713).

The domain circleinaspiral.com is managed using [SquareSpace](https://account.squarespace.com/domains).
