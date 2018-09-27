FROM python:3.7-slim-stretch

RUN apt-get update && apt-get install -y --no-install-recommends git wget build-essential

# RUN pip install git+https://bjelkenhed:bH4ywNFxRKuMwMCj6RQZ@bitbucket.org/iris-common/iris-nlp.git@v1.2
# -b defines the tag and depth 1 avoids cloning earlier revisions
WORKDIR /
RUN git clone -b "v1.2" --depth 1 https://bjelkenhed:bH4ywNFxRKuMwMCj6RQZ@bitbucket.org/iris-common/iris-nlp.git iris-nlp
RUN pip install ./iris-nlp

COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt

RUN mkdir resources
WORKDIR resources
RUN wget -q http://www.omegateam.se/resources/dictionaries/concept_dictionary_v1.2.0.pickle
RUN wget -q http://www.omegateam.se/resources/dictionaries/word_dictionary.pickle
RUN wget -q http://www.omegateam.se/resources/tokenizers/sent_tokenizer.pickle

WORKDIR /
ENV APP_HOME /app
RUN mkdir $APP_HOME
COPY $APP_HOME/ $APP_HOME
WORKDIR $APP_HOME

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["app.py"]
