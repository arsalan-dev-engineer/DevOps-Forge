# Generate dummy sensitive data
import random
import string

def generate_dummy_data():
    api_key = ''.join(random.choices(string.ascii_letters + string.digits, k=30))
    password = ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=20))
    secret_token = ''.join(random.choices(string.ascii_uppercase + string.digits, k=16))
    db_password = ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=24))

    # Create a sample Python file and write the dummy data
    with open('dummy_data.py', 'w') as f:
        f.write(f'API_KEY = "{api_key}"\n')
        f.write(f'password = "{password}"\n')
        f.write(f'secret_token = "{secret_token}"\n')
        f.write(f'db_password = "{db_password}"\n')

if __name__ == '__main__':
    generate_dummy_data()
    print("Dummy data generated successfully in dummy_data.py")
