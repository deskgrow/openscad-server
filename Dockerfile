FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openscad \
        libgl1 \
        libglu1-mesa && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /srv
COPY . .
RUN pip install -r requirements.txt
CMD ["gunicorn","-b","0.0.0.0:10000","server:app"]