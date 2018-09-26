import os
import json

import datarobot as dr
import pandas as pd

API_TOKEN = os.environ['DATAROBOT_API_KEY']
PROJECT_ID = os.environ['BIGFOOT_CLASSINATOR_PROJECT_ID']
MODEL_ID = os.environ['BIGFOOT_CLASSINATOR_MODEL_ID']

MAXIMUM_WAIT = 60 * 60  # maximum number of seconds to wait for prediction job to finish

class BigfootClassinatorModel:
  def __init__(self):
    dr.Client(endpoint='https://app.datarobot.com/api/v2', token=API_TOKEN)
    self.__project = dr.Project.get(PROJECT_ID)
    self.__model = dr.Model.get(PROJECT_ID, MODEL_ID)

  def predict(self, sighting):
    dataset_id = self.__upload_prediction_data(sighting)
    prediction_job = self.__start_prediction_job(dataset_id)
    prediction = self.__fetch_prediction_results(prediction_job)

    return BigfootClassination.from_dataframe(prediction)

  def __upload_prediction_data(self, sighting):
    data = pd.DataFrame([{ 'observed': sighting }])
    dataset = self.__project.upload_dataset(data)
    return dataset.id

  def __start_prediction_job(self, dataset_id):
    return self.__model.request_predictions(dataset_id)

  def __fetch_prediction_results(self, job):
    return job.get_result_when_complete(max_wait=MAXIMUM_WAIT)


class BigfootClassination:
  @classmethod
  def from_dataframe(clazz, dataframe):
    classination = clazz()
    classination.__dataframe = dataframe
    return classination

  def to_dict(self):
    return {
      'class_a'  : self.class_a,
      'class_b'  : self.class_b,
      'class_c'  : self.class_c,
      'selected' : self.selected
    }

  @property
  def class_a(self):
    return self.__dataframe.loc[0].at['class_Class A']

  @property
  def class_b(self):
    return self.__dataframe.loc[0].at['class_Class B']

  @property
  def class_c(self):
    return self.__dataframe.loc[0].at['class_Class C']

  @property
  def selected(self):
    return self.__dataframe.loc[0].at['prediction']
