#! /bin/bash
# echo "List all the existing DAGS"
airflow dags list
# List all tasks in the DAG named example_bash_operator
airflow tasks list example_bash_operator
# to list all tasks for the DAG named tutorial
airflow tasks list tutorial
# unpause a DAG named tutorial
airflow dags unpause tutorial
# Run the command to pause the DAG
airflow dags pause tutorial
# unpause the DAG named example_branch_operator
airflow dags unpause example_branch_operator
# List tasks for the DAG example_branch_labels
airflow tasks list example_branch_labels
# Unpause the DAG example_branch_labels
airflow dags unpause example_branch_labels
# Pause the DAG example_branch_labels
airflow dags pause example_branch_labels

