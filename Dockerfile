#create a base image in which all the required dependencies are installed
FROM python:3.9
#Create a working directory in which my application source code will be stored
WORKDIR /app
#Copy all the rquirements from the host machine to the working directory in the container
COPY requirements.txt .
COPY app.py .
COPY run.py .
#Install all the dependencies specified in the requirements.txt file
RUN pip install -r requirements.txt
#Expose the port number on wich your application will be running
EXPOSE 8000
#Command to run the application
CMD ["python","run.py"]

