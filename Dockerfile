FROM python:3.10-slim-buster
WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN pip install streamlit

RUN apt update && \
    apt -y upgrade && \
    apt install -y ffmpeg && \
    pip3 install --upgrade pip && \
    pip3 install poetry && \
    rm poetry.lock && \
    poetry lock && \
    poetry config virtualenvs.create false && \
    poetry install

RUN pip3 install openai==1.6.1
EXPOSE 8501

COPY . /app

ENTRYPOINT ["streamlit", "run"]

CMD ["app.py"]
