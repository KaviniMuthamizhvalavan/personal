import random

def process_payment(amount):
    """Simulate a payment processing transaction."""
    if amount <= 0:
        return "Payment Failure: Invalid amount."
    
    # Simulate a 90% success rate
    success = random.choices([True, False], weights=[90, 10])[0]
    if success:
        return f"Payment Success: ${amount:.2f} processed."
    else:
        return "Payment Failure: Transaction declined."
