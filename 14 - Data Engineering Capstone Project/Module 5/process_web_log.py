

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
    'process_web_log',
    default_args=default_args,
    schedule_interval=timedelta(days=1),
    description = """
    Create a DAG named process_web_log that runs daily.
    Use suitable description
    """,
)
#Task 
extract = BashOperator(
    task_id='extract_data',
    bash_command=f"cut -d ' ' -f1 ~/../project/airflow/dags/capstone/accesslog.txt > ~/../project/airflow/dags/capstone/extracted_data.txt",
    dag=dag,
)
transform= BashOperator(
    task_id='transform_data',
    bash_command="grep -v '198.46.149.143' ~/../project/airflow/dags/capstone/extracted_data.txt > ~/../project/airflow/dags/capstone/transformed_data.txt",
    dag=dag,
)
load = BashOperator(
    task_id='load_data',
    bash_command=f'tar -czf weblog.tar  ~/../project/airflow/dags/capstone/transformed_data.txt',
    dag=dag
)
# Pipeline
extract>>transform>>load
