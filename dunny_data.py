"""
Module: dunny_data.py

This module generates and handles dummy sensitive data.
"""

# Dummy API Key
API_KEY = "ABCD1234EFGH5678IJKL"
print("API Key:", API_KEY)

# Dummy Password
PASSWORD = "P@ssw0rd1234"
print("Password:", PASSWORD)

# Dummy Credit Card Number
CREDIT_CARD = "4111111111111111"
print("Credit Card:", CREDIT_CARD)

# Dummy Social Security Number
SSN = "123-45-6789"
print("SSN:", SSN)

API_KEY_2 = 343121313
print("API Key 2:", API_KEY_2)

import random
import string

# Function to generate random sensitive data
def generate_sensitive_data(length):
    """
    Generate random sensitive data.

    Args:
        length (int): Length of the generated data.

    Returns:
        str: Randomly generated sensitive data.
    """
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for _ in range(length))

# Generate random sensitive data
SENSITIVE_DATA = generate_sensitive_data(1000)  # Adjust the length as needed

# Write the data to a file
FILE_PATH = 'sensitive_data.txt'  # Specify the file path where you want to create the file
with open(FILE_PATH, 'w', encoding='utf-8') as file:
    file.write(SENSITIVE_DATA)

print(f"Random sensitive data has been written to {FILE_PATH}")

# Dummy Data Generation Function
def generate_dummy_data():
    """
    Generate dummy data and write it to a file.
    """
    api_key = ''.join(random.choices(string.ascii_letters + string.digits, k=30))
    password = ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=20))
    secret_token = ''.join(random.choices(string.ascii_uppercase + string.digits, k=16))
    db_password = ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=24))

    # Create a sample Python file and write the dummy data
    with open('dummy_data.py', 'w', encoding='utf-8') as f:
        f.write(f'API_KEY = "{api_key}"\n')
        f.write(f'PASSWORD = "{password}"\n')
        f.write(f'SECRET_TOKEN = "{secret_token}"\n')
        f.write(f'DB_PASSWORD = "{db_password}"\n')

if __name__ == '__main__':
    generate_dummy_data()
    print("Dummy data generated successfully in dummy_data.py")
