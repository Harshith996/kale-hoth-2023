import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
import mysql.connector
import sys
import json
import warnings
warnings.filterwarnings("ignore")

data = sys.argv[1]
my_array = data.split(',')
calorie_down = float(my_array[0])
calorie_up = float(my_array[1])
calorie_intake = (calorie_up + calorie_down) / 2
carbonfp = my_array[2]
vegan = my_array[3]
gluten = my_array[4]
dairy = my_array[5]

lst = []

mydb = mysql.connector.connect(
  host="localhost",
  user="harshith_hothuser",
  password="dCE0%WpV4kCB",
  database="harshith_hoth"
)
try:
    query = 'SELECT * FROM food_data WHERE calories BETWEEN ' + str(int(calorie_down)) + ' AND ' + str(int(calorie_up)) + ' AND meal_type in (3,4,5)'
    if vegan == '1':
        query = query + ' AND vegan = ' + vegan
    if gluten == '0':
        query = query + ' AND gluten = ' + gluten
    if dairy == '0':
        query = query + ' AND dairy = ' + dairy
    query = query + ';'

    
    result_dataFrame = pd.read_sql(query,mydb)
    mydb.close() #close the connection
    temp = ''
    for i in range(0, 5):
        if temp != '':
            # print(result_dataFrame['dish'])
            result_dataFrame = result_dataFrame[result_dataFrame.dish != temp]
            # print(result_dataFrame)
        X = result_dataFrame[['calories', 'carbonfp']]
        y = result_dataFrame['dish']
        neigh = KNeighborsClassifier(n_neighbors=3)
        neigh.fit(X, y)
        temp = neigh.predict([[calorie_intake, carbonfp]])[0]
        lst.append(temp)
        # print(neigh.predict([[calorie_intake, carbonfp]]))
    dinner = json.dumps(lst)
    print(dinner)
except Exception as e:
    mydb.close()
    # print(str(e))