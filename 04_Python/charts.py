"""
Enterprise Banking Fraud Analytics
-----------------------------------
Module : charts.py

Purpose:
Create fraud analytics charts for the executive report.
"""

import matplotlib.pyplot as plt


def create_fraud_category_chart(fraud_analysis):
    """
    Create a bar chart showing fraud by category.

    Parameters:
        fraud_analysis (dict): Fraud analysis results.

    Returns:
        matplotlib Figure
    """

    category_data = (
        fraud_analysis["category"]
        .head(10)
        .sort_values(ascending=True)
    )

    fig, ax = plt.subplots(figsize=(10, 6))

    ax.barh(
        category_data.index,
        category_data.values
    )

    ax.set_title(
        "Top 10 Fraud Categories"
    )

    ax.set_xlabel(
        "Fraud Transactions"
    )

    ax.set_ylabel(
        "Category"
    )

    plt.tight_layout()

    return fig


def create_fraud_state_chart(fraud_analysis):
    """
    Create a bar chart showing fraud by state.

    Parameters:
        fraud_analysis (dict): Fraud analysis results.

    Returns:
        matplotlib Figure
    """

    state_data = (
        fraud_analysis["state"]
        .head(10)
        .sort_values(ascending=True)
    )

    fig, ax = plt.subplots(figsize=(10, 6))

    ax.barh(
        state_data.index,
        state_data.values
    )

    ax.set_title(
        "Top 10 Fraud States"
    )

    ax.set_xlabel(
        "Fraud Transactions"
    )

    ax.set_ylabel(
        "State"
    )

    plt.tight_layout()

    return fig


def create_fraud_hour_chart(fraud_analysis):
    """
    Create a line chart showing fraud by transaction hour.

    Parameters:
        fraud_analysis (dict): Fraud analysis results.

    Returns:
        matplotlib Figure
    """

    hour_data = (
        fraud_analysis["hour"]
        .sort_index()
    )

    fig, ax = plt.subplots(figsize=(10, 6))

    ax.plot(
        hour_data.index,
        hour_data.values,
        marker="o"
    )

    ax.set_title(
        "Fraud Transactions by Hour"
    )

    ax.set_xlabel(
        "Transaction Hour"
    )

    ax.set_ylabel(
        "Fraud Transactions"
    )

    ax.set_xticks(
        range(24)
    )

    ax.grid(True)

    plt.tight_layout()

    return fig