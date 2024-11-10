# Requirement 
import os
def requirement():
    with open('requirement.txt', 'w') as file:
        file.write('requests \n bs4 \n pandas\n numpy\n datetime\n')
        file.close()
    res1='wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-PY0221EN-Coursera/labs/v2/exchange_rate.csv'
    os.system('python3.11 -m pip install -r requirement.txt')
    os.system(res1)
# requirement()

# Dependency 
import glob    
from datetime import datetime
import requests
from bs4 import BeautifulSoup
import pandas as pd
import sqlite3
# Params
log_message = [ 'Preliminaries complete. Initiating ETL process',
                'Data extraction complete. Initiating Transformation process',
                'Data transformation complete. Initiating Loading process',
                'Data saved to CSV file',
                'SQL Connection initiated',
                'Data loaded to Database as a table, Executing queries',
                'Process Complete',
                'Server Connection closed'
                ]
url = 'https://web.archive.org/web/20230908091635 /https://en.wikipedia.org/wiki/List_of_largest_banks'
csv = 'https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-PY0221EN-Coursera/labs/v2/exchange_rate.csv'
output = './Largest_banks_data.csv'
database = 'Banks.db'
table_name = 'Largest_banks'
logfile = 'code_log.txt'
exchange_rate = 'exchange_rate.csv'
table_attribs = ['Name', 'MC_USD_Billion']
query_statements = [
        'SELECT * FROM Largest_banks',
        'SELECT AVG(MC_GBP_Billion) FROM Largest_banks',
        'SELECT Name from Largest_banks LIMIT 5'
    ]
switch_check = 0
# Structure
# Task 1
def log_progress(message):
    ''' This function logs the mentioned message of a given stage of the
    code execution to a log file. Function returns nothing'''
    now=datetime.now()
    statement = now.strftime("%d-%m-%Y: %H:%M:%S")
    statement = (f'{statement}: {message}\n')
    with open(logfile,'a') as file:
        file.write(statement)
        file.close()
# Task 2
def extract(url, table_attribs):
    df=pd.DataFrame(columns=table_attribs)
    ''' This function aims to extract the required
    information from the website and save it to a data frame. The
    function returns the data frame for further processing. 
    table_attribs: table attributes, as a list ['a','b','c',..]'''
    request = requests.get(url)
    content = request.text
    proceed= BeautifulSoup(content,'html.parser')
    table = proceed.find_all('tbody')[0]
    row = table.find_all('tr')
    for index,val in enumerate(row):
        if index > 0 :
            name = val.contents[3].text.replace('\n','')
            value = round(float(val.contents[5].text),2)
            res = pd.DataFrame({table_attribs[0]:name,table_attribs[1]:value}, index=[0])
            df = pd.concat([df,res],ignore_index=True)
    return df
# Task 3
def transform(df, csv_path):
    ''' This function accesses the CSV file for exchange rate
    information, and adds three columns to the data frame, each
    containing the transformed version of Market Cap column to
    respective currencies'''
    temp = pd.read_csv(csv_path)
    
    df['MC_EUR_Billion'] = round(df['MC_USD_Billion'] * temp['Rate'][0],2)
    df['MC_GBP_Billion'] = round(df['MC_USD_Billion'] * temp['Rate'][1],2)
    df['MC_INR_Billion'] = round(df['MC_USD_Billion'] * temp['Rate'][2],2)

    return df
# Task 4
def load_to_csv(df, output_path):
    ''' This function saves the final data frame as a CSV file in
    the provided path. Function returns nothing.'''
    pd.DataFrame.to_csv(df,output_path)

# Task 5
def load_to_db(df, sql_connection, table_name):
    ''' This function saves the final data frame to a database
    table with the provided name. Function returns nothing.'''
    df.to_sql(name = table_name, con= sql_connection, if_exists ='replace', index=False)
# Task 6
def run_query(query_statements, sql_connection):
    global switch_check
    ''' This function runs the query on the database table and
    prints the output on the terminal. Function returns nothing. '''
    cursor = sql_connection.cursor()
    for query_statement in query_statements:
        cursor.execute(query_statement)
        result_using_pandas = pd.read_sql(query_statement,sql_connection)
        result_using_database_connector = cursor.fetchall()
        # Depend on how did you implement system, choose for your convenient
        if switch_check==0:
            print(result_using_database_connector)
        else :
            print(result_using_pandas)
            switch_check=0
    
''' Here, you define the required entities and call the relevant
functions in the correct order to complete the project. Note that this
portion is not inside any function.'''
def quiz(df):
    '''Answering quiz in project'''
    print(f'The market capitalization of the 5th largest bank in billion EUR: ')
    print(df['MC_EUR_Billion'][4])
    switch_check=1
    print(f'All the relevant query: \n')
    run_query(query_statements,database)

# requirement()
log_progress(log_message[0])
df = extract(url, table_attribs)
log_progress(log_message[1])
df = transform(df, exchange_rate)
log_progress(log_message[2])
load_to_csv(df,output)
log_progress(log_message[3])
sql_connection = sqlite3.connect(database)
log_progress(log_message[4])
load_to_db(df,sql_connection,table_name)
log_progress(log_message[5])
run_query(query_statements,sql_connection)
log_progress(log_message[6])
sql_connection.close()
log_progress(log_message[7])