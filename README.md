[![](https://badge.imagelayers.io/jgeusebroek/bitbucket-server:latest.svg)](https://imagelayers.io/?images=jgeusebroek/bitbucket-server:latest 'Get your own badge on imagelayers.io')

# Docker Altassian Bitbucket image

A small image containing [gliderlabs/docker-alpine](https://github.com/gliderlabs/docker-alpine) Linux and [Atlassian Bitbucket Server](https://www.atlassian.com/software/bitbucket).

## Usage

    docker run -d --restart=always \
    			--name=bitbucket \
    			-p 7990:7990 \
    			-p 7999:7999 \
    			-v /var/atlassian/bitbucket \
                -d jgeusebroek/bitbucket-server

Official documentation can be found [here](https://bitbucket.org/atlassian/docker-atlassian-bitbucket-server).