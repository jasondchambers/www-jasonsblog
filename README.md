# www-jasonsblog
Website for articles

Designed to be built and run as a container.

    docker build -t www-jasonsblog:latest .
    docker scout quickview
    docker run -p 8080:80 www-jasonsblog:latest
