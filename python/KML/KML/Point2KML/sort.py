# Importing packages needed
import pandas as pd

colName = "ZONENO"
filename = "PRISMzones.csv"

# opening the node data
df = pd.read_csv(filename)
dfsort = df.sort_values(by=colName)

sortname = colName + "_" + filename
dfsort.to_csv(sortname, index_col = False)

