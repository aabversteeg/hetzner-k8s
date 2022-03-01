FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN pip install --upgrade pip poetry

WORKDIR /app/ansible

COPY poetry.lock pyproject.toml ./ 
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

ENV ANSIBLE_RESOURCES_DIR=/ansible-resources
ENV ANSIBLE_COLLECTIONS_PATHS=$ANSIBLE_RESOURCES_DIR;$ANSIBLE_COLLECTIONS_PATHS

COPY requirements.yml .
RUN ansible-galaxy collection install -p $ANSIBLE_RESOURCES_DIR -r requirements.yml

COPY . .
ENTRYPOINT []
CMD ["ansible-playbook", "playbook.yml"]