# Shared state representing the bank database
accounts_db = {}

def create_account(account_number, initial_balance=0.0):
    """Create a new bank account with an initial deposit."""
    if account_number in accounts_db:
        return "Account already exists."
    accounts_db[account_number] = initial_balance
    return f"Account {account_number} created successfully."

def get_balance(account_number):
    """Check and return the balance of an account."""
    return accounts_db.get(account_number, "Account not found.")
