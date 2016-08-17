# docker-middleman-server
Container for a static Middleman server Gem

Insert the `Dockerfile` in the same directory as your `Gemfile` then add a build line for your app in `docker-compose.yml`. The `source` directory will be a mapped volume.

## Using docker-compose.yml
```docker-compose.yml
version: '2'
services:
  app:
    build: .
    volumes:
      - ./source:/usr/src/app/source
```

## Viewing your static site alongside others
This container was build with nginx-reverse-proxy in mind. Jwilder has a great container [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) that enables serving multiple v-hosts to a single port IE :80. 

To serve this site with others, add the following lines to your docker-compose.yml. Substitue `site.dev` with the domain name you'd like to use. Remember to add this entry to your `/etc/hosts` file.
```docker-compose.yml
  app:    
    ...
    environment:
      - VIRTUAL_HOST=site.dev
networks:
      default:
        external:
          name: shared-network
```

Note that in order to enable cross container networking, you must specify an external network to use. This example assumes you are using a docker network called `shared-network`. For more information on Docker networking checkout out [their documentation](https://docs.docker.com/engine/userguide/networking/).

## Defining your own port 
If you are not using a reverse proxy and can't use the default port 80, then some changes must be made.

First the `Dockerfile` is built exposing port 80, which is assumed from the gem's `config.rb` file. Determine your site's port, then modify the `Dockerfile` to replace the `EXPOSE 80` with whatever port number required.

If you've already built the docker container, you may need to rebuild it after making the appropriate changes. Run `docker-compose build` to rebuild the container and try again.