import os
import random
import re

DATAFILES_DIR = 'datafiles/'

def get_fortune(input_param=None):
    # Fetch a fortune based on input or a random fortune if no input is given
    if input_param:
        return get_fortune_from_file(input_param)
    else:
        all_files = os.listdir(DATAFILES_DIR)
        random_file = random.choice(all_files)
        return get_fortune_from_file(random_file)

def get_fortune_from_file(file_name):
    # Reads a fortune file and returns a random fortune separated by '%'
    file_path = os.path.join(DATAFILES_DIR, file_name.lower())

    if not os.path.exists(file_path):
        return None

    with open(file_path, 'r') as file:
        content = file.read()

    # Remove unwanted newlines (\n) and tabs (\t)
    content = content.replace('\n', ' ').replace('\t', ' ')

    # Split the content based on the '%' symbol, trimming spaces around each fortune
    fortunes = re.split(r'\s*%\s*', content.strip())

    # Filter out any empty strings that might appear after splitting
    fortunes = [fortune.strip() for fortune in fortunes if fortune.strip()]

    if fortunes:
        return {
            'fortune': random.choice(fortunes),
            'file': file_name
        }
    else:
        return {"fortune": "No fortunes found.", "file": file_name}
