# Who knows maybe this will work.
FROM alpine

RUN apk -U upgrade && \
    apk add bash git gcc libffi-dev python py-pip py-setuptools \
    python-dev build-base openssl-dev libffi-dev \
    snappy-dev py-mysqldb gmp-dev mpfr-dev

RUN addgroup -g 2000 cowrie && \
    adduser -S -s /bin/bash -u 2000 -D -g 2000 cowrie

RUN git clone https://github.com/cowrie/cowrie.git /opt/cowrie/ && \
    cd /opt/cowrie && \
    pip install --no-cache-dir --upgrade cffi && \
    pip install --no-cache-dir -U -r requirements.txt

RUN chown cowrie:cowrie -R /opt/cowrie/*

ENV PATH=/opt/cowrie/bin:${PATH}

USER cowrie
WORKDIR /opt/cowrie
ENTRYPOINT [ "cowrie" ]
CMD [ "start", "-n" ]