FROM python:3.9-slim

RUN groupadd --system app && useradd --system --gid app app

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY service ./service
RUN chown -R app:app /app

ENV PORT=8080
EXPOSE 8080

USER app

CMD ["gunicorn", "--workers=1", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
