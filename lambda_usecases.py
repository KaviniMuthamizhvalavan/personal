

from functools import reduce

# 1. Sort a list of tuples by the second element (descending)
print("1. Employee Performance Ranking")
employees = [("Asha", 85), ("Bala", 92), ("Chitra", 78)]
sorted_employees = sorted(employees, key=lambda x: x[1], reverse=True)

for name, score in sorted_employees:
    print(name, score)

# 2. Use map() and lambda to square numbers
print("\n2. Square of Numbers")
readings = [2, 3, 4]
squares = list(map(lambda x: x**2, readings))
print("Original:", readings)
print("Squared :", squares)

# 3. Filter out even numbers using filter() and lambda
print("\n3. Filter Odd Player IDs")
player_ids = [101, 102, 103, 104, 105]
odd_ids = list(filter(lambda x: x % 2 != 0, player_ids))
print("Player IDs:", player_ids)
print("Odd IDs   :", odd_ids)

# 4. Use reduce() and lambda to calculate product
print("\n4. Product of Dimensions")
dimensions = [2, 3, 5]
product = reduce(lambda x, y: x * y, dimensions)
print("Dimensions:", dimensions)
print("Product:", product)

# 5. Sort a dictionary by values (marks)
print("\n5. Student Rank List")
students = {
    "Asha": 78,
    "Bala": 90,
    "Chitra": 65
}

rank_list = sorted(students.items(), key=lambda x: x[1], reverse=True)

rank = 1
for name, marks in rank_list:
    print(f"Rank {rank}: {name} - {marks}")
    rank += 1
