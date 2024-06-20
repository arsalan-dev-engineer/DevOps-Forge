
# Testing pipeline to detect secrets (not real secrets)

# dummy API Key
api_key = "ABCD1234EFGH5678IJKL"
print("API Key: ", api_key)

# dummy Password
password = "P@ssw0rd1234"
print("Password: ", password)

# dummy Credit Card Number
credit_card = "4111111111111111"
print("Credit Card: ", credit_card)

# dummy Social Security Number
ssn = "123-45-6789"
print("SSN: ", ssn)

password_key = "3214322"
print(password_key)

api_key_2 = 343121313
print(api_key_2)


import random
import string

# Function to generate random sensitive data
def generate_sensitive_data(length):
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for _ in range(length))

# Generate random sensitive data
sensitive_data = generate_sensitive_data(1000)  # Adjust the length as needed

# Write the data to a file
file_path = 'sensitive_data.txt'  # Specify the file path where you want to create the file
with open(file_path, 'w') as file:
    file.write(sensitive_data)

print(f"Random sensitive data has been written to {file_path}")
