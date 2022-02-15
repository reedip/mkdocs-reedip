FROM python:3

ENV DOCS_DIRECTORY='/mkdocs' \
    LIVE_RELOAD_SUPPORT='false' \
    ADD_MODULES='false' \
    FAST_MODE='false' \
    GIT_REPO='false' \
    GIT_BRANCH='master' \
    AUTO_UPDATE='false' \
    UPDATE_INTERVAL=15

RUN pip install --upgrade pip && \
    pip install mkdocs

ADD startUp.sh /

RUN chmod 755 /startUp.sh

EXPOSE 8000

ENTRYPOINT ["/startUp.sh"]

