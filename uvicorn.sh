#!/bin/sh

exec uvicorn --host 0.0.0.0 --port 8000 --workers 1 main:app