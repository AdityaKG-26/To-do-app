FROM python:3.9

WORKDIR /data

#COPY . .
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

#RUN pip install --upgrade pip

#RUN pip install django==3.2

RUN python manage.py migrate

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]


