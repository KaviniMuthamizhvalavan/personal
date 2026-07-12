#!/bin/bash

echo "========== STORE INVENTORY MANAGEMENT =========="

# Create required directories
mkdir -p inventory reports archive

# Set environment variable
export STORE_HOME=$(pwd)

echo "Store Home: $STORE_HOME"
echo "Current User: $(whoami)"
echo "Date: $(date)"
echo "Current Directory: $(pwd)"

# Create inventory file
cat > inventory/products.txt << EOF
101,Rice,50,60
102,Sugar,8,45
103,Oil,30,150
104,Soap,5,35
105,Biscuit,75,20
106,Milk,12,30
107,Tea,4,120
EOF

echo
echo "===== INVENTORY FILE ====="
cat inventory/products.txt

echo
echo "===== NUMBERED INVENTORY ====="
cat -n inventory/products.txt

echo
echo "===== Search Product: Rice ====="
grep "Rice" inventory/products.txt

echo
echo "===== Low Stock Products (Quantity < 10) ====="
awk -F',' '$3<10 {print $2,"Quantity:",$3}' inventory/products.txt

echo
echo "===== Products with Price > 100 ====="
awk -F',' '$4>100 {print $2,"Price:",$4}' inventory/products.txt

echo
echo "===== Total Inventory Value ====="
awk -F',' '{total += $3*$4} END {print total}' inventory/products.txt

echo
echo "===== Replace Milk with FreshMilk (Display Only) ====="
sed 's/Milk/FreshMilk/' inventory/products.txt

echo
echo "===== Generating Inventory Report ====="

{
echo "STORE INVENTORY REPORT"
echo "Generated on: $(date)"
echo "----------------------------------------"

awk -F',' '
{
value=$3*$4

if($3<10)
status="LOW STOCK"
else
status="AVAILABLE"

printf "%-5s %-12s Qty:%-5s Price:%-6s Value:%-8s %s\n",$1,$2,$3,$4,value,status
}
END{
print "----------------------------------------"
}' inventory/products.txt

echo
echo "Low Stock Products:"
awk -F',' '$3<10 {print $2,"(", $3,")"}' inventory/products.txt

echo
echo "Total Inventory Value:"
awk -F',' '{sum+=$3*$4} END{print sum}' inventory/products.txt

} > reports/inventory_report.txt

echo
echo "===== REPORT ====="
cat reports/inventory_report.txt

echo
echo "===== Running Processes ====="
ps

echo
echo "===== Compressing Report ====="
tar -czf archive/inventory_report.tar.gz reports

echo "Archive Created Successfully."

echo
echo "Files in Archive Folder:"
ls archive

echo
echo "========== TASK COMPLETED =========="
