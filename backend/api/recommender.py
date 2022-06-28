import pandas as pd

from copy import deepcopy
from api.models import Food
from sklearn.neighbors import NearestNeighbors

NUT_DAILY_VALUES = {
    "calories": (71.461, 477.044),
    "carbohydrates": (0.43, 82.22),
    "proteins": (0.333, 36.36),
    "fat" : (0.798, 27.59333333),
    "fiber": (0, 18.33333333),
    "cholestrol": (0, 0.761),
}

NUT_NAMES_MAP = {
    "calories" : "energy",
    "carbohydrates": "carbo",
    "cholestrol": "cholestrol",
    "fat" : "fat",
    "fiber": "fiber",
    "proteins": "protein"
}

ORDER_MAP = ["energy", "carbo", "protein",	"fat", "fiber", "cholestrol"]

class Recommender:

    def __init__(self, input_data):
        self.df = None
        self.input_data = input_data

    def get_data_from_db(self):
        food = Food.objects.all()
        return food.values()
    
    def get_converted_data(self):
        data = self.get_data_from_db()
        self.df = pd.DataFrame.from_records(data)

        return deepcopy(self.df)
    
    def normalize_df(self, df=None):
        if df is None:
            df = self.get_converted_data()
        for key, val in NUT_DAILY_VALUES.items():
            column = NUT_NAMES_MAP[key]
            df[column] -= val[0]
            df[column] /= val[1] - val[0]
        
        return df

    def input_data_helper(self):
        input_data = self.normalize_df(df=self.input_data)
        inp = []
        for key in ORDER_MAP:
            inp.append(input_data[key])
        
        return [inp]

    def recommender(self):
        nutrition_df = self.get_converted_data()
        nutrition_values_df = deepcopy(self.normalize_df())
        nutrition_values_df.drop(['id', 'nama', 'sugar', 'pic_url'], axis=1, inplace=True)
        
        knn = NearestNeighbors(n_neighbors=5,
                            algorithm='ball_tree',
                            metric="euclidean").fit(nutrition_values_df)
        
        distances, indices = knn.kneighbors(self.input_data_helper(), n_neighbors=3)
        
        recommended_products = []
        for i in indices[0]:
            temp = {}
            temp['nama'] = nutrition_df.loc[i]['nama']
            temp['pic_url'] = nutrition_df.loc[i]['pic_url']
            recommended_products.append(temp)

        return recommended_products

