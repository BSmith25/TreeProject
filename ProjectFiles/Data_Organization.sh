#!/bin/bash
# This script downloads and organizes all the data files needed for TreeFall NYC
# Note that wget and unzip are needed

# First create the data directories:
mkdir Data;
	mkdir Data/311;
	mkdir Data/FinalOutputs;
	mkdir Data/ModelData;
	mkdir Data/spatialdatasets;
	mkdir Data/Trees;

# Now move on to the 311 data,
# downlaod all NYC 311 service requests from NYC Open Data into the proper folder
wget https://nycopendata.socrata.com/api/views/erm2-nwe9/rows.csv?accessType=DOWNLOAD -O Data/311/311_Service_Requests_from_2010_to_Present.csv

	# Get all fallen trees/branches service requests and drop un-needed columns
	# Note we will need to grep a bunch of columns based on a keyword (Fallen) and then use other keywords (mostly agency names) to remove un-wanted data
	grep Unique Data/311/311_Service_Requests_from_2010_to_Present.csv > temp
	grep Fallen Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	sed -i '/DSNY/d' temp
	sed -i '/DCA/d' temp
	sed -i '/DEP/d' temp
	sed -i '/DOT/d' temp
	sed -i '/DOITT/d' temp
	sed -i '/DOB/d' temp
	sed -i '/ACS/d' temp
	cut -d"," -f 1-4,6-15,20,26-28,39-40 temp > Data/311/Tree_Fall_311.csv

	# Get all damaged trees/branches service requests and drop un-needed columns
	# Note we will need to grep a bunch of columns based on several keywords and then use other keywords (mostly agency names) to remove un-wanted data
	grep Unique Data/311/311_Service_Requests_from_2010_to_Present.csv > temp
	grep Dead Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	grep Damaged Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	grep Leaning/Uprooted Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	grep Cracked Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	grep Poor Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	grep Split Data/311/311_Service_Requests_from_2010_to_Present.csv >> temp
	sed -i '/DSNY/d' temp
	sed -i '/DCA/d' temp
	sed -i '/DEP/d' temp
	sed -i '/DOT/d' temp
	sed -i '/DOITT/d' temp
	sed -i '/DOB/d' temp
	sed -i '/ACS/d' temp
	sed -i '/Animal/d' temp
	cut -d"," -f 1-4,6-15,20,26-28,39-40 temp > Data/311/Tree_Service_Requests_311.csv

	# Get all overhanging trees/branches service requests and drop un-needed columns
	grep Data/311/Unique 311_Service_Requests_from_2010_to_Present.csv > temp
	grep Data/311/Overgrown 311_Service_Requests_from_2010_to_Present.csv >> temp
	sed -i '/DSNY/d' temp
	sed -i '/DCA/d' temp
	sed -i '/DEP/d' temp
	sed -i '/DOT/d' temp
	sed -i '/DOITT/d' temp
	sed -i '/DOB/d' temp
	sed -i '/ACS/d' temp
	sed -i '/Animal/d' temp
	cut -d"," -f 1-4,6-15,20,26-28,39-40 temp >> Data/311/Tree_Service_Requests_311.csv
	
	# delete the temp file
	rm temp

# Next, work on the tree census data
	# Downlaod the data from NYC Open Data and put it in the Data/Trees folder
	wget https://data.cityofnewyork.us/api/geospatial/pi5s-9p35?method=export&format=Shapefile && unzip '2015 Street Tree Census - Tree Data' -d Data/Trees/ &&	rm '2015 Street Tree Census - Tree Data'
	
# Finally, download the spatial datasets from github to Data/spatialdatasets and unzip them or rename them as needed
# Note these datasets were generated from open data and merged in QGIS
	# First the building height and impervious % dataset
	wget https://github.com/BSmith25/TreeProject/raw/master/ProjectFiles/data_with_imp_bldghght.zip  && unzip data_with_imp_bldghght.zip -d Data/spatialdatasets/ &&	rm data_with_imp_bldghght.zip
	mv  Data/spatialdatasets/data_with_imp_bldghght_for_github.csv Data/spatialdatasets/data_with_imp_bldghght.csv

	# Next the service requests per fall in all the zipcodes
	wget https://github.com/BSmith25/TreeProject/raw/master/ProjectFiles/Fall_Count.zip && unzip Fall_Count.zip -d Data/spatialdatasets/ &&	rm Fall_Count.zip

	
