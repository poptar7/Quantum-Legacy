FROM python:3.7.0-alpine3.8

COPY subber /opt/subber
RUN pip3 install -r /opt/subber/requirements.txt

CMD ["python3 /opt/subber/feedSub.py"]