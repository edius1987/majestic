#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import requests
import os

PRICE_CHANGE_PERIOD = '1h'
PRICE_CHANGE_URGENT_PERCENT = 10
API_URL = 'https://api.coinmarketcap.com/v1/ticker/{}/'

coin = os.environ.get('1', 'bitcoin')
r = requests.get(API_URL.format(coin))
data = json.loads(r.text)[0]
price = float(data['price_usd'])
end = '%{F-}'

if price > 100: precision = 0
elif price > 0.1: precision = 2
else: precision = 6

percentChange = float(data['percent_change_' + PRICE_CHANGE_PERIOD])
percentChangeFormat = '{}{}{:.2f}%{}'

if percentChange > 0: percentChangeInfo = percentChangeFormat.format('%{F#9FE697}', '', percentChange, end)
elif percentChange == 0: percentChangeInfo = percentChangeFormat.format('%{F#CCCCCC}', '', percentChange, end)
else: percentChangeInfo = percentChangeFormat.format('%{F#BF616A}', '', percentChange, end)

print(('{:.' + str(precision) + 'f} {}').format(price, percentChangeInfo))