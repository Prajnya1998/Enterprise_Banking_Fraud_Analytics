"""
Enterprise Banking Fraud Analytics
-----------------------------------
Module : data_loader.py

Purpose:
Load the cleaned fraud dataset for the project.
"""

import pandas as pd
from logger import logger


def load_data(dataset_path):
    """
    Load cleaned CSV dataset.

    Parameters
    -----------
    dataset_path :str

    Returns
    --------
    pandas.DataFrame
    """
  
    try:

       logger.info("Loading dataset...")

       df = pd.read_csv(dataset_path)

       logger.info("Dataset loaded successfully.")

       return df
    
    except FileNotFoundError:

        logger.error("Dataset file not found.")

        print("\n[ERROR]")
        print("Dataset file not found.")
        print(f"Path :{dataset_path}")


        return None