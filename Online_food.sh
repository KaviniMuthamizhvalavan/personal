#!/bin/bash

echo "========================================"
echo " ONLINE FOOD ORDER VALIDATION SYSTEM "
echo "========================================"

# Accept command-line arguments
food=$1
qty=$2

# Price list
pizza=250
burger=150
dosa=80

# Validate food item
if [ "$food" = "pizza" ]
then
    price=$pizza
elif [ "$food" = "burger" ]
then
    price=$burger
elif [ "$food" = "dosa" ]
then
    price=$dosa
else
    echo "Invalid Food Item!"
    exit
fi

# Validate quantity
if [ $qty -le 0 ] || [ $qty -gt 10 ]
then
    echo "Invalid Quantity! Enter 1 to 10."
    exit
fi

# Calculate amount
total=$((price * qty))

# Delivery charges
if [ $total -ge 500 ]
then
    delivery=0
else
    delivery=50
fi

final=$((total + delivery))

# Display order summary
echo
echo "Food Item       : $food"
echo "Quantity        : $qty"
echo "Price per Item  : Rs.$price"
echo "Food Amount     : Rs.$total"
echo "Delivery Charge : Rs.$delivery"
echo "------------------------------"
echo "Total Amount    : Rs.$final"
