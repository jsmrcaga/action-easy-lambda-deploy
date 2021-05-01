FROM jsmrcaga/aws-cli:latest

# Add entrypoint to be able to run it
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
