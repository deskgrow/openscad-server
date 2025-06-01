FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y openscad python3-pip
WORKDIR /srv
COPY . .
RUN pip install -r requirements.txt
CMD ["gunicorn", "-b", "0.0.0.0:10000", "server:app"]
