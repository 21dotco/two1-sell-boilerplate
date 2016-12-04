# `21 sell` Machine-Payable Container Boilerplate

This repository contains a runnable boilerplate for a machine-payable `21 sell` container that returns the string 'Hello, world' for every `21 buy` request on its `/hello` route. If you do not have a 21 account, please go to https://21.co to sign up.

Follow the steps in the "Quickstart" section to get to know the lifecycle of a `21 sell` container, then follow the examples in the "Modifying the Boilerplate" section to customize the boilerplate to your specific application.

# Quickstart

## Clone the boilerplate repository

with HTTPS

```sh
git clone https://github.com/21dotco/two1-sell-boilerplate.git
```

with SSH (make sure you've [generated and added your SSH public key to github](https://help.github.com/articles/generating-an-ssh-key/))

```sh
git clone git@github.com:21dotco/two1-sell-boilerplate.git
```

## Building, tagging, and pushing to your docker repo

To build the image as `<dockerhub_username>/hello21` locally, do

```sh
cd two1-sell-boilerplate
docker build -t <dockerhub_username>/hello21 .
```

Optionally, if you have a Docker Hub account, you can upload the image so that it is available on other machines (make sure you've completed the steps [here](https://docs.docker.com/docker-hub/accounts/))

```sh
docker login
docker push <dockerhub_username>/hello21
```

## Registering your repo with `21 sell`

To register your service with `21 sell` as `hello21` so that it'll be listed under `21 list`, `21 status --detail` and started with `21 sell start --all`

```sh
21 sell add hello21 <dockerhub_username>/hello21
```

To see currently registered repos

```sh
21 sell list
```

## Starting your `21 sell` container

While running the following command, make sure to confirm that you want to publish so we can buy from the container

```sh
21 sell start hello21
```
Your container will be started under the name `sell_hello21`

## Buying from your `21 sell` container

Visit `21.co/<your-21.co-username>` to see the service you've just published. It should have "**Hello, World!**" as the title.

To buy from your own service, look for the command under your service's usage tab formatted as such:

```sh
21 buy <your-21.co-username>/hello-world<random-identifier>/hello21/hello
```

To check the balance of your `21 sell` container

```sh
21 sell status --detail
```

## Stopping your `21 sell` container

```sh
21 sell stop hello21
```

You can also unpublish your `21 sell` service

```sh
21 publish list  # copy the four letter ID for your service
21 publish remove <service-id>
```


# Modifying the Boilerplate

Modifying the boilerplate to suite your specific application will typically involve modifying the:

- `server.py` for server logic (see [here](http://flask.pocoo.org/) for information on `flask` and [here](https://21.co/learn/intro-to-21/#create-your-first-bitcoin-payable-api) for relevant information on `two1`)
- `setup.py` for module dependencies and metadata (see [here](https://docs.python.org/3.5/distutils/setupscript.html) for more information)
- `manifest.yaml` for metadata that will be displayed on the [21 marketplace](mkt.21.co) (see [here](21.co/learn/21-app-manifest) for more information)

## Example 1: Modifying the route of your machine-payable endpoint

In `server.py`, find the line

```python
@app.route('/hello')
```

and replace `hello` with the desired route

> Note: You may want to change the function name on the line `def hello():` as well

You also want to modify the `x-21-quick-buy` field in `manifest.yaml` to reflect this change

```yaml
info:
  ...
  x-21-quick-buy: "$ 21 buy http://%s:%s/%s/hello"
  ...
```

by replacing `hello` with the aforementioned desired route

> Note: The three %-style formatting placeholders are formatted with the ZeroTier IP and port number of your payment server, and the name of your service respectively.

## Example 2: Change the price of your machine-payable endpoint

In `server.py`, find the line

```python
@payment.required(5000, server_url=os.environ.get("PAYMENT_SERVER_IP", None))
```

and replace `5000` with the desired price in satoshis

You also want to modify `manifest.yaml` to reflect this change

```yaml
info:
  ...
  x-21-total-price:
    min: 5000
    max: 5000
  ...
```

by replacing the two `5000`'s with the aforementioned desired price in satoshis

## Example 3: Adding an additional dependency

If you've modified the server logic under `server.py` have imported additional dependencies, make sure to include them in `setup.py`

For a dependency `Foo` at version 2.1.0, make sure it appears under the `install_requires` kwarg to setuptools.setup

```python
setuptools.setup(
	...
    install_requires=[  # list all dependencies for your project here
        ...
        "Foo=2.1.0",
        ...
    ],
    ...
)
```
