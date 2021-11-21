echo "Cleaning Industry Dataset..."
cd
cd ana_code/etl_code/CleanIndustryDataset

javac -classpath "$(yarn classpath)" -d . CleanIndustryMapper.java
javac -classpath "$(yarn classpath)" -d . CleanIndustryReducer.java
javac -classpath "$(yarn classpath)" -d . CleanIndustryMapper.java CleanIndustryReducer.java CleanIndustry.java
jar cf CleanIndustry.jar *.class

cd
cd ana_code/etl_code/CleanIndustryDataset
hdfs dfs -rm -r ana_code/etl_results/cleanIndustryResults
hdfs dfs -mkdir ana_code/etl_results/cleanIndustryResults

hadoop jar CleanIndustry.jar CleanNYCSales ana_code/originalDatasets/remoteworkingdataset1.csv ana_code/etl_results/cleanIndustryResults

echo "Script finished!"

cd