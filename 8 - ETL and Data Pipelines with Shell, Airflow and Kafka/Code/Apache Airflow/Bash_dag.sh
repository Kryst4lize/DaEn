#! /bin/bash
export AIRFLOW_HOME=/home/project/airflow
echo $AIRFLOW_HOME

# Copy the new dag python operators in to airflow project
cp my_first_dag.py $AIRFLOW_HOME/dags
# Run the command below to list out all the existing DAGs
airflow dags list
# Check python dag we have created
airflow dags list|grep "Python_DAG"
# Run created dag
airflow tasks list Python_DAG