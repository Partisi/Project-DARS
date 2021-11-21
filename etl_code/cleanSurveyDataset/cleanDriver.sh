echo "Cleaning Survey Dataset..."
cd
cd ana_code/etl_code/cleanSurveyDataset

javac -classpath "$(yarn classpath)" -d . CleanSurveyMapper.java
javac -classpath "$(yarn classpath)" -d . CleanSurveyReducer.java
javac -classpath "$(yarn classpath)" -d . CleanSurveyMapper.java CleanSurveyReducer.java CleanSurvey.java
jar cf CleanSurvey.jar *.class

hdfs dfs -rm ana_code/etl_results/cleanSurveyResults/cleanSurveyData.csv
hdfs dfs -rm -r ana_code/etl_results/cleanSurveyResults

hadoop jar CleanSurvey.jar CleanSurvey ana_code/originalDatasets/AnonymisedData.csv ana_code/etl_results/cleanSurveyResults

hdfs dfs -cat ana_code/etl_results/cleanSurveyResults/part-r-00000

hdfs dfs -cat ana_code/etl_results/cleanSurveyResults/part-r-00000 >> cleanSurveyData.csv

hdfs dfs -put cleanSurveyData.csv ana_code/etl_results/cleanSurveyResults
rm cleanSurveyData.csv

echo "Script finished!"

cd