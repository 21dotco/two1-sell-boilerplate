FROM 21dotco/two1:base
MAINTAINER Satoshi Nakamoto

RUN apk add --no-cache linux-headers

# Switch the current working directory `./` on the container to `/usr/src/app`
WORKDIR /usr/src/app

# Copy the contents of `hello21/` on the host to `./` on the container, which is now `/usr/src/app`
COPY . ./

# Install the contents of `./` on the container according to `hello21/setup.py`
RUN pip3 install -e . -U

# Copy the entrypoint of our app `hello21/entrypoint.sh` on the host to `/usr/local/bin` on the container making it present on said container's $PATH
COPY entrypoint.sh /usr/local/bin/

# Turn on the execute permission bit of the `entrypoint.sh` script that we just copied to `/usr/local/bin` on the container
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint of the docker container to `entrypoint.sh` which should be in our docker container's $PATH since we've already copied it to `/usr/local/bin` on said container
ENTRYPOINT ["entrypoint.sh"]
