deploy: clean
	sudo cp -f configs/nginx.conf /etc/nginx/sites-available/nginx.conf
	sudo cp -f configs/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
	sudo systemctl restart mysql.service
	sudo systemctl restart nginx.service
	cd webapp/go && make build
	sudo systemctl restart isubata.golang.service

clean:
	echo "" > /var/log/nginx/access.log
	echo "" > /var/log/nginx/error.log
	echo "" > /var/log/mysql/error.log
	echo "" > /var/log/mysql/slow.log

summary:
	# TODO -> tsuka
	echo "-------------------------------------------" > "summary.txt"
	echo "alp" >> "summary.txt"
	echo "-------------------------------------------" >> "summary.txt"
	cat /var/log/nginx/access.log | grep -v '/js' | grep -v '/css' | grep -v '/fonts' | alp --cnt -r --aggregates='/icons/.*','/profile/.*','/channel/\d+' >> "summary.txt"

	echo "-------------------------------------------" >> "summary.txt"
	echo "mysql" >> "summary.txt"
	echo "-------------------------------------------" >> "summary.txt"
	pt-query-digest --explain 127.0.0.1 -P 3306 -uisucon -pisucon /var/log/mysql/slow.log >> "summary.txt"
