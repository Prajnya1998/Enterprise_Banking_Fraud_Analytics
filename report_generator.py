"""
Enterprise Banking Fraud Analytics
-----------------------------------
Module : report_generator.py

Purpose:
Generate the executive Excel report.
"""

import pandas as pd

from excel_formatter import format_workbook
from dashboard import create_dashboard
from logger import logger


def generate_report(kpis, fraud_analysis, output_path):
    """
    Generate an Excel report containing executive KPIs.

    Parameters:
        kpis (dict): Executive KPI values.
        fraud_analysis (dict): Detailed fraud analysis results.
        output_path (str): Excel output file path.
    """

    try:

        # ==========================================================
        # CREATE KPI DATAFRAME
        # ==========================================================

        kpi_df = pd.DataFrame(
            list(kpis.items()),
            columns=["Metric", "Value"]
        )

        # ==========================================================
        # CREATE EXCEL REPORT
        # ==========================================================

        with pd.ExcelWriter(
            output_path,
            engine="openpyxl"
        ) as writer:

            # Write executive KPI sheet
            kpi_df.to_excel(
                writer,
                sheet_name="Executive_KPIs",
                index=False
            )

            # =========================================
            # FRAUD ANALYSIS SHEETS
            # ==========================================

            fraud_analysis["category"].head(10).reset_index(
                name="Fraud_Count"
            ).to_excel(
                writer,
                sheet_name="Fraud_By_Category",
                index=False
            )

            fraud_analysis["state"].head(10).reset_index(
                name="Fraud_Count"
            )

            fraud_analysis["merchant"].head(10).reset_index(
                name="Fraud_Count"
            ).to_excel(
                writer,
                sheet_name="Fraud_By_Merchant",
                index=False
            )

            fraud_analysis["hour"].head(10).reset_index(
                name="Fraud_Count"
            ).to_excel(
                writer,
                sheet_name="Fraud_By_Hour",
                index=False
            )

            # ======================================================
            # CREATE DASHBOARD
            # ======================================================

            workbook = writer.book

            create_dashboard(workbook, kpis)

            # ======================================================
            # APPLY EXCEL FORMATTING
            # ======================================================

            format_workbook(workbook)

        # ==========================================================
        # SUCCESS MESSAGE
        # ==========================================================

        logger.info(
            "Excel report generated successfully."
        )

        print("\n[SUCCESS] Report generated successfully.")
        print(f"Output File : {output_path}")

    except PermissionError:

        logger.error(
            "Excel file is already open."
        )

        print("\n[ERROR]")
        print("Cannot save the report.")
        print("Please close the Excel file and try again.")

    except Exception as e:

        logger.exception(
            "Unexpected error while generating report."
        )

        print("\n[ERROR]")
        print(f"Unexpected Error: {e}")