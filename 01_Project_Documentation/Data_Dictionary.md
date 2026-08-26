# Data Dictionary

## Enterprise Banking Fraud Analytics

This data dictionary describes the key fields available in the cleaned credit card transaction dataset used for fraud analytics.

| Column | Description | Business Usage |
|---|---|---|
| `trans_date_trans_time` | Transaction date and time | Time-based fraud analysis |
| `cc_num` | Credit card number | Customer/card-level transaction identification |
| `merchant` | Merchant associated with the transaction | Merchant fraud analysis |
| `category` | Transaction category | Category-level fraud analysis |
| `amt` | Transaction amount | Transaction value and fraud amount analysis |
| `first` | Customer first name | Customer information |
| `last` | Customer last name | Customer information |
| `gender` | Customer gender | Customer demographic analysis |
| `street` | Customer street address | Customer location information |
| `city` | Customer city | Geographic analysis |
| `state` | Customer state | State-level fraud analysis |
| `zip` | Customer ZIP code | Geographic analysis |
| `lat` | Customer latitude | Geographic analysis |
| `long` | Customer longitude | Geographic analysis |
| `city_pop` | Population of the customer's city | Geographic/business context |
| `job` | Customer occupation | Customer segmentation |
| `dob` | Customer date of birth | Customer demographic information |
| `trans_num` | Unique transaction identifier | Transaction identification |
| `unix_time` | Unix timestamp of transaction | Time-based analysis |
| `merch_lat` | Merchant latitude | Merchant geographic analysis |
| `merch_long` | Merchant longitude | Merchant geographic analysis |
| `is_fraud` | Fraud indicator | Fraud classification and KPI calculation |
| `merch_zipcode` | Merchant ZIP code | Merchant geographic analysis |

---

## Key Analytical Fields

### `amt`

Represents the monetary value of a transaction.

Used for:

- Average transaction amount
- Maximum transaction amount
- Total fraud amount
- Transaction amount analysis

### `is_fraud`

The primary fraud indicator.

Values:

- `0` = Genuine transaction
- `1` = Fraudulent transaction

Used for:

- Fraud transaction count
- Fraud rate
- Fraud by category
- Fraud by state
- Fraud by merchant
- Fraud by hour

### `trans_date_trans_time`

Contains the transaction date and time.

Used to extract the transaction hour and identify time-based fraud patterns.

### `category`

Represents the business category of the transaction.

Used to identify categories with higher fraud volumes.

### `merchant`

Identifies the merchant associated with a transaction.

Used to identify merchants with high fraud transaction counts.

### `state`

Represents the customer's state.

Used for geographic fraud analysis.

---

## Dataset Notes

The complete dataset contains approximately 1.3 million transactions.

The full raw and cleaned datasets are maintained locally because of their large file size.

A 10,000-row representative sample is included in the GitHub repository for demonstration purposes.
