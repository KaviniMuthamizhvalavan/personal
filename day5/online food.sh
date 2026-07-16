order_ids=()
customers=()
items=()
bills=()

while true
do
echo "==============================="
echo " Online Food Delivery System"
echo "==============================="
echo "1. Add New Order"
echo "2. Add Food Item"
echo "3. Remove Food Item"
echo "4. Display All Orders"
echo "5. Search Order"
echo "6. Remove Delivered Order"
echo "7. Exit"
echo "==============================="

read -p "Enter your choice: " choice

case $choice in

1)
read -p "Enter Order ID: " oid
read -p "Enter Customer Name: " cname

order_ids+=("$oid")
customers+=("$cname")
items+=("")
bills+=(0)

echo "Order created successfully."
;;

2)
read -p "Enter Order ID: " oid

found=0

for ((i=0;i<${#order_ids[@]};i++))
do
if [ "${order_ids[i]}" == "$oid" ]
then
found=1

read -p "Enter Food Item: " item
read -p "Enter Item Price: " price

if [ -z "${items[i]}" ]
then
items[i]="$item"
else
items[i]="${items[i]}, $item"
fi

bills[i]=$(( ${bills[i]} + price ))

echo "Item added successfully."

break
fi
done

if [ $found -eq 0 ]
then
echo "Order not found."
fi
;;

3)
read -p "Enter Order ID: " oid

found=0

for ((i=0;i<${#order_ids[@]};i++))
do

if [ "${order_ids[i]}" == "$oid" ]
then
found=1

read -p "Enter Item to Remove: " remove_item

new_items=""

IFS=',' read -ra food <<< "${items[i]}"

for f in "${food[@]}"
do

f=$(echo "$f" | xargs)

if [ "$f" != "$remove_item" ]
then

if [ -z "$new_items" ]
then
new_items="$f"
else
new_items="$new_items, $f"
fi

fi

done

items[i]="$new_items"

echo "Item removed successfully."

break

fi

done

if [ $found -eq 0 ]
then
echo "Order not found."
fi
;;

4)
if [ ${#order_ids[@]} -eq 0 ]
then
echo "No Orders Available."
else

for ((i=0;i<${#order_ids[@]};i++))
do

echo "---------------------"
echo "Order ID : ${order_ids[i]}"
echo "Customer : ${customers[i]}"
echo "Items : ${items[i]}"
echo "Total Bill : ${bills[i]}"
done

fi
read -p "Enter Order ID to Search: " search_id

found=0

for ((i=0;i<${#order_ids[@]};i++))
do
    if [ "${order_ids[i]}" == "$search_id" ]
    then
        found=1

        echo "Order Found"
        echo "Order ID : ${order_ids[i]}"
        echo "Customer : ${customers[i]}"
        echo "Items : ${items[i]}"
        echo "Total Bill : ${bills[i]}"

        break
    fi
done

if [ $found -eq 0 ]
then
    echo "Order Not Found."
fi
;;
6)
read -p "Enter Delivered Order ID: "
delete_id

found=0

for ((i=0;i<${#order_ids[@]};i++))
do
    if [ "${order_ids[i]}" == "$delete_id" ]
    then
        found=1

        unset order_ids[i]
        unset customers[i]
        unset items[i]
        unset bills[i]

        order_ids=("${order_ids[@]}")
        customers=("${customers[@]}")
        items=("${items[@]}")
        bills=("${bills[@]}")

        echo "Order removed successfully."

        break
    fi
done

if [ $found -eq 0 ]
then
    echo "Order Not Found."
fi
;;
7)
echo "Exiting Program..."
break
;;

*)
echo "Invalid Choice!"
;;

esac

done

