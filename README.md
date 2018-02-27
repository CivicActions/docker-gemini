# Docker Image for Gemini

Learn more about Gemini at https://gemini-testing.github.io/

## Getting started

Create a directory ("gemini" in example below) with your Gemini JSON/YAML configuration file and tests (see Gemini documentation).

You can use the Docker Hub image (`civicactions/docker-gemini`) to run the Gemini CLI:
```
docker run -it --rm -v $(pwd)/gemini:/home/node/app civicactions/docker-gemini gemini --help
docker run -it --rm -v $(pwd)/gemini:/home/node/app civicactions/docker-gemini gemini test .
```

Or the GUI, which will be available on http://localhost:8000:
```
docker run -it --rm -v $(pwd)/gemini:/home/node/app -p 8000:8000 civicactions/docker-gemini gemini-gui --hostname=0.0.0.0 .
```

Note the `.`, which indicates tests are in the /home/node/app directory (the default working directory in the container). If your tests are in a subdirectory you can specify that instead.

A custom entrypoint will transparently run each command as a user with the UID/GID of the owner of the /home/node/app directory. This means that the external user with this UID/GID will have ownership of directories and baseline images created by Gemini.

## Building the image

To build this image from scratch clone this repository then run:
```
docker build -t gemini .
```

You can use this image in the examples above by replacing `civicactions/docker-gemini` with `gemini`.
