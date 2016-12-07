import os
import flask
from two1.wallet import Wallet
from two1.bitserv.flask import Payment
from two1.sell.util.decorators import track_requests


app = flask.Flask(__name__)
payment = Payment(app, Wallet())


@app.route('/hello')
@payment.required(5000, server_url=os.environ.get("PAYMENT_SERVER_IP", None))  # sets up payment channel support
@track_requests  # allows `21 sell status --detail` to show correct stats
def hello():
    return 'Hello, world'


if __name__ == "__main__":
    app.run(host="::", port=5000)  # each app must run on port 5000 for router container to reach it successfully
