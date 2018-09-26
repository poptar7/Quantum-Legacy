FROM python:3.6.6-alpine3.8

COPY subber /opt/subber
RUN pip3 install -r /opt/subber/requirements.txt

WORKDIR /opt/subber

CMD python3 feedSub.py