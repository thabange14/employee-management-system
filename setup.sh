set -e

sudo service mysql start || true

for file in 01_schema 02_seed 04_views 05_triggers 06_procedures; do
    echo "Running $file.sql ..."
    sudo mysql < sql/$file.sql
done

echo "Database ready."