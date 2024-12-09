# Import the libraries
from datetime import timedelta
# Import DAG libs
from airflow.models import DAG
# Operators to write a task
from airflow.operators.python import PythonOperator as op

from airflow.utils.dates import days_ago
# Parameter
input_file= '/etc/passwd'
extracted_file='extracted-data.txt'
transformed_file='transformed.txt'
output_file='data_for_analytics.csv'

def extract():
    # Using global variables
    global input_file
    print("Inside Extract")
    with open(input_file,'r') as infile, open(extracted_file,'w') as outfile:

        for line in infile:
            fields = line.split(':')
            if len(fields)>=6:
                field_1=fields[0]
                field_3=fields[2]
                field_6=fields[5]
                outfile.write(f"{field_1}:{field_3}:{field_6}\n") 
def transform():
    global extracted_file,transformed_file
    print("Inside Transform")
    with open(extracted_file,'r') as infile, open(transformed_file,'w') as outfile:
        for line in infile:
            processed_line = line.replace(":",',')
            outfile.write(f'{processed_line}\n')
def load():
    global transformed_file,output_file
    print("Inside Load")
    # Save the array to a CSV file
    with open(transformed_file,'r') as infile, open(output_file,'w') as outfile:
        for line in infile:
            outfile.write(f'{line}\n')
def check():
    global output_file
    print("Inside check")
    with open(output_file,'r') as infile:
        for line in infile:
            print(line)

# Default parameter in DAG
default_args = {
    'owner':'Minh',
    'start_date':days_ago(0),
    'email':['bruh@gmail.com'],
    'retries':1,
    'retry_delay':timedelta(minutes=5)
}

# Define the DAG operator
dag= DAG(
    'Python_DAG',
    default_args=default_args,
    description='My first DAG using Python Operator, using schedule 1 day interval',
    schedule_interval=timedelta(days=1)
)

# Define the task 
execute_extract = op(
    task_id='extract',
    python_callable=extract,
    dag=dag
)

execute_transform = op(
    task_id='transform',
    python_callable=transform,
    dag=dag
)

execute_load = op(
    task_id='load',
    python_callable=load,
    dag=dag
)

execute_check = op(
    task_id='check',
    python_callable=check,
    dag=dag
)
# Define the task pipeline (order)
execute_extract >> execute_transform >> execute_load >> execute_check
