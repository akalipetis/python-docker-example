FROM python:3.7

# Allow for PIPENV_ARGS to be supplied as an argument, so that things like --dev can be included for development
ARG PIPENV_ARGS

# Needed so that logs are immediately flushed to stdout
ENV PYTHONUNBUFFERED=1

# The directory for our code
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install latest pip and pipenv to manage dependencies
RUN pip install -U pip pipenv

# First, just copy Pipfile and Pipfile.lock for better caching and install dependencies
COPY Pipfile Pipfile.lock /usr/src/app/
RUN pipenv install --system --deploy ${PIPENV_ARGS}

# Copy the code in the image
COPY ./ /usr/src/app
