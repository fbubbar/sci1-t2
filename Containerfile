FROM manimcommunity/manim

USER root

RUN apt-get install -y git micro ffmpeg

USER manimuser

# additional packages
RUN pip install pandas ipympl
