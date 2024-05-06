# www-jasonsblog
Website for articles. Will eventually be used to replace my Medium subscription.

The website is called [circleinaspiral.com](https://circleinaspiral.com).

The theme is incorporated as a submodule. Immediately, upon clone be sure to run this:

    git submodule update --init --recursive

During development, simply run the following:

    $ hugo server

To run, you can simply pull down the image from GHCR:

    $ docker login ghcr.io -u yzxbmlf
    $ docker run -p 8080:80 ghcr.io/jasondchambers/www-jasonsblog:<tag>

Replace tag with the desired number. You can find these on [GitHub](https://github.com/jasondchambers/www-jasonsblog/pkgs/container/www-jasonsblog).

The pipeline also publishes to DockerHub, as this is supported by GCP (Google Cloud Run). It is published at this [location](https://hub.docker.com/repository/docker/yzxbmlf/www-jasonsblog/general). Run as follows:

    $ docker run -p 8080:80 yzxbmlf/www-jasonsblog:<tag>

Replace tag with the desired number. You can find these on [Docker Hub](https://hub.docker.com/repository/docker/yzxbmlf/www-jasonsblog/general).

The image is built automatically as a GitHub action, however you can build locally as follows:

    $ docker build .
