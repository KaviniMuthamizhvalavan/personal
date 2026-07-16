from utilities import string_ops, math_ops, file_ops 

# 1. Clean and analyze text using string_ops 
raw_feedback = "Great product! Works fast, but price is high..."
clean_text = string_ops.remove_punctuation(raw_feedback) 
vowel_count = string_ops.count_vowels(clean_text) 

print(f"Cleaned Text: {clean_text}")
print(f"Vowels Count: {vowel_count}")

# 2. Perform statistical calculations using math_ops 
response_times = [12, 15, 12, 18, 22, 14, 15]
print(f"Mean Response Time: {math_ops.mean(response_times):.2f}ms") 
print(f"Standard Deviation: {math_ops.standard_deviation(response_times):.2f}ms") 

# 3. Handle file operations using file_ops 
file_ops.write_file("report.txt", f"Average time: {math_ops.mean(response_times):.2f}ms") 
print("File Content:", file_ops.read_file("report.txt")) 
