TreeFall NYC: A tool for equitable street tree management

PROBLEM STATEMENT
NYC Parks is tasked with managing over 600,000 street trees, but has the resources to inspect and maintain less than 50,000 trees per year. Currently, NYC relies on highly-biased citizen-submitted tree service requests to prioritize trees for maintenance, which results in over 10,000 tree branch falls per year and substantial cost to the City.

SOLUTION
I created a preventative tree maintenance prioritization tool for NYC Parks that uses an un-biased data driven approach. Prioritization is based on a tree's predicted branch fall probability. Two random forest classifiers were trained to predict branch fall probability with or without tree service request information. A final tree branch fall probability was determined by combining the models results with weights proportional to the service requests per branch fall in the area.

WEBSITE
The tool is hosted at: WillaTreeFallonMe.xyz

FILES:
All Jupyter Notebook files for the models are in the ProjectFiles Directory, but many of the data files are too large to upload.  

* The directory structure for data files is:
  ProjectFiles
    Data
      311
      FinalOutputs
      ModelData
      spatialdatasets
      Trees
      
To use, set up the folders and follow these steps:

1) Download the 311 Service request data from NYC Open Data: https://nycopendata.socrata.com/Social-Services/311-Service-Requests-from-
2010-to-Present/erm2-nwe9 

2) Follow the steps in ShellCommands.txt to organize the 311 data into falls and warnings files and store in Data/311

3) Download the 2015 NYC Street Tree Census as a shapefile: https://data.cityofnewyork.us/Environment/2015-Street-Tree-Census-Tree-Data/pi5s-9p35 and store in Data/Trees

4) Run DataJoin.ipynb

5) Run CleanData.ipynb

6) place the two zipped files (data_with_imp_bldghght.zip and Fall_Count.zip) in Data/spatialdatasets and unzip them, remove "_for_github" from the name of data_with_imp_bldghght.  These files were created with NYC and USGS open datasets in QGIS.

7) run TreeModelNoWarn.ipynb

8) TreeModelNoWarn.ipynb

9) run the flask app to display the app
