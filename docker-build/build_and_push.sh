docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t sujiba/pihole-unbound-hyperlocal:`cat VERSION` --push .
docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 -t sujiba/pihole-unbound-hyperlocal:latest --push .