FROM python:3.11

# ENV PYTHONUNBUFFERED 1
# RUN mkdir /code
WORKDIR /code
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
CMD python manage.py runserver