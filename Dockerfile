FROM python:3.8.2-slim

COPY entrypoint.sh /

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install --quiet \
      'mlflow==1.8.0' \
      'azure-storage==0.36.0' \
      'msrestazure~=0.6.3' \
      'azure-cli==2.3.1' \
      'psycopg2-binary==2.8.4'

# REQUIRED FOR AZURE:
# ENV AZURE_STORAGE_ACCESS_KEY DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=XXXXX;AccountKey=XXXXX
# ENV MLFLOW_SERVER_FILE_STORE /mnt/azfiles/mlruns
# ENV MLFLOW_SERVER_DEFAULT_ARTIFACT_ROOT wasbs://mlflow@XXXXX.blob.core.windows.net/mlartifacts

ENV MLFLOW_SERVER_HOST 0.0.0.0
ENV MLFLOW_SERVER_PORT 5000
ENV MLFLOW_SERVER_WORKERS 4

CMD ["/entrypoint.sh"]
