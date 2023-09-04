FROM python:3.8

WORKDIR /app

COPY app/ .

COPY .env .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

CMD ["python", "app.py"]