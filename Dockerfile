FROM python:3.8

WORKDIR /app

RUN mkdir /tmp

COPY app/ .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

CMD ["python", "app.py"]
