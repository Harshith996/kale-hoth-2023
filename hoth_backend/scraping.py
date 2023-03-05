import requests
from bs4 import BeautifulSoup
import mysql.connector

cnx = mysql.connector.connect(user='harshith_hothuser', password='dCE0%WpV4kCB',
                              host='localhost',
                              database='harshith_hoth')
cursor = cnx.cursor()


#taking the parent like and starting the fun

def food_processing(food, meal_type, dining_hall, meta_all):
        for food in foods: #this gets all the food in a dining hall

            #print(food.text)
            food_temp = food.text
            #note: gluten = 0 means doesnt contain gluten, similarly for vegan and dairy, carbon = 1 means normal on our scale (no earth symbol)
            carbon = 0 # 1 means green earth, -1 means red earth
            gluten = 0
            vegan = 0
            dairy = 0
            calorie = 0 # 1 means low calorie, -1 means high calorie

            # (food['href']) gives the link to the recipe of the food
            link_to_food = food['href']
            res = requests.get(link_to_food)
            soup2 = BeautifulSoup(res.content, 'html.parser')


            if soup2.find('div', {'class':'redirect-info'}) is None:  ### This is for the food whose data we dont have in the wesbite
                filters = soup2.find('div', {'class': 'productinfo'}).text  #this contains info about carbon footprint, gluten, vegan etc
                filters = filters.split('\n')
                if "\xa0Contains Gluten" in filters:
                    gluten = 1
                if "\xa0Contains Dairy" in filters:
                    dairy = 1
                if "\xa0Vegan Menu Option" in filters:
                    vegan = 1
                if "\xa0Low Carbon Footprint" in filters:
                    carbon = 1
                if "\xa0High Carbon Footprint" in filters:
                    carbon = -1

                #getting the calorific value of the food
                health = 0 # 1 is healthy, -1 is not healthy
                calories = soup2.find('p', {'class': 'nfcal'}).text
                calorie = ""
                for i in calories:
                    if i >= "0" and i <= "9":
                        calorie += i
                
                if calorie != "":

                    #add health data here   ---- TO BE DONE

                    #finally adding all the data in a arrya and pushing it to the main meta
                    meta_food = (food_temp, dining_hall, meal_type ,calorie, health, carbon, dairy, gluten, vegan, link_to_food)
                    print(meta_food)  #-- check for all food in a dining hall
                    meta_all.append(meta_food)

        query = "INSERT INTO food_data(dish, dining_hall, meal_type, calories, health, 	carbonfp, dairy, gluten, vegan, url ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.executemany(query, meta_all)
        cnx.commit()


parent_link = "https://menu.dining.ucla.edu/"
get = requests.get(parent_link)
beautiful_soup = BeautifulSoup(get.content, 'html.parser')

all_dining = beautiful_soup.find_all('span', {'class': 'unit-name'})
for dining in all_dining:
    dining_url = dining.a['href']
    if dining_url[0] == "/":
        url = "https://menu.dining.ucla.edu" + dining_url
        print(url)

        response = requests.get(url)

        soup = BeautifulSoup(response.content, 'html.parser')

        meta_all = [] #this will hold all the information possible

        # getting the dining hall name
        #
        #
        dining_hall = dining_url[7:]

        #getting the meal time
        #
        #
        if dining_hall == "Rendezvous":
            meal_type = 4  #4 means all day food
            foods = soup.find_all('a', {'class': 'recipelink'})
            food_processing(foods, meal_type, dining_hall, meta_all)

        elif dining_hall == "HedrickStudy":
            for foods_head in soup.find_all('div', {'class': 'swiper-slide'}):
                all_meal = foods_head.text
                #print(all_meal[3:17] == "Lunch & Dinner")
                if all_meal[8:14] == "Bakery":
                    meal_type = 4
                    foods = foods_head.find_all("a", class_="recipelink")
                    food_processing(foods, meal_type, dining_hall, meta_all)

                elif all_meal[3:12] == "Breakfast":
                    meal_type = 1
                    foods = foods_head.find_all("a", class_="recipelink")
                    food_processing(foods, meal_type, dining_hall, meta_all)
                elif all_meal[3:17] == "Lunch & Dinner":
                    meal_type = 5   # type means both lunch and dinner
                    foods = foods_head.find_all("a", class_="recipelink")
                    food_processing(foods, meal_type, dining_hall, meta_all)
                else:
                    meal_type = 4
                    foods = foods_head.find_all("a", class_="recipelink")
                    food_processing(foods, meal_type, dining_hall, meta_all)
        else:
            # there are three divs depending on the meals left on that day
            if soup.find("div", {'class': 'menu-block half-col'}) is None and soup.find("div", {'class': 'menu-block whole-col'}) is None:
                meal_type_header =  soup.find_all("div", {'class': 'menu-block third-col'})
            elif soup.find("div", {'class': 'menu-block whole-col'}) is None:
                meal_type_header = soup.find_all("div", {'class': 'menu-block half-col'})
            else:
                meal_type_header = soup.find_all("div", {'class': 'menu-block whole-col'})

            for i in meal_type_header:
                meal_type = i.find("h3",{'class': 'col-header'}).text
                print(meal_type)
                if meal_type == "Breakfast":
                    meal_type = 1
                elif meal_type == "Lunch":
                    meal_type = 2
                elif meal_type == "Dinner":
                    meal_type = 3
                foods = soup.find_all('a', {'class': 'recipelink'})
                food_processing(foods, meal_type, dining_hall, meta_all)


cnx.close()





