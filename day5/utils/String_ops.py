import string

def remove_punctuation(text):
    """Remove all punctuation from a string."""
    return text.translate(str.maketrans('', '', string.punctuation))

def count_vowels(text):
    """Count the number of vowels in a string."""
    vowels = "aeiouAEIOU"
    return sum(1 for char in text if char in vowels)
