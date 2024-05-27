import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
df = pd.read_csv("track_data_for_visualize.csv")
df.plot(kind = 'bar')
print("yeah")