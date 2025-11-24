FROM python:3.12-slim

RUN apt-get update && apt-get install -y bc

WORKDIR /app

COPY . .
RUN pip install --no-cache-dir -r requirements.txt && \
    chmod u+x ./entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
