@echo off
title Run server - club_project
call .venv\Scripts\activate.bat
python manage.py runserver
pause
