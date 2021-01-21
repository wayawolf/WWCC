#!/bin/bash

curl -X GET --output UNcurrent.json https://api.unnamed.exchange/v1/Public/OrderBook?market=WW_BTC&depth=1
sleep 2
python3 -m json.tool UNcurrent.json > UNPcurrent.json
sleep 1
sed -i -r 's/[pric ":]//g' UNPcurrent.json
awk NR==5 UNPcurrent.json > UNUcurrent
awk '{print substr($0,2,18)}' UNUcurrent > UNUcurrentsell
cat UNUcurrentsell | awk '{printf("%0.8f",$0);}' > UNcurrentsell

curl -X GET --output WWDcurrent.json https://api.unnamed.exchange/v1/Public/OrderBook?market=WW_DOGE&depth=1
sleep 2
python3 -m json.tool WWDcurrent.json > WWDPcurrent.json
sleep 1
sed -i -r 's/[pric ":]//g' WWDPcurrent.json
awk NR==5 WWDPcurrent.json > WWDUcurrent
awk '{print substr($0,2,18)}' WWDUcurrent > WWDUcurrentsell
cat WWDUcurrentsell | awk '{printf("%0.8f",$0);}' > WWDcurrentsell

curl -X GET --output Dcurrent.json https://api.unnamed.exchange/v1/Public/OrderBook?market=DOGE_BTC&depth=1
sleep 2
python3 -m json.tool Dcurrent.json > DPcurrent.json
sleep 1
sed -i -r 's/[pric ":]//g' DPcurrent.json
awk NR==5 DPcurrent.json > DUcurrent
awk '{print substr($0,2,18)}' DUcurrent > DUcurrentsell
cat DUcurrentsell | awk '{printf("%0.8f",$0);}' > Dcurrentsell
