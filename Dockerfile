FROM python:3.10
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.7.1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"
RUN mkdir /app 

COPY  poetry.lock pyproject.toml ./ 
WORKDIR /app
ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
# RUN pip3 install poetry
RUN pip install "poetry==$POETRY_VERSION"
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
COPY . .
# CMD ["python", "./main.py"]
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]

# FROM python:3.10 as python-base

# ENV PYTHONUNBUFFERED=1 \
#     PYTHONDONTWRITEBYTECODE=1 \
#     PIP_NO_CACHE_DIR=off \
#     PIP_DISABLE_PIP_VERSION_CHECK=on \
#     PIP_DEFAULT_TIMEOUT=100 \
#     POETRY_VERSION=1.7.1 \
#     POETRY_HOME="/opt/poetry" \
#     POETRY_VIRTUALENVS_IN_PROJECT=true \
#     POETRY_NO_INTERACTION=1 \
#     PYSETUP_PATH="/opt/pysetup" \
#     VENV_PATH="/opt/pysetup/.venv"

# # prepend poetry and venv to path
# ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# ###############################################
# # Builder Image
# ###############################################
# FROM python-base as builder-base
# RUN apt-get update \
#     && apt-get install --no-install-recommends -y \
#     curl \
#     build-essential

# # install poetry - respects $POETRY_VERSION & $POETRY_HOME
# RUN curl -sSL https://install.python-poetry.org | python3 -

# # copy project requirement files here to ensure they will be cached.
# WORKDIR $PYSETUP_PATH
# COPY poetry.lock pyproject.toml ./

# # install runtime deps - uses $POETRY_VIRTUALENVS_IN_PROJECT internally
# RUN pip install "poetry==$POETRY_VERSION"

# ###############################################
# # Production Image
# ###############################################
# FROM python-base as production
# COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH
# COPY ./app /app/
# #CMD ["python", "./backend/main.py"]
# CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "80"]