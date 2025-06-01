FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openscad \
        libgl1 \
        libglu1-mesa && \
	python3-pip            #
	&& \
    rm -rf /var/lib/apt/lists/*

WORKDIR /srv
COPY . .
RUN python3 -m pip install --no-cache-dir -r requirements.txt   #
CMD ["gunicorn","-b","0.0.0.0:10000","server:app"]