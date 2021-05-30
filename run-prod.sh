uwsgi --socket 0.0.0.0:5000 --protocol=http --pyarg="--host 0.0.0.0 --port 5000 --engine ./yolo5s.engine --plugins ./libmyplugins.so" -w app:app 
