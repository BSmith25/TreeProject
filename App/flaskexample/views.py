from flask import render_template
from flaskexample import app
from sqlalchemy import create_engine
from sqlalchemy_utils import database_exists, create_database
import pandas as pd
import psycopg2
from flask import request

# Python code to connect to Postgres
# You may need to modify this based on your OS, 
# as detailed in the postgres dev setup materials.
user = 'postgres'
pwd = 's$cretpassword'

engine = create_engine('postgresql+psycopg2://%s:%s@treeproject.cihqt2qlmtdk.us-east-2.rds.amazonaws.com'%(user,pwd))
con = None
con = psycopg2.connect(password=pwd, port=5432,user=user,host='treeproject.cihqt2qlmtdk.us-east-2.rds.amazonaws.com')

@app.route('/')
@app.route('/input')
def address_input():
   return render_template("input.html")
   
@app.route('/output')
def zipcode_output():
 #pull 'zippcode' from input field and store it
 zipcode = request.args.get('zipcode',None)
   #just select the Trees  from the tree database for the zipcode that the user inputs
 query = "SELECT * FROM finaltable WHERE fallprob IS NOT NULL and zipcode='%s' ORDER BY fallprob DESC LIMIT 10" % zipcode
 print(query)
 query_results=pd.read_sql_query(query,con)
 print(query_results)
 trees = []
 for i in range(0,query_results.shape[0]):
     trees.append(dict(treeid=query_results.iloc[i]['tree_id'],address=query_results.iloc[i]['address'],species=query_results.iloc[i]['spc_common'], diameter=query_results.iloc[i]['tree_dbh'], fallprobability=query_results.iloc[i]['fallprob']))
     the_result = ''

 return render_template("output.html", trees=trees,place=zipcode)
 