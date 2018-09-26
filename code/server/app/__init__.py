from flask import Flask, request, jsonify

from .classinator import BigfootClassinatorModel

def create_app(test_config=None):
  app = Flask(__name__, instance_relative_config=True)

  @app.route('/version')
  def version():
    return jsonify({
      'app'     : "Bigfoot Classinator",
      'version' : "0.0.1"
    })

  @app.route('/classinate', methods=['POST'])
  def classinate():
    sighting = request.get_json()['sighting']

    model = BigfootClassinatorModel()
    classination = model.predict(sighting)

    return jsonify({
      'app'          : "Bigfoot Classinator",
      'version'      : "0.0.1",
      'classination' : classination.to_dict(),
      'sighting'     : sighting
    })

  return app
