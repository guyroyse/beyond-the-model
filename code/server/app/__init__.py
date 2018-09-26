import os

from flask import Flask, jsonify

def create_app(test_config=None):
  app = Flask(__name__, instance_relative_config=True)

  @app.route('/version')
  def version():
    return jsonify(app="Bigfoot Classinator", version="0.0.1")

  return app