# Importing packages
# from bng_to_latlon import WGS84toOSGB36
import requests
import json

# cycle route API


API_KEY='fc13e86f9a7af07a'

# route start and end

# 52.483076, -1.895377

start = "-1.952142,52.442081"
end = "-1.895377,52.483076"

params=dict(key=API_KEY,
            itinerarypoints=start+",Start|" + end + ",End",
            plan="quietest")
r = requests.get('https://www.cyclestreets.net/api/journey.json', params=params)

jsonRoute = r.text

# convert to python dictionary
dictRoute = json.loads(jsonRoute)

# loop over route section and extract attibutes
for i in range(1,len(dictRoute["marker"])):
    sectionAtt = dictRoute["marker"][i]["@attributes"]
    print("Name: " + sectionAtt["name"] + ", Distance: " + sectionAtt["distance"] + ", Provision Name: " + sectionAtt["provisionName"] + ",Turn: " + sectionAtt["turn"])




# cycle parking points API

"""params = dict(key=API_KEY,
              type='cycleparking',
              bbox='0.111035,52.201395,0.125325,52.209285',
              limit='3',
              field=['id','latitude','longitude','name','osmTags'])
r = requests.get('https://api.cyclestreets.net/v2/pois.locations', params=params)
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)
print(r.text)
print(r.url)
print(r.json())"""
