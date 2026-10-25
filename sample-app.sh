#!/bin/bash
set -euo pipefail

# workspace van Jenkins blijft bestaan tussen builds, dus tempdir eerst opruimen
rm -rf tempdir
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat > tempdir/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdir || exit
docker build -t sampleapp .
# oude container weg als die nog bestaat, anders is de naam al in gebruik
docker rm -f samplerunning 2>/dev/null || true
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
