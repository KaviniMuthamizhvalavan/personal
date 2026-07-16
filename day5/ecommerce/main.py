from ecommerce import cart, payment 

my_cart = {}
cart.add_item(my_cart, "Laptop", 999.99) 
cart.add_item(my_cart, "Mouse", 25.50) 

total_bill = cart.calculate_total(my_cart) 
print(f"Total Bill: ${total_bill:.2f}")
print(payment.process_payment(total_bill)) 
