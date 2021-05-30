from app import app, args

if __name__ == '__main__':
	app.run(host=args.host, port=args.port)
