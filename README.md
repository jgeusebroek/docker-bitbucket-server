[![](https://images.microbadger.com/badges/image/jgeusebroek/bitbucket-server.svg)](https://microbadger.com/images/jgeusebroek/bitbucket-server "Get your own image badge on microbadger.com")
# Docker Altassian Bitbucket image

A small image containing [alpine](https://github.com/gliderlabs/docker-alpine) Linux and [Atlassian Bitbucket Server](https://www.atlassian.com/software/bitbucket).

## MySQL

This images has support for Mysql backed installations (It has the MySQL connector installed).

## Usage

    docker run -d --restart=always \
    			--name=bitbucket \
    			-p 7990:7990 \
    			-p 7999:7999 \
    			-v /var/atlassian/bitbucket \
                -d jgeusebroek/bitbucket-server

Official documentation can be found [here](https://bitbucket.org/atlassian/docker-atlassian-bitbucket-server).