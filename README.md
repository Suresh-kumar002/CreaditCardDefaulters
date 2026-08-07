# Credit Card Defaulters — Deployment Guide

This repository contains a Flask app for predicting credit card defaulters.

Quick local run

1. Create a Python virtual environment and activate it.

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python main.py
```

Notes about dependencies

- If `pip install -r requirements.txt` fails building `numpy` on Windows, install a compatible binary wheel or use Anaconda/Miniconda.

Deployment options

1) Vercel (serverless) — advanced

- Vercel runs Python as serverless functions. Converting this full Flask app to Vercel requires packaging endpoints under an `api/` function or using an ASGI adapter.
- Recommended approach: deploy a small API wrapper or container instead — see Render/Heroku below if you need an easier path.

Resources:
- Vercel Python functions: https://vercel.com/docs/runtimes#official-runtimes/python

2) Render / Heroku (recommended for Flask)

- Render and Heroku support deploying a long-running Flask app with `gunicorn`.
- Ensure `Procfile` exists (already present). Example `Procfile`:

```
web: gunicorn -w 4 -b 0.0.0.0:$PORT main:app
```

- On Render/Heroku, set the build command to `pip install -r requirements.txt` and the start command to the `Procfile` or `gunicorn` command above.

3) Docker (portable)

Create a `Dockerfile` and push the image to any container platform (AWS, GCR, DockerHub) or deploy to Render.

Example `Dockerfile` (minimal):

```
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5001
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5001", "main:app"]
```

Pushing to GitHub and linking to Vercel

1. Commit and push changes to your GitHub repository.
2. On Vercel, click "Import Project" → choose your GitHub repo.
3. For Python serverless, follow Vercel docs to map `api/` functions. If you prefer a container or full server, use Render/Heroku instead.

What I prepared here

- This README with run and deployment guidance.

Next steps I can take (pick one):
- Convert the Flask app into Vercel serverless functions (`api/`), or
- Add a `Dockerfile` and a small CI workflow and produce a patch you can push to GitHub, or
- Attempt to continue installing dependencies locally (resolve the numpy build error) and fully run the app here.
