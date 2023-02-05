FROM python:3.7

RUN apt-get update -y 
COPY ./ /app
WORKDIR /app
RUN pip install flask
ENTRYPOINT [ "python" ]
CMD [ "run.py" ]