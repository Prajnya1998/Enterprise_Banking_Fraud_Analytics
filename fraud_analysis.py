"""
Enterprise Banking Fraud Analytics
-----------------------------------
Module : fraud_analysis.py

Purpose:
Perform detailed fraud analysis by category,
state, merchant, and transaction hour.
"""


def fraud_by_category(df):
    """
    Calculate fraud transaction count by category.

    Parameters:
        df (DataFrame): Fraud transaction dataset.

    Returns:
        Series: Fraud count by category.
    """

    result = (
        df[df["is_fraud"] == 1]
        .groupby("category")
        .size()
        .sort_values(ascending=False)
    )

    return result


def fraud_by_state(df):
    """
    Calculate fraud transaction count by state.

    Parameters:
        df (DataFrame): Fraud transaction dataset.

    Returns:
        Series: Fraud count by state.
    """

    result = (
        df[df["is_fraud"] == 1]
        .groupby("state")
        .size()
        .sort_values(ascending=False)
    )

    return result


def fraud_by_merchant(df):
    """
    Calculate fraud transaction count by merchant.

    Parameters:
        df (DataFrame): Fraud transaction dataset.

    Returns:
        Series: Fraud count by merchant.
    """

    result = (
        df[df["is_fraud"] == 1]
        .groupby("merchant")
        .size()
        .sort_values(ascending=False)
    )

    return result


def fraud_by_hour(df):
    """
    Calculate fraud transaction count by transaction hour.

    Parameters:
        df (DataFrame): Fraud transaction dataset.

    Returns:
        Series: Fraud count by hour.
    """

    df = df.copy()

    df["trans_date_trans_time"] = (
        df["trans_date_trans_time"]
        .astype("datetime64[ns]")
    )

    df["Hour"] = (
        df["trans_date_trans_time"]
        .dt.hour
    )

    result = (
        df[df["is_fraud"] == 1]
        .groupby("Hour")
        .size()
        .sort_values(ascending=False)
    )

    return result