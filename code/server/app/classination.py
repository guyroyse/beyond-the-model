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
