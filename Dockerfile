FROM python:3.10.9
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]
