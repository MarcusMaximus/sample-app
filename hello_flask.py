#!/usr/bin/env python3

from flask import Flask, render_template      

app = Flask(__name__)

@app.route('/')
def home():
    return render_template("home.html")
    
@app.route('/about')
def about():
    return render_template("about.html")

@app.route('/hello')
def hello():
    return 'Hello, World'

@app.route('/health')
def health():
    return render_template("health.html")

@app.route('/version')
def version():
    return render_template("version.html")