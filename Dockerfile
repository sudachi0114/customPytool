FROM python:3.8-slim

RUN apt update && \
    apt install -y vim tree

COPY . /root/
WORKDIR /root/src/

RUN python setup.py sdist
RUN pip install dist/*

WORKDIR /root/
CMD ["bash", "test.sh"]
