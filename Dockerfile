FROM python:3.7
MAINTAINER label="Rohan Rustagi"
RUN apt-get update -y 
COPY ./ /app
WORKDIR /app
RUN pip install flask
EXPOSE 80
CMD [ "python", "run.py" ]
