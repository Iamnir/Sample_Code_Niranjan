# -*- coding: utf-8 -*-
"""Twitter API Data.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1XOqEQ5ViF0_S633r20qkhwxktwxRHh5G
"""

!pip install tweepy --upgrade

"""### Import Python libraries """

import tweepy as tw    #python wrapper around twitter API 
import pandas as pd    #import pandas for data framework 
import re              #REgEX for search pattern or pattern matching 
import  os             #to handle files 
from google.colab import drive  # to mount Drive to Colab notebook
import json                     #To load and save json files 
import csv                      #To save and load CSV files 
from datetime import date       #In case we have a date format data 
from datetime import datetime , timedelta, timezone   #import datetime in case we have date format data 
import time                     #to handle and execute the time limitattion

"""###Connect with Drive """

# Connect Google Drive to Colab
drive.mount('/content/gdrive')
# Create a local variable to store the data path on your drive  
path = "/content/gdrive/MyDrive/CP_Project/"

"""###API Authentication and credentials """

#Save twitter credentials to local variables 
access_token= "2438700090-uCNsK5ShdtQrqi9T8P7eL87YIzwz6uzg6FrD0IU"
access_token_secret= "uiWjsCBt4aKqR91lb9w8EGtBOJidId2OwCXhiUBZ0k2Nt"
consumer_key = "oeDWkmqW2iV2l767GXr0lnYGW"
consumer_secret= "0F4RWN4f8aFGug7jjsT4yOniobFQUaaetPH1Bm88ImXwGXS7AX"

#check if the authentication credentials are true or not 
#We use OAuth (Open Source Authorization Protocol) to check the Twitter API class 
auth = tw.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

# Create API object
api = tw.API(auth, wait_on_rate_limit=True,retry_count=10, retry_delay=5, retry_errors=set([503]))

#If the authentication was successful, this should print "Authentication Ok"
#API method verify_credentials() is being used to do the same.

try:
    api.verify_credentials()
    print("Authentication OK")
except:
    print("Error during authentication")

"""Helper function for JSON files """

# Helper function to save data into a JSON file
# file_name: the file name of the data on Google Drive
# file_content: the data you want to save
def save_json(file_name, file_content):
    with open(path + file_name, 'w', encoding='utf-8') as f:
         json.dump(file_content, f, ensure_ascii=False, indent=4)

"""To handle the time limit """

#To handle the limit rate of twitter API 
def limit_handled(cursor, list_name):
  while True:
    try:
      yield cursor.next()
    # Catch Twitter API rate limit exception and wait for 15 minutes
    except tw.RateLimitError:
      print("\nData points in list = {}".format(len(list_name)))
      print('Hit Twitter API rate limit.')
      for i in range(3, 0, -1):
        print("Wait for {} mins.".format(i * 5))
        time.sleep(5 * 60)
    # Catch any other Twitter API exceptions
    except tw.error.TweepError:
      print('\nCaught TweepError exception')

import pytz 

def get_all_tweet(user_name):
    startDate = datetime(2020, 3, 1, 0, 0, 0).replace(tzinfo=pytz.UTC)
    endDate =   datetime(2022, 5, 1, 0, 0, 0).replace(tzinfo=pytz.UTC)

    tweets = []
    tmpTweets = api.user_timeline(screen_name =user_name,count=200,include_rts = True,tweet_mode = 'extended')
    for tweet in tmpTweets:
           if tweet.created_at < endDate and tweet.created_at > startDate:
              tweets.append(tweet)

    while(tmpTweets[-1].created_at > startDate):
          oldest = tmpTweets[-1].id
          tmpTweets = api.user_timeline(screen_name = user_name, count=200,include_rts = True,tweet_mode = 'extended', max_id= oldest-1)
          if len(tmpTweets) == 0 :
             break 
          else: 
             for tweet in tmpTweets:
                 if tweet.created_at < endDate and tweet.created_at > startDate:
                   tweets.append(tweet) 
    outtweets = []
    outtweets = [[tweet.id_str, tweet.user.name, tweet.created_at, tweet.full_text, tweet.favorite_count, tweet.in_reply_to_screen_name, tweet.retweeted] for tweet in tweets]

    with open(path + '%s_tweets.csv' % user_name , 'w') as f:
         writer = csv.writer(f)
         writer.writerow(["id","user_name", "created_at","full_text","Total_likes","in reply to", "retweeted"])
         writer.writerows(outtweets)
    pass

