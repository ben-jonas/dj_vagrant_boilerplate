import json, os

base_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
auth_file = open(os.path.join(base_dir, 'auth', 'db_credentials.json'))
sql_path = os.path.join((os.path.dirname(os.path.realpath(__file__))), 'db_init.sql')
obj = json.load(auth_file)
os.environ['SQL_FILE_PATH'] = sql_path;
os.environ['PROJECT'] = obj['project'];
os.environ['USR'] = obj['usr'];
os.environ['PASS'] = obj['pass'];

print("Creating project DB and user/password")
os.system("sudo -u postgres psql -f $SQL_FILE_PATH -v project=$PROJECT -v usr=$USR -v pass=$PASS")