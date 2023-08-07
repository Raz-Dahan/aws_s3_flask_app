# Flask Image Downloader

Flask Image Downloader is a simple web application built with Flask and Boto3 that allows users to search for and download images from an AWS S3 bucket.

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

Before you begin, ensure you have met the following requirements:

- Python 3.8 or higher is installed on your system.
- Docker and Docker Compose are installed if you plan to use Docker.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Raz-Dahan/flask_image_downloader.git
   cd flask_image_downloader
   ```

2. Install the required Python packages:

   ```bash
   pip install -r requirements.txt
   ```

3. Set up your AWS credentials and S3 bucket name by creating a `.env` file in the project directory. Example:

   ```plaintext
   AWS_ACCESS_KEY_ID=your_access_key_id
   AWS_SECRET_ACCESS_KEY=your_secret_access_key
   S3_BUCKET_NAME=your_bucket_name
   ```

## Usage

1. Run the Flask application:

   ```bash
   python app.py
   ```

   Alternatively, if you're using Docker, you can run the application as a Docker container:

   ```bash
   docker-compose up -d
   ```

2. Access the application in your web browser at `http://localhost`.

3. Enter a search term for the image you want to download and click the "Download" button.

4. If the image is found in the S3 bucket, it will be downloaded to your local machine.

## Configuration

- `app.py`: This is the main Flask application script that handles routing, user interface, and interaction with the S3 bucket. Modify this file to customize the behavior of the application.

- `templates/index.html`: This HTML template defines the user interface for the application. You can modify the template's structure and styling to match your preferences.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, feel free to submit a pull request or open an issue.

## License

This project is licensed under the [MIT License](LICENSE).