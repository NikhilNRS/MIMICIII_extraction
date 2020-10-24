"""
Contains various imports and settings used across multiple notebooks.
Avoids copying over this preamble in each notebook.

Take care to specify yourself:
*  data_base_path: base location to read/write all
    derived datasets from/to. Set this to the "data" directory to re-use
    the data that I produced by running the notebooks.
* figs_base_path: base location to write all created figures to.
"""
#Python standard library
import time
import os
import pickle

#Additional third-party modules
import psycopg2
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import tensorflow as tf

#Several display options
pd.set_option('display.max_rows', 100)
pd.set_option('display.max_columns', 200)
pd.set_option('display.max_colwidth', 250)

#Other variables regarding filepaths - CHANGE TO YOUR PATHS
data_base_path = r"D:\Documents\GitHub\ImplementationMaterials\Implementation\data"