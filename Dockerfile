FROM python:3.14.6-slim
WORKDIR /app/
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . . 

EXPOSE 80

LABEL author="Usman Ghani"

ENTRYPOINT ["python"]
CMD ["run.py"]
