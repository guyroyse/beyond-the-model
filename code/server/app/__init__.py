from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin

from .classinator import BigfootClassinatorModel

APP_NAME = "Bigfoot Classinator"
APP_VERSION = "0.0.1"

def create_app(test_config=None):
  app = Flask(__name__, instance_relative_config=True)

  @app.route('/version')
  @cross_origin()
  def version():
    return jsonify({
      'app'     : APP_NAME,
      'version' : APP_VERSION
    })

  @app.route('/classinate', methods=['POST'])
  @cross_origin()
  def classinate():
    sighting = request.get_json()['sighting']

    model = BigfootClassinatorModel()
    classination = model.predict(sighting)

    return jsonify({
      'app'          : APP_NAME,
      'version'      : APP_VERSION,
      'classination' : classination.to_dict(),
      'sighting'     : sighting
    })

  return app
