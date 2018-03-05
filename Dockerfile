FROM ocaml/opam:alpine

RUN opam switch 4.05.0 && \
    eval `opam config env` && \
    opam depext -i jbuilder core cohttp cohttp-lwt-unix

ADD src /app/src
WORKDIR /app

RUN sudo chown -R opam:nogroup /app && \
    eval `opam config env` && \
    jbuilder build ./src/test.exe

EXPOSE 8000

CMD /app/_build/default/src/test.exe
