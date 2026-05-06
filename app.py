#!/usr/bin/env python3
"""
Vulnerable Flask Application
This app intentionally contains a Command Injection vulnerability
for security scanning demonstration purposes.
"""

from flask import Flask, request
import subprocess
import os

app = Flask(__name__)

@app.route('/')
def home():
    return '''
    <h1>Security Lab - Command Injection Demo</h1>
    <p>This is a deliberately vulnerable app for testing security tools.</p>
    <form action="/ping" method="POST">
        <input type="text" name="host" placeholder="Enter hostname">
        <button type="submit">Ping Host</button>
    </form>
    '''

@app.route('/ping', methods=['POST'])
def ping():
    """
    VULNERABLE: Command Injection
    User input is directly passed to subprocess without sanitization
    """
    host = request.form.get('host', 'localhost')
    # BUG: This allows command injection (e.g., "8.8.8.8; cat /etc/passwd")
    result = subprocess.run(f"ping -c 1 {host}", shell=True, capture_output=True, text=True)
    return f"<pre>{result.stdout}</pre>"

@app.route('/health')
def health():
    return {'status': 'healthy'}, 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
