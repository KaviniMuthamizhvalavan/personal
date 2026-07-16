from bank import accounts, transactions 

# 1. Create customer accounts with initial balances 
print(accounts.create_account("ACC-1001", 500.00)) 
print(accounts.create_account("ACC-1002", 150.00)) 

# 2. Perform transactions 
print(transactions.deposit("ACC-1001", 250.00)) 
print(transactions.withdraw("ACC-1002", 50.00)) 

# 3. Transfer funds between accounts 
print(transactions.transfer("ACC-1001", "ACC-1002", 300.00)) 

# 4. Check final balances 
print(f"\nFinal Balance (ACC-1001): ${accounts.get_balance('ACC-1001'):.2f}") 
print(f"Final Balance (ACC-1002): ${accounts.get_balance('ACC-1002'):.2f}") 
