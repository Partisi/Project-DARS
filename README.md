Hello Officer!# Project-DARS


1. Make sure connected to AnyConnect
2. cd into ana_code
3. bash data_ingest/loadDataPEEL.sh
4. bash ana_code/data_ingest/loadDataHDFS.sh

NYC Real Estate
1. Update Code
2. Send code to Peel
3. Run etl_code/cleanNYCDatasets/cleanDriver.sh
4. Returns individual, clean datasets for each dataset (each borough) as well as a final concatenated one.
5. Proceed to Hive to put into table