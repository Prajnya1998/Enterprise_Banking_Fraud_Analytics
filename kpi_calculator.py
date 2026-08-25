"""
Enterprise Banking Fraud Analytics
------------------------------------
Module: kpi_calculator.py

Purpose:
Calculate business KPIs from the fraud dataset.
"""



def calculate_kpis(df):
    """
    Calculate Key fraud metrics.

    Parameters:
        df (DataFrame)

    Returns:
        dict
    """

    # ======================================
    # BASIC TRANSACTION KPIs
    # =======================================

    total_transactions = len(df)

    fraud_transactions = len(
        df[df["is_fraud"] == 1]
    )

    genuine_transactions = len(
        df[df["is_fraud"] == 0]
    )

    # =======================================
    # FRAUD RATE
    # =======================================

    fraud_rate = (
        fraud_transactions /
        total_transactions
    ) * 100

    # =======================================
    # TRANSACTION AMOUNT KPIs
    # =======================================

    average_amount = df["amt"].mean()

    maximum_amount = df["amt"].max()


    # =====================================
    # FRAUD AMOUNT
    # =====================================

    fraud_amount = df.loc[
        df["is_fraud"] == 1,
        "amt"
    ].sum()


    # ==================================================
    # RETURN EXECUTIVE KPIs
    # ==================================================

    return {

        "Total Transactions" : total_transactions,

        "Fraud Transactions" : fraud_transactions,

        "Genuine Transactions" : genuine_transactions,

        "Fraud Rate" : fraud_rate,

        "Average Amount" : average_amount,

        "Maximum Amount": maximum_amount,

        "Total Fraud Amount": fraud_amount
    }