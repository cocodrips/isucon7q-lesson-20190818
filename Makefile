deploy: clean
	sudo cp -f configs/nginx.conf /etc/nginx/sites-available/nginx.conf
	sudo cp -f configs/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
	sudo systemctl restart mysql.service
	sudo systemctl restart nginx.service
	sudo systemctl restart isubata.golang.service

clean:
	echo "" > /var/log/nginx/access.log
	echo "" > /var/log/nginx/error.log
	echo "" > /var/log/mysql/error.log
	echo "" > /var/log/mysql/slow.log

alp:
	# TODO -> tsuka
	cat /var/log/nginx/access.log | grep -v '/js' | grep -v '/css' | grep -v '/fonts' | alp --cnt -r --aggregates='/icons/.*','/profile/.*','/channel/\d+'
