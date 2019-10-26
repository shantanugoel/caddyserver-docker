Build:
docker build -t caddyserver:1.0.3 .

Run:
docker run -it --name caddyserver -p 80:80 -p 443:443 -e CLOUDFLARE_EMAIL=${CLOUDFLARE_EMAIL} -e CLOUDFLARE_API_KEY=${CLOUDFLARE_API_KEY} -e CADDY_ENV_TLS_EMAIL="mymail@test.com" -v $HOME/.caddy:/home/caddy/.caddy shantanugoel/caddyserver:1.0.3

- Remove the "ca" line in files/Caddyfile while copying it or using the same to
  get actual valid certs
- Override the built-in Caddyfile with your own using "-v" argument while
  starting your container
