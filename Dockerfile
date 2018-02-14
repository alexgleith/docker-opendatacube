FROM ubuntu

RUN apt update && apt install -y wget
WORKDIR /opt
RUN wget "https://github.com/opendatacube/datacube-core/archive/develop.zip" -O /tmp/odc.zip

ENV LC_ALL C.UTF-8

RUN apt install -y unzip
RUN unzip /tmp/odc.zip

RUN apt update && apt -y install python3 python3-gdal

RUN mv /opt/datacube-core-develop /opt/opendatacube
WORKDIR /opt/opendatacube

RUN apt install -y python3-setuptools

RUN apt install -y gdal-bin libgdal-dev
RUN apt install -y python3-dev python3-numpy python3-netcdf4
RUN python3 setup.py develop
