@echo off
title Iniciar Django - my_tennis_club
if exist .venv\Scripts\activate.bat call .venv\Scripts\activate.bat
start "" "http://localhost:8000/members"
python manage.py runserver 0.0.0.0:8000
pause
