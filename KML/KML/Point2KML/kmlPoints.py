# Importing packages needed
from pykml.factory import ATOM_ElementMaker as ATOM
from pykml.factory import GX_ElementMaker as GX
from pykml.factory import KML_ElementMaker as KML
from lxml import etree
from bng_to_latlon import OSGB36toWGS84
import pandas as pd
import math as ma

# opening the node data
pointFile = 'ZONENO_PRISMzones.csv'
pointData = pd.read_csv(pointFile)
circPoint = "http://maps.google.com/mapfiles/kml/shapes/placemark_circle_highlight.png"

# Setting scaling options

numScale = 101
minScale = 0.5
maxScale = 2
step = (maxScale - minScale)/(numScale - 1)
intList = range(0,numScale)
floatScaleList = [round(minScale + step*float(item),10) for item in intList]

# Looking at data to scale from

maxData = pointData.iloc[:,3].max()
minData = pointData.iloc[:,3].min()
stepData = (maxData - minData)/(numScale - 1)

doc = KML.Document()
for scale in floatScaleList:
    style = KML.Style(
                KML.IconStyle(
                    KML.scale(scale),
                    KML.Icon(
                        KML.href(circPoint),
                    )
                ),
                id=str(scale)
            )
    doc.append(style)

pFld = KML.Folder()
for i, row in pointData.iterrows():
# converting coordinates
    pointNumStr = str(row[0])
    latlon = OSGB36toWGS84(row[1],row[2])
    latlonStr = str(latlon[1]) + "," + str(latlon[0])
# defining style
    scaleIDFloat = floatScaleList[int(ma.floor((row[3] - minData)/stepData))]
    scaleIDStr = str(scaleIDFloat)
    pMarker = KML.Placemark(
                 KML.name(pointNumStr),
                 KML.styleUrl('#' + scaleIDStr),
                 KML.Point(
                     KML.coordinates(latlonStr)
                 )
              )
# setting the extended data
    extData = KML.ExtendedData()
    colnames = pointData.columns.get_values().tolist()
    for j, name in enumerate(colnames):
        if j > 2:
            data = KML.Data(KML.value(str(row[j])),name=name)
            extData.append(data)
    pMarker.append(extData)
    pFld.append(pMarker)

doc.append(pFld)
kmlFile = KML.kml(doc)

outfile = file(pointFile[:-4] + '.kml','w')
outfile.write(etree.tostring(kmlFile, pretty_print=True))

