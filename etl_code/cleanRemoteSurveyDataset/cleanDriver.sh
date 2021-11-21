echo "Cleaning Survey Dataset..."
cd
cd ana_code/etl_code/CleanSurveyDataset

javac -classpath "$(yarn classpath)" -d . CleanSurveyMapper.java
javac -classpath "$(yarn classpath)" -d . CleanSurveyReducer.java
javac -classpath "$(yarn classpath)" -d . CleanSurveyMapper.java CleanSurveyReducer.java CleanSurvey.java
jar cf CleanSurvey.jar *.class

hdfs dfs -rm -r ana_code/etl_results/CleanSurveyResults

hadoop jar CleanSurvey.jar CleanSurvey ana_code/originalDatasets/remoteworkingdataset1.csv ana_code/etl_results/CleanSurveyResults

hdfs dfs -cat ana_code/etl_results/CleanSurveyResults/part-r-00000

hdfs dfs -cat ana_code/etl_results/CleanSurveyResults/part-r-00000 >> fullIndustry.csv

hdfs dfs -put AnonymisedData.csv ana_code/etl_results/CleanSurveyResults

echo "Script finished!"

cd