"""
Enterprise Banking Fraud Analytics
----------------------------------
Module : validation.py

Purpose:
Validate dataset before processing.
"""

from logger import logger


def validate_dataset(df):
    """
    Validate the dataset before analysis.
    
    Parameters:
        df (DataFrame): Loaded Transaction dataset.
        
    Returns:
        bool: True if validation is successful, otherwise False.
    """

    # Required columns for fraud analysis
    required_columns = [
        "is_fraud",
        "amt",
        "category",
        "state",
        "trans_date_trans_time"
    ]

    # Check whether required columns exist
    missing_columns = []

    for column in required_columns:

        if column not in df.columns:
            missing_columns.append(column)

    # If required columns are missing
    if missing_columns:

        logger.error(
            f"Missing columns: {missing_columns}"
        )

        print("\n[ERROR]")
        print("Missing Required Columns:")

        for column in missing_columns:
            print(f"-{column}")

        return False

    # Validation successful
    logger.info("Dataset validation successful.")

    return True
