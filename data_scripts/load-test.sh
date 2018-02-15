#!/bin/bash

INSTALL_DIR=/opt/opendatacube

# Add product metadata
datacube product add $INSTALL_DIR/docs/config_samples/dataset_types/ls5_scenes.yaml

#Create catalogue of input dataset (agdc-metadata.yaml)
python $INSTALL_DIR/utils/galsprepare.py /data/lbg/LS5_TM_NBAR*

#Index input dataset into DB (expect warnings because of pixel quality data)
datacube dataset add --auto-match /data/lbg/LS5*

#Prepare ingestion config file
cp $INSTALL_DIR/docs/config_samples/ingester/ls5_nbar_albers.yaml /tmp
cp $INSTALL_DIR/docs/config_samples/ingester/ls5_pq_albers.yaml /tmp

sed s#'/media/simonaoliver/datacube/tiles'#'/output'#g -i /tmp/ls5_nbar_albers.yaml
sed s#'/media/simonaoliver/datacube/tiles'#'/output'#g -i /tmp/ls5_pq_albers.yaml

#Ingest the data (set multiproc in relation to your CPUs)
datacube -v ingest -c /tmp/ls5_nbar_albers.yaml --executor multiproc $(nproc)
datacube -v ingest -c /tmp/ls5_pq_albers.yaml --executor multiproc $(nproc)
