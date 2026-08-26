"""
Enterprise Banking Fraud Analytics
-----------------------------------
Module: logger.py

Purpose:
Configure application logging.
"""

import logging


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
    filename="enterprise_fraud.log",
    filemode="w"
)

logger = logging.getLogger(__name__)