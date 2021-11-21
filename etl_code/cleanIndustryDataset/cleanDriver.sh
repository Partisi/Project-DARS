echo "Cleaning Industry Dataset..."
cd
cd ana_code/etl_code/cleanIndustryDataset

javac -classpath "$(yarn classpath)" -d . CleanIndustryMapper.java
javac -classpath "$(yarn classpath)" -d . CleanIndustryReducer.java
javac -classpath "$(yarn classpath)" -d . CleanIndustryMapper.java CleanIndustryReducer.java CleanIndustry.java
jar cf CleanIndustry.jar *.class

hdfs dfs -rm -r ana_code/etl_results/cleanIndustryResults

hadoop jar CleanIndustry.jar CleanIndustry ana_code/originalDatasets/remoteworkingdataset1.csv ana_code/etl_results/cleanIndustryResults

hdfs dfs -cat ana_code/etl_results/cleanIndustryResults/part-r-00000

hdfs dfs -cat ana_code/etl_results/cleanIndustryResults/part-r-00000 >> fullIndustry.csv

hdfs dfs -put fullIndustry.csv ana_code/etl_results/cleanIndustryResults

echo "Script finished!"

cd