get_all_tweet("@GraceOnFootball")

"""###Extract all Twitter data using User's ID """

def get_all_tweets(user_name):
  # initialize a list to hold all the Tweets
  alltweets = []
  # make initial request for most recent tweets 
  # (200 is the maximum allowed count)
  new_tweets = api.user_timeline(screen_name = user_name,include_rts = True, tweet_mode = 'extended', count=200)
  # save most recent tweets
  alltweets.extend(new_tweets)
  # save the id of the oldest tweet less one to avoid duplication
  oldest = alltweets[-1].id - 1
  # keep grabbing tweets until there are no tweets left
  while len(new_tweets) > 0:
    print("getting tweets before %s" % (oldest))
    # all subsequent requests use the max_id param to prevent
    # duplicates
    new_tweets = api.user_timeline(screen_name = user_name,include_rts = True, tweet_mode = 'extended',count=200,max_id=oldest)
    # save most recent tweets
    alltweets.extend(new_tweets)
    # update the id of the oldest tweet less one
    oldest = alltweets[-1].id - 1
    print("...%s tweets downloaded so far" % (len(alltweets)))
    ### END OF WHILE LOOP ###
  # transform the tweepy tweets into a 2D array that will 
  # populate the csv
  outtweets = [[tweet.id_str, tweet.user.name, tweet.created_at, tweet.full_text.encode("utf-8").decode("utf-8"), tweet.favorite_count, tweet.in_reply_to_screen_name, tweet.retweeted] for tweet in alltweets]
  # write the csv
  with open(path + '_tweets.csv', 'w') as f:
    writer = csv.writer(f)
    writer.writerow(["id","user_name", "created_at","full_text","Total_likes","in reply to", "retweeted"])
    writer.writerows(outtweets)
  pass

"""Get the Twitter IDs from the Google Spreadsheet """

id_path = "/content/gdrive/MyDrive/CP_Project/Twitter_IDs.csv"
df = pd.read_csv (id_path)
df = df.set_axis(["Journalists", "Politicians","Comedians","Writers","Sportspersons","Actors","Business","Academics","Newspapers"], axis=1)
df.head()

ser_aggCol=df.aggregate(lambda x: [x.tolist()], axis=0)
ser_aggCol
types = list(df.columns)
types

for i in range(0,9):
   lists = list(ser_aggCol.iat[0,i])
   name = types[i]
   path = f"/content/gdrive/MyDrive/CP_Project/{name}/"
   for j in range(0,int(len(lists))):
     user = lists[j]
     if pd.isnull(lists[j]):
       continue
     else:
       get_all_tweet(lists[j])
       print(f"Data for {name}:{user} collected")
   print(f"Data for all {name} collected")

types = list(df.columns)
finaldata = pd.DataFrame()

for i in range(0,9):
    name = types[i]
    path = f"/content/gdrive/MyDrive/CP_Project/{name}/"
    arr = os.listdir(path)

    for j in range(0,int(len(arr))):
      filename = arr[j]
      user_id = filename.replace("_tweets.csv","")
      filepath = f"{path}{filename}"
      data = pd.read_csv (filepath)
      data['user_id'] = user_id
      data['account_type'] = name
      finaldata = finaldata.append(data)

finaldata.shape
finaldata.to_csv("/content/gdrive/MyDrive/CP_Project/final_tweets.csv")

from google.colab import auth
auth.authenticate_user()

import gspread
from google.auth import default
creds, _ = default()

gc = gspread.authorize(creds)

worksheet = gc.open('Twitter_IDs').sheet1

# Convert to a DataFrame and render.
import pandas as pd
data = pd.DataFrame.from_records(rows)
data.head()