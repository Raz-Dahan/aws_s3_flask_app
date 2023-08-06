import os
from flask import Flask, render_template, request, send_from_directory
from dotenv import load_dotenv
import boto3

load_dotenv()

app = Flask(__name__)

AWS_ACCESS_KEY_ID = os.environ.get('AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = os.environ.get('AWS_SECRET_ACCESS_KEY')
S3_BUCKET_NAME = os.environ.get('S3_BUCKET_NAME')
REGION_NAME = 'eu-central-1'

s3_client = boto3.client('s3', aws_access_key_id=AWS_ACCESS_KEY_ID, aws_secret_access_key=AWS_SECRET_ACCESS_KEY, region_name=REGION_NAME)

@app.route('/', methods=['GET', 'POST'])
def index():
    message = ""

    if request.method == 'POST':
        search_name = request.form['search_name']
        file_key = f'{search_name}.jpg'
        tmp_file_path = os.path.join('/tmp', file_key)

        try:
            s3_client.download_file(S3_BUCKET_NAME, file_key, tmp_file_path)
            message = f'{file_key} downloaded successfully'
            return send_from_directory('/tmp', file_key, as_attachment=True, download_name=file_key)
        except:
            message = f'No luck finding {file_key}'

    return render_template('index.html', message=message)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)
