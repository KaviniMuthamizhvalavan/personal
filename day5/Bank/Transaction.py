from banking.accounts import accounts_db, get_balance 

def deposit(account_number, amount):
    """Deposit money into a specified account."""
    if account_number not in accounts_db:
        return "Account not found."
    if amount <= 0:
        return "Invalid deposit amount."
    
    accounts_db[account_number] += amount
    return f"Deposited ${amount:.2f}. New Balance: ${get_balance(account_number):.2f}" 

def withdraw(account_number, amount):
    """Withdraw money from an account if sufficient funds exist."""
    if account_number not in accounts_db:
        return "Account not found."
    if amount > accounts_db[account_number]:
        return "Insufficient funds."
    
    accounts_db[account_number] -= amount
    return f"Withdrew ${amount:.2f}. Remaining Balance: ${get_balance(account_number):.2f}"

def transfer(from_acc, to_acc, amount):
    """Transfer funds between two accounts."""
    if from_acc not in accounts_db or to_acc not in accounts_db:
        return "One or both accounts do not exist."
    if amount > accounts_db[from_acc]:
        return "Transfer failed: Insufficient funds."
    
    accounts_db[from_acc] -= amount
    accounts_db[to_acc] += amount
    return f"Transferred ${amount:.2f} from {from_acc} to {to_acc}."
