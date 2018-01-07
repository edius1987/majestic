#!/bin/python
# -*- coding: utf-8 -*-

import requests
import datetime

# Comente
from weathercfg import *

# Descomente e preencha
#CITY = "3467747"
#API_KEY = "SUA_API_KEY"
UNITS = "Metric"
UNIT_KEY = "C"

# {
# "coord":{"lon":-54.65,"lat":-20.44},
# "weather":[{"id":211,"main":"Thunderstorm","description":"thunderstorm","icon":"11d"},{"id":521,"main":"Rain","description":"shower rain","icon":"09d"}],
# "base":"stations","main":{"temp":23,"pressure":1013,"humidity":88,"temp_min":23,"temp_max":23},
# "visibility":10000,
# "wind":{"speed":3.6,"deg":270},
# "clouds":{"all":75},
# "dt":1515344400,
# "sys":{"type":1,"id":4473,"message":0.002,"country":"BR","sunrise":1515315967,"sunset":1515363852},
# "id":3467747,"name":"Campo Grande","cod":200
# }
REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units={}".format(CITY, API_KEY, UNITS))
try:
    # HTTP CODE = OK
    if REQ.status_code == 200:
        CURRENT = REQ.json()["weather"][0]["description"].capitalize()
        VELOCIDADE = REQ.json()["wind"]["speed"]
        DIRECAO = REQ.json()["wind"]["deg"]
        PRESSAO = REQ.json()["main"]["pressure"]
        VISIBILIDADE = REQ.json()["visibility"]
        ID = int(float(REQ.json()["weather"][0]["id"]))
        TEMP = int(float(REQ.json()["main"]["temp"]))
        HOUR = datetime.datetime.now().hour

        #for k, v in REQ.json().iteritems():
        #    print k, v

        if DIRECAO > 270 and DIRECAO <= 45:
            DIRECAO = "norte"
        elif DIRECAO > 45 and DIRECAO <= 135:
            DIRECAO = "norte"
        elif DIRECAO > 135 and DIRECAO <= 225:
            DIRECAO = "sul"
        elif DIRECAO > 225 and DIRECAO <= 270:
            DIRECAO = "oeste"

        if CURRENT == "Scattered clouds":
            CURRENT = "Nuvens dispersas"
        elif CURRENT == "Thunderstorm":
            CURRENT = "Trovoada"
        elif CURRENT == "Thunderstorm with light rain":
            CURRENT = "Trovoada com chuva fina"
        elif CURRENT == "Few clouds":
            CURRENT = "Poucas nuvens"
        elif CURRENT == "Broken clouds":
            CURRENT = "Nuvens esparsas" 
        elif CURRENT == "Clear sky":
            CURRENT = "Céu claro"
        elif CURRENT == "Moderate rain":
            CURRENT = "Chuva moderada"
        elif CURRENT == "Thunderstorm with heavy rain":
            CURRENT = "Trovoada com chuva pesada"
        elif CURRENT == "Light rain":
            CURRENT = "Chuva leve"
        elif CURRENT == "Light intensity shower rain":
            CURRENT = "Chuva leve"

        if ID >= 200 and ID <= 232:
            ICON = ""
        elif ID == 501 or ID == 500 or ID == 520:
            ICON = ""
        elif ID >= 310 and ID <= 531:
            ICON = ""
        elif ID >= 600 and ID <= 622:
            ICON = ""
        elif ID >= 701 and ID <= 761:
            ICON = ""
        elif ID >= 801 and ID <= 804:
            if HOUR >= 6 and HOUR <= 19:
                ICON = ""
            else:
                ICON = ""
        elif ID >= 900 and ID <= 902 or ID >= 957 and ID <= 962:
            ICON = ""
        elif ID == 903 or ID == 906:
            ICON = ""
        elif ID == 904:
            ICON = ""
        elif ID == 905 or ID >= 951 and ID <= 956:
            ICON = ""
        else:
            if HOUR >= 6 and HOUR <= 19:
                ICON = ""
            else:
                ICON = ""
        print("%%{F#FFF}%s %%{F-}%s, %i°%s, %skm/h %s, %shPa " % (ICON, CURRENT, TEMP, UNIT_KEY, VELOCIDADE, DIRECAO, PRESSAO)) # Icon with description

    else:
        print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
except (ValueError, IOError):
    print("Erro: Unable print the data")
