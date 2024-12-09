
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow.models import DAG
# Operators
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'Minh',
    'start_date': days_ago(0),
    'email': ['21520063@gm.uit.edu.vn'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag=DAG(
    'Extract_file',
    default_args=default_args,
    schedule_interval=timedelta(days=1),
    description = """
    Create the imports block.
    Create the DAG Arguments block. You can use the default settings
    Create the DAG definition block. The DAG should run daily.
    Create the download task. The download task must download the server access log file, which is available at the URL:
    https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt

    Create the extract task.

    The server access log file contains these fields.

    a. timestamp - TIMESTAMP
    b. latitude - float
    c. longitude - float
    d. visitorid - char(37)
    e. accessed_from_mobile - boolean
    f. browser_code - int

    The extract task must extract the fields timestamp and visitorid.

    Create the transform task. The transform task must capitalize the visitorid.

    Create the load task. The load task must compress the extracted and transformed data.

    Create the task pipeline block. The pipeline block should schedule the task in the order listed below:

    download
    extract
    transform
    load
    Submit the DAG.

    Verify if the DAG is submitted.
    """,
)
#Task 
download = BashOperator(
    task_id ='download',
    bash_command=f'wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt',
    dag=dag,
)
extract = BashOperator(
    task_id='extract',
    bash_command=f"cut -d '#' -f1,4 ~/../project/web-server-access-log.txt|tr '#' ',' > ~/../project/airflow/dags/extracted_file.csv",
    dag=dag,
)
transform= BashOperator(
    task_id='transform',
    bash_command=f'tr "[a-z]" "[A-Z]" < ~/../project/airflow/dags/extracted_file.csv > ~/../project/airflow/dags/capitalized.csv',
    dag=dag,
)
load = BashOperator(
    task_id='load',
    bash_command=f'zip log.zip capitalized.csv',
    dag=dag
)
# Pipeline
download>>extract>>transform>>load

