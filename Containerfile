FROM manimcommunity/manim

USER root

RUN apt-get install -y git micro ffmpeg

USER manimuser
