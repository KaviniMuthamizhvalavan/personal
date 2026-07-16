def add_item(cart, item_name, price):
    """Add an item and its price to the shopping cart."""
    cart[item_name] = price
    return f"Added {item_name} to cart."

def remove_item(cart, item_name):
    """Remove an item from the cart."""
    if item_name in cart:
        del cart[item_name]
        return f"Removed {item_name} from cart."
    return "Item not found in cart."

def calculate_total(cart):
    """Calculate the total bill of all items in the cart."""
    return sum(cart.values())
