# Flask Image Downloader

Flask Image Downloader is a simple web application built with Flask and Boto3 that allows users to search for and download images from an AWS S3 bucket.<br />
The app have loadbalancer and monitored by Prometheus and Grafana.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements on your system:

- Python 3.8 or higher is installed.
- AWS account.
- `aws-cli` installed and configured.
- Public AWS S3 bucket
- EC2 with `tier:app` tag. feel free to use my `run_instance.sh` to setup your EC2.<br/>
  Change `REGION` in `deploy.sh` if needed.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Raz-Dahan/image_downloader.git
   cd image_downloader
   ```

2. Install the required Python packages:

   ```bash
   pip install -r app/requirements.txt
   ```

3. Set up your AWS credentials and S3 bucket name by creating a `.env` file on your local machine and update the `ENV_Path` in `deploy.sh`. Example:

   ```plaintext
   AWS_ACCESS_KEY_ID=your_access_key_id
   AWS_SECRET_ACCESS_KEY=your_secret_access_key
   S3_BUCKET_NAME=your_bucket_name
   ```
4. Place AWS RSA key file on your local machine and update the `RSA_Key` in `deploy.sh`.

## Usage

1. Run the Flask application localy:

   ```bash
   python3 app/app.py
   ```

   Alternatively you can run the application as a Docker container on an AWS EC2:

   ```bash
   chmod u+x deploy.sh
   ./deploy.sh
   ```

2. Access the application in your VM's IP at `http://IP:80`.

3. Enter a search term for the image you want to download and click the "Download" button.

4. If the image is found in the S3 bucket, it will be downloaded to your local machine.

5. To access Prometheus and Grafana use `admin` as username and password in local machine via

```
ssh -i "<path to rsa key>"-L 9090:localhost:9090 -L 3000:localhost:3000 <vm hostname>@<vm ip>
```

## Configuration

- `app.py`: This is the main Flask application script that handles routing, user interface, and interaction with the S3 bucket. Modify this file to customize the behavior of the application.

- `templates/index.html`: This HTML template defines the user interface for the application. You can modify the template's structure and styling to match your preferences.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, feel free to submit a pull request or open an issue.

## License

This project is licensed under the [MIT License](LICENSE).
