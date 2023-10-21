# Guacenc

Based and forked from bytepen's work. Thanks to him.

Original code source can be found here https://gitlab.com/bytepen/dockerfiles/guacenc



I've been getting into Apache Guacamole recently, but one thing that I've found a bit annoying is there there doesn't appear to be an easy way to automatically convert recordings into videos.
I created this docker image to solve that problem.

I have build a Dockerfile in `./build` that compiles the latest guacenc from source.
The `./build.sh` script builds this image, creates a container from it, copies out the built guacenc and its libguac dependencies, it then builds the primary guacenc docker image.
The primary guacenc docker image has been optimized to be as small as possible while still being fully functional.

## Usage

If you're not looking to actually compile and build the latest version, you can just use mine which is published to Docker Hub under `bytepen\guacenc:latest`.

The container will monitor whatever is mapped to its `/record` directory, so if I kept my recordings in `/recordings/Guacenc/{box_one,box_two,box_three}`, I would run the container as follows:
```
docker run -d -v '/recordings/Guacenc':'/record' --name guacenc bytepen/guacenc:latest
```

As described below, you can set a variable to stop this container from automatically converting recordings.
If you set it up like that, you'll most likely want to convert individual videos manually.
You can drop into the container, navigate to the recording, and then execute `convert <recording_name>`, which will automatically determine the native resolution and convert it to an m4v just as autoconversion would.

## Variables

There are several environmental variables that will configure how this container works.

| Name | Default Value | Description
| -- | -- | --
| AUTOCONVERT | "false" | If set to "true", it will automatically convert unconverted videos in `/record`
| AUTOCONVERT_WAIT | 60 | Seconds to wait between checking for new recordings to convert


```
docker run -d -v '/recordings/Guacenc':'/record' -e 'AUTOCONVERT'='true' --name guacenc bytepen/guacenc:latest
```
