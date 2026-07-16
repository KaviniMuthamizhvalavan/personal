def write_file(filepath, content):
    """Write text content to a file."""
    with open(filepath, 'w', encoding='utf-8') as file:
        file.write(content)
    return f"Successfully wrote to {filepath}"

def read_file(filepath):
    """Read and return the contents of a file."""
    with open(filepath, 'r', encoding='utf-8') as file:
        return file.read()

def search_in_file(filepath, keyword):
    """Search for a keyword in a file and return matching lines."""
    matches = []
    with open(filepath, 'r', encoding='utf-8') as file:
        for line_num, line in enumerate(file, 1):
            if keyword.lower() in line.lower():
                matches.append((line_num, line.strip()))
    return matches
