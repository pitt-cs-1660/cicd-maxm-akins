# stage 1, builder
FROM python:3.11-buster AS builder
WORKDIR /app
COPY . .
RUN pip install --upgrade pip && pip install poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# stage 2, app
FROM python:3.11-buster AS app
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 8000
ENV PATH=$PATH:/app/.venv/bin
CMD ["uvicorn", "cc_compose.server:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]










#subject to email if need help: Th!sAssignment2