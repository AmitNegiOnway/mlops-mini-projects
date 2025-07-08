# updated app.py

from flask import Flask, render_template,request
import mlflow
import pickle
import os
import pandas as pd

import numpy as np
import pandas as pd
import os
import re
import nltk
import string
import dagshub
import os
from preprocessing_utility import normalize_text

app= Flask(__name__)

dagshub.init(repo_owner='amitnegionway', repo_name='mlops-mini-projects', mlflow=True)
mlflow.set_tracking_uri('https://dagshub.com/amitnegionway/mlops-mini-projects.mlflow')

model_name = "my_model"
model_version = 2

model_uri = f'models:/{model_name}/{model_version}'
model = mlflow.pyfunc.load_model(model_uri)

vectorizer = pickle.load(open('models/vectorizer.pkl','rb'))

@app.route('/')
def home():
    return render_template('index.html',result=None)

@app.route('/predict', methods=['POST'])
def predict():

    text = request.form['text']

    # clean
    text = normalize_text(text)

    # bow
    features = vectorizer.transform([text])


    # prediction
    result = model.predict(features)

    # show
    return render_template('index.html', result=result[0])


app.run