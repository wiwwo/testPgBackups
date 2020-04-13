Shell script to test if postgresql backup file is "OK for restore".

POC, if can be billion of times better etc, but it is just to show how cool postgresql is, and how magic `pg_virtualenv` is.

What it basically does is: given a backup file, it file is copyed to `/tmp` directory and fed to `pg_virtualenv`.<br>
A disposable virtual environment (sorf of `virtualenv` in python) with a complete -but again, disposable- postgresql database is created.<br>
File is imported via standard `psql`, without affecting any "production" databases or environment. `standard error` is redirected to a log file; the existence of this file implies that "something went wrong".<br>
Nothing is displayed in case of success, so this script can be ran in `crontab`, and if a mail is fired it means something went wrong.

Enjoy!
