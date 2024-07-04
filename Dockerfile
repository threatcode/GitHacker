# syntax=docker/dockerfile:1

FROM python:3.13.0b3-alpine AS builder
RUN apt-get update & apt-get upgrade
WORKDIR /app
RUN git clone https://github.com/threatcode/GitHacker.git
RUN cd GitHacker && pip install -r requirements.txt && python setup.py sdist bdist_wheel

FROM python:3.13.0b3-alpine 
COPY --from=builder /app/GitHacker/dist/ /app/
RUN pip install /app/*.whl
ENV GIT_PYTHON_REFRESH=quiet

ENTRYPOINT ["githacker"]
