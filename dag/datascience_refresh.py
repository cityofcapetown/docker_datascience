from airflow import DAG
from airflow.operators.python_operator import PythonOperator
import docker

from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2019, 1, 29, 00),
    'email': ['gordon.inggs@capetown.gov.za'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
}

dag_interval = timedelta(days=1)
dag = DAG('datascience-images-refresh', catchup=False, default_args=default_args, schedule_interval=dag_interval)

docker_client = docker.from_env()

CITY_DATASCIENCE_REPO = "cityofcapetown/datascience"


def pull_images(image_tag):
    pulled_image = docker_client.images.pull(
        repository=CITY_DATASCIENCE_REPO,
        tag=image_tag
    )
    pulled_image_label = "".join(pulled_image.tags)
    output_string = "Pulled the following image: {}".format(pulled_image_label)

    return output_string


IMAGE_TAGS = ("base", "python", "jupyter", "R", "R_nonstandard", "rstudio_shiny")
operators = [
    PythonOperator(
        task_id='pull-images-{}'.format(image_tag),
        python_callable=pull_images,
        dag=dag,
        op_args=[image_tag]
    ) for image_tag in IMAGE_TAGS]
