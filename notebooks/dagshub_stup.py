import mlflow
import dagshub

mlflow.set_tracking_uri('https://dagshub.com/amitnegionway/mlops-mini-projects.mlflow')
dagshub.init(repo_owner='amitnegionway', repo_name='mlops-mini-projects', mlflow=True)

import mlflow
with mlflow.start_run():
  mlflow.log_param('parameter name', 'value')
  mlflow.log_metric('metric name', 1)