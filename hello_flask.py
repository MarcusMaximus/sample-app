#!/usr/bin/env python3

from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'Index Page'

@app.route('/hello')
def hello():
    return 'Hello, World'

@app.route('/health')
def hello():
    return 'Hello, health'

@app.route('/version')
def hello():
    return 'Hello, version'