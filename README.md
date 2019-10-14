## TreeFall NYC: A tool for equitable street tree management

### PROBLEM STATEMENT
NYC Parks is tasked with managing over 600,000 street trees, but has the resources to inspect and maintain less than 50,000 trees per year. Currently, NYC relies on highly-biased citizen-submitted tree service requests to prioritize trees for maintenance, which results in over 10,000 tree branch falls per year and substantial cost to the City.

### SOLUTION
I created a preventative tree maintenance prioritization tool for NYC Parks that uses an un-biased data driven approach. Prioritization is based on a tree's predicted branch fall probability. Two random forest classifiers were trained to predict branch fall probability with or without tree service request information. A final tree branch fall probability was determined by combining the models results with weights proportional to the service requests per branch fall in the area.

### WEBSITE
The tool is hosted at: WillaTreeFallonMe.xyz

### FILES:
All Jupyter Notebook files for the models are in the ProjectFiles Directory, but many of the data files are too large to upload.  

* The directory structure for data files is:
  
  ProjectFiles/
  
    Data/
   
      311
      
      FinalOutputs
      
      ModelData
      
      spatialdatasets
      
      Trees
      
### To Run
set up the folders and follow these steps:

1) In a unix environment (I use Cygwin for Windows) run "sh Organize_Data.sh" to create the data file structure, download all data, and unzip/rename files as necessary

2) Run DataJoin.ipynb to join branch fall service requests with tree census data

3) Run CleanData.ipynb to join damage and overhanging trees service requests with tree census data  then clean the data up for modeling

4) Run TreeModelNoWarn.ipynb to create a random forest model to predict the probability of a tree branch fall without using damage and overhanging tree service requst data then predict tree branch falls and store output

8) Run TreeModelNoWarn.ipynb to create a random forest model to predict the probability of a tree branch fall using damage and overhanging tree service requests in the features.  Then combine the two model outputs weighted by the service requests per fall in the zipcode.  Output the results to a csv and to a SQL database for the app to connect to.
   ** Note you will need to provide PostgreSQL login info

9) Run the flask app to display the app (see directions in App/README.txt)
   ** Currently the zipcode and tree data layers in google maps are static and will not update based on model outputs
