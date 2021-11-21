echo "Cleaning Industry Dataset..."
cd
cd ana_code/etl_code/cleanNYCDatasets

javac -classpath "$(yarn classpath)" -d . CleanNYCSalesMapper.java
javac -classpath "$(yarn classpath)" -d . CleanNYCSalesReducer.java
javac -classpath "$(yarn classpath)" -d . CleanNYCSalesMapper.java CleanNYCSalesReducer.java CleanNYCSales.java
jar cf CleanNYCSales.jar *.class

cd
cd ana_code/etl_code/cleanNYCDatasets
hdfs dfs -rm -r ana_code/etl_results/cleanNYCResults
hdfs dfs -mkdir ana_code/etl_results/cleanNYCResults

hadoop jar CleanNYCSales.jar CleanNYCSales ana_code/originalDatasets/nyc-sales/rollingsales_manhattan.csv ana_code/etl_results/cleanNYCResults/output_manhattan

hadoop jar CleanNYCSales.jar CleanNYCSales ana_code/originalDatasets/nyc-sales/rollingsales_bronx.csv ana_code/etl_results/cleanNYCResults/output_bronx

hadoop jar CleanNYCSales.jar CleanNYCSales ana_code/originalDatasets/nyc-sales/rollingsales_brooklyn.csv ana_code/etl_results/cleanNYCResults/output_brooklyn

hadoop jar CleanNYCSales.jar CleanNYCSales ana_code/originalDatasets/nyc-sales/rollingsales_queens.csv ana_code/etl_results/cleanNYCResults/output_queens

hadoop jar CleanNYCSales.jar CleanNYCSales ana_code/originalDatasets/nyc-sales/rollingsales_statenisland.csv ana_code/etl_results/cleanNYCResults/output_statenisland

echo "NYC Sales Datasets All Cleaned!"

echo "--------------------"
echo "Manahattan Results: "
hdfs dfs -cat ana_code/etl_results/cleanNYCResults/output_manhattan/part-r-00000

echo "--------------------"
echo "Bronx Results: "
hdfs dfs -cat ana_code/etl_results/cleanNYCResults/output_bronx/part-r-00000

echo "--------------------"
echo "Brooklyn Results: "
hdfs dfs -cat ana_code/etl_results/cleanNYCResults/output_brooklyn/part-r-00000

echo "--------------------"
echo "Queens Results: "
hdfs dfs -cat ana_code/etl_results/cleanNYCResults/output_queens/part-r-00000

echo "--------------------"
echo "Staten Island Results: "
hdfs dfs -cat ana_code/etl_results/cleanNYCResults/output_statenisland/part-r-00000

echo "===================="

hdfs dfs -cat ana_code/etl_results/cleanNYCResults/output_manhattan/part-r-00000 ana_code/etl_results/cleanNYCResults/output_brooklyn/part-r-00000 ana_code/etl_results/cleanNYCResults/output_queens/part-r-00000 ana_code/etl_results/cleanNYCResults/output_bronx/part-r-00000 ana_code/etl_results/cleanNYCResults/output_statenisland/part-r-00000 >> fullNYCSales.csv
hdfs dfs -put fullNYCSales.csv ana_code/etl_results/cleanNYCResults
rm fullNYCSales.csv

echo "Full Concat. Results: "
hdfs dfs -cat ana_code/etl_results/cleanNYCResults/fullNYCSales.csv
echo "===================="

echo "Script finished!"

cd