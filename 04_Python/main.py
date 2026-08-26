"""
Enterprise Banking Fraud Analytics
-----------------------------------
Main Program
"""

from data_loader import load_data
from kpi_calculator import calculate_kpis
from report_generator import generate_report
from config import DATASET_PATH, OUTPUT_FILE
from logger import logger
from validation import validate_dataset
from fraud_analysis import (
    fraud_by_category,
    fraud_by_state,
    fraud_by_merchant,
    fraud_by_hour
)


def main():

    logger.info("Application started.")

    print("=" * 36)
    print("ENTERPRISE BANKING FRAUD ANALYTICS")
    print("=" * 36)

    df = load_data(DATASET_PATH)

    if df is None:
        return

    if df.empty:

        logger.warning("Dataset is empty.")

        print("\n[WARNING]")
        print("Dataset contains no records.")

        return


    # Validate dataset before processing

    if not validate_dataset(df):

        return

    

    kpis = calculate_kpis(df)

    # ==========================================================
    # FRAUD ANALYSIS
    # ==========================================================

    fraud_analysis = {

        "category": fraud_by_category(df),

        "state": fraud_by_state(df),

        "merchant": fraud_by_merchant(df),

        "hour": fraud_by_hour(df)
    }

    print()

    print("[SUCCESS] Dataset loaded successfully.")

    print(f"Total Records : {len(df):,}")

    print(f"Total Columns : {len(df.columns)}")

    
    print("\nExecutive KPIs\n")

    for key, value in kpis.items():

        if isinstance(value, float):
            print(f"{key:<25}: {value:.2f}")
        else:
            print(f"{key:25}: {value:,}")

    generate_report(
        kpis, 
        fraud_analysis,
        OUTPUT_FILE
    )

    logger.info("Application finished.")

if __name__ == "__main__":
    main()

