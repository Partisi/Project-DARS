# Project DARS

**Erol Bickici** - emb689 - *NYU undergraduate student studying Finance & Computer Science*

Hello! My name is Erol Bickici and this is my project for my NYU Data Analytics Class! This repo contains the main analytic driver code as well as some screenshotted results.

*Also, **DARS** literally just stands for Data Analytics on Remote Software, if you were curious*

## Introduction
With the ongoing pandemic, many companies have shifted their focus and thinking into really trying to understand how work actually gets done. The traditional model of coming into the office to work has been coming under scrutiny as many employees (and employers alike) were advocating for work at home. The software industry was one of the most prominent advocates as their work was primarly done through a computer and really did not need to be physically present at a costly office to get work done.

Using Hadoops HDFS, MapReduce, and Hive, I was driven to attempt to uncover the real truth and the benefit for remote work. The focus of my research was ***What are the effects of software companies moving to remote from both a developer and managerial perspective?***

## Breakdown of Architecture & Workflow
Let us start with foundation: the data. In all, I actually have 7 different datasets where 5 of them correspond to 5 NYC boroughs, 1 is related to industry trends for working remotely, and the last one is for a survey of remote workers (yes, I am one person but idc).

For the 5 NYC boroughs, I aimed to get a grasp of the real estate costs in NYC specifically to make an argument that managers should be more inclined for remote work to save on company costs. With these datasets, I cleaned the data by dropping most columns that were unrelated to any sort of result I was looking for, such as information about taxes and regulations while filtering out only office types. After I individually cleaned each one of the 5 boroughs, I then combined them all into a single dataset to represent NYC as a whole. After, I moved the information to a Hive table so I could run some general analytics where you may see the results in `screenshots/workingWithDatasetNYCSales`.

For the industry trends of working remotely, this step was relatively easy where I just eliminated the rows (corresponding to other industries) that I just did not care for. My research focus was on the software industry specifically, so I obviously kept that as well as the industry average, however, I did later actually go back and included a few other industries to maybe compare later on in my essay. For this dataset, I did not run any profiling because I want to use this more for visualizations rather than just doing some analytics on it for the 'sake of looking swag'. The dataset was mostly fine (besides some wild issue where there were random commas throughout the csv that took some fun time to resolve).

For the remote work survey dataset, I aimed to gauge overall productivity and emotion for workers while working remotely. This survey had, to put it bluntly, an absolutely wild amount of data. Not only were there over 100 columns, but a lot of the data was None or parsed poorly, making analytics rather difficult. I used some MapReduce jobs to extract only what I needed and then stored the result in HDFS and, similar to the NYC datasets, moved this data to Hive to run some analytics, particularly to get the averages of producitivity, boredom, loneliness, etc. You may see the results in `screenshots/workingWithDatasetSurvey`

For the file structure, I wanted to make it as clean and simple as possible. `etl_code` just houses me running MapReduce jobs on each dataset to clean it up and make the data ready to producing real analytics. `profiling_code` is exactly what it means, with a `txt` file that houses the code for the profiling on the datasets to be done. Note that I just ran some CL commands to do the analytics as it was - in short - quite easy, flexible, and time-saving. The results, along with the jobs running, are stored in `screenshots` where they are all accurately labeled in chronological order.

When it came to the data file structures, I made a folder called `data_ingest` that just simply transferred the data over to PEEL and HDFS where the `originalDatasets` folder, that has all the original datasets obviously, is moved to the HDFS with a very similar structure. The only addition to the HDFS file structure is that I appended the results of the MapReduce job there as well.

## Steps To Run Analytics

#### Setup
1. Connect to AnyConnect to access PEEL
2. cd into `ana_code`
3. Run `bash data_ingest/loadDataPEEL.sh` to load the data into PEEL
4. While in PEEL, execute `bash ana_code/data_ingest/loadDataHDFS.sh` to load datasets from PEEL into HDFS

*The following sections can be done in any order, depending on the overall analytics you want to run, but must do setup first*

#### Running NYC Real Estate Dataset
1. Run `cd` in PEEL
3. Run `bash etl_code/cleanNYCDatasets/cleanDriver.sh`
4. Ensure that the in `ana_code/etl_results/cleanNYCResults/` within HDFS, there exists each borough's clean dataset (with dropped columns and reformatted borough names), as well as a master that concatenates all the boroughs into a single NYC dataset.
5. Proceed to Hive (beeline)
6. Here, you may follow the steps outlined in `profiling_code/profileNYCDatasets/profileDriver.txt` to run the profiling code

#### Running Industry Dataset
1. Run `cd` in PEEL
3. Run `bash etl_code/cleanIndustryDataset/cleanDriver.sh`
4. Ensure that the in `ana_code/etl_results/cleanIndustryResults` within HDFS, there exists the `fullIndustry.csv` file. Note that this houses only the relevant industry rows such as the Software Industry, a few others to compare, and one for All Industries average
5. Now, you can check out `profiling_code/profileIndustryDataset/profileDriver.txt`. But in short, TL;DR I did not run any profiling on this dataset as it is already exactly what I need with just some row drops, but I do plan on doing more heavy visualization with this though.

#### Running Remote Work Survey Dataset
1. Run `cd` in PEEL
3. Run `bash etl_code/cleanSurveyDataset/cleanDriver.sh`
4. Ensure that results are kept in `ana_code/etl_results/cleanSurveyResults`
5. Proceed to Hive (beeline)
6. Here, you may follow the steps outlined in `profiling_code/profileSurveyDataset/profileDriver.txt` to run the profiling code

## Datasets
* [NYC Datasets (All 5)](https://www1.nyc.gov/site/finance/taxes/property-rolling-sales-data.page)
* [Industry Trends Remote Dataset](https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/onlineremoteworkingjobvacanciesestimates)
* [Survey Dataset](https://zenodo.org/record/4271923)