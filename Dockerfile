FROM python:3.8-alpine

RUN set -eux \
	&& apk add --update --no-cache \
		openssh-client \
		git \
		gcc \
		libffi-dev \
		make \
		musl-dev \
		openssl \
		openssl-dev \
    && mkdir -p /etc/ansible \
    && echo localhost > /etc/ansible/hosts \
	&& mkdir -p /root/.ssh \
	&& chmod 700 /root/.ssh

RUN set -eux \
    && pip3 install --no-cache-dir --no-compile \
        ansible\<2.10 \
        kubernetes \
        openshift \
				mitogen \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

RUN mkdir -p /repo
WORKDIR /repo
VOLUME /repo
CMD ["ansible-playbook", "--version"]
