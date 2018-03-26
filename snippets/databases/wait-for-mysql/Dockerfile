FROM alpine:3.6

WORKDIR /workdir

COPY ./wait-for-mysql.sh .

ENTRYPOINT ["./wait-for-mysql.sh"]
