from flask import Flask, request, jsonify
from source import get_fortune

app = Flask(__name__)

@app.route('/api/fortune', methods=['GET'])
def get_fortune_api():
    # API endpoint to get a fortune based on input or random if no input
    input_param = request.args.get('input', '').lower()

    # Fetch the fortune using the get_fortune function from source.py
    result = get_fortune(input_param)

    if result and 'fortune' in result:
        return jsonify(result)
    else:
        return jsonify({"fortune": False}), 404

if __name__ == '__main__':
    app.run(host="0.0.0.0",port=5000,debug=False)
