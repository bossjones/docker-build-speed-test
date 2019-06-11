FROM python:3.7-slim AS base
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc

RUN python -m venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# COPY setup.py .
# COPY project/ .
# RUN pip install .

FROM python:3.7-slim AS stage
RUN apt-get update && \
    apt-get -y install netcat && \
    apt-get clean
WORKDIR /usr/src/app
COPY --from=base /opt/venv /opt/venv
COPY . /usr/src/app
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

CMD gunicorn -b 0.0.0.0:5000 manage:app
# CMD ['project']
