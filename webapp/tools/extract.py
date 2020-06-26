# pip install PyMySQL
import pathlib
import sys

import pymysql.cursors

conn = pymysql.connect(
    host='localhost',
    port=3306,
    user='root',
    password='root',
    db='isubata'
)

d = pathlib.Path('/tmp/icon')
d.mkdir(parents=True, exist_ok=True)


def main(args):
    with conn.cursor() as cur:
        cur.execute('SELECT DISTINCT name, data from image')
        for name, data in cur.fetchall():
            print(name)
            with open(d / name, 'wb') as f:
                f.write(data)
            break


if __name__ == '__main__':
    main(sys.argv)
