import csv
import random

# Function to generate a random Israeli phone number
def generate_israeli_phone_number():
    return "972-5" + ''.join(random.choices("0123456789", k=8))

# Function to generate unique phone numbers
def generate_unique_phone_numbers(count):
    phone_numbers = set()
    while len(phone_numbers) < count:
        phone_number = generate_israeli_phone_number()
        phone_numbers.add(phone_number)
    return list(phone_numbers)

# Function to generate SIDs (assuming SIDs are unique and sequential for simplicity)
def generate_sids(count):
    return list(range(1, count + 1))

# Generate 400 unique phone numbers
phone_numbers = generate_unique_phone_numbers(400)

# Generate 400 SIDs
sids = generate_sids(400)

# Write the data to a CSV file
with open('staff_member_info.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["SID", "Phone Number"])  # Writing header
    for sid, phone_number in zip(sids, phone_numbers):
        writer.writerow([sid, phone_number])

print("CSV file 'staff_member_info.csv' created successfully.")