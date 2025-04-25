# Requirement
import os
res1 = 'python3.11 -m pip install pandas'
res2 = 'python3.11 -m pip install bs4'
os.system(res1)
os.system(res2)
# Dependency
import requests
import sqlite3
import pandas as pd
from bs4 import BeautifulSoup
# Target
url = 'https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc'
db_name = 'Movies.db'
table_name = 'Top_50'
csv_path = '/home/project/top_100_films.csv'
df = pd.DataFrame(columns=["Average Rank","Film","Year"])
count = 0

html_page = requests.get(url).text
data = BeautifulSoup(html_page, 'html.parser')
# Scraping inside table tag tbody 
tables = data.find_all('ul')
print(tables)
rows = tables[0].find_all('li')
print(rows)
for row in rows:
    if count<50:
        col = row.find_all('td')
        if len(col)!=0:
            data_dict = {"Average Rank": col[0].contents[0],
                         "Film": col[1].contents[0],
                         "Year": col[2].contents[0]}
            df1 = pd.DataFrame(data_dict, index=[0])
            df = pd.concat([df,df1], ignore_index=True)
            count+=1
    else:
        break
# Store file
df.to_csv(csv_path)
conn = sqlite3.connect(db_name)
df.to_sql(table_name, conn, if_exists='replace', index=False)
conn.close()