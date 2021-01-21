from flask import Flask, render_template, request
from decimal import *
from coinbase.wallet.client import Client
import requests
client = Client(' ', ' ')

cbprice = client.get_spot_price(currency_pair = 'BTC-USD')
btcprice = str(cbprice['amount'])



app = Flask(__name__)
app.config.from_object(__name__)


@app.route('/')
def welcome():
    return render_template('form.html')


@app.route('/result', methods=['POST'])
def result():
    var_1 = request.form.get("var_1")
    var_2 = request.form.get("var_2")
    var1 = Decimal(var_1)
    var2 = Decimal(var_2)
    result = (var1 + var2)
    entry = result
    cbprice = client.get_spot_price(currency_pair = 'BTC-USD')
    BTCprice = cbprice['amount']
    btcprice = str(BTCprice)
    Fprice = open('scripts/Fcurrentsell', 'r+')
    UNprice = open('scripts/UNcurrentsell', 'r+')
    unprice = UNprice.read()
    fprice = Fprice.read()
    plist = [unprice, fprice]
    price=min(plist)
    if price == 0:
        wwdprice = open('scripts/WWDcurrentsell', 'r+')
        dprice = open('scripts/Dcurrentsell', 'r+')
        price =Decimal(wwdprice) * Decimal(dprice)
    usdtobtc = Decimal(entry) / Decimal(btcprice)
    USDTOBTC = round(usdtobtc,8)
    pww = USDTOBTC / Decimal(price)
    return render_template("result.html", priceoforder=var1, priceofshipping=var2, btcprice=btcprice, fprice=fprice, unprice=unprice, USDTOBTC=USDTOBTC, entry=entry, pww=pww)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=8888)
