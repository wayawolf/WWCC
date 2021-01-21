#!/bin/bash

curl https://api.freiexchange.com/public/WW > Fcurrent.json
awk NR==10 Fcurrent.json > Fcurrentsell
sed -i -r 's/[last":,]//g' Fcurrentsell
sed -i -r 's/.{21}//' Fcurrentsell
