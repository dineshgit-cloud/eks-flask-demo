FROM python:3.12-alpine 
#only SQLlite issue
WORKDIR /app
# Upgrade Alpine packages (important for sqlite fix)
RUN apk update && apk upgrade
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY app.py .
CMD ["flask", "run", "--host=0.0.0.0"]
