First steps
==================

1. Bootstrap app and DB:

	``` 
	export PG_DB_USER=your_pg_user PG_DB_PASSWORD=your_pg_pass S3_KEY='ask_for_it' S3_SECRET_KEY='ask_for_it'
	bundle install
	bundle exec rake db:create
	bundle exec rake db:migrate
	```

2. Ask owner for DB dump
3. psql restore DB dump
4. Go to server start


Rails Server Start
==================

`env PG_DB_USER=your_pg_user PG_DB_PASSWORD=your_pg_pass S3_KEY='ask_for_it' S3_SECRET_KEY='ask_for_it' bundle exec rails s`
