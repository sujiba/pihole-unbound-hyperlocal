# Build it yourself

https://docs.docker.com/buildx/working-with-buildx/#work-with-builder-instances

 ```
 # This creates a new builder instance with a single node based on your current configuration.
 docker buildx create
 # To list all available builders, use
 docker buildx ls
 # To switch between different builders, use
 docker buildx use <name>
 # After creating a new instance, you can delete it with
 docker buildx rm <name>
```

Build it as a multi-platform image:
```
chmod +x build_and_push.sh
./build_and_push.sh
```