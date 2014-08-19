#jprjr/mailadmin

This is just an image with a small script
for administering users with my jprjr/ubuntu-dovecot image.

**This is still experimental, please do not use in production**

You need to either use `--link` to connect to a MySQL server,
or provide a `MYSQL_HOST` environment variable.

You'll also need the `DOVECOT_SQL_USER` and `DOVECOT_SQL_PASS`
variables you used when setting up the dovecot image.

Alternatively, these variables can ve placed in a file
named `/private/vars.sh`.

You can only login with public keys. Place a file at
`/private/ssh/authorized_keys`, then you can login
as the `mailadmin` user.

Alternatively, you can define an environment variable named
`AUTHORIZED_KEYS_URL` - at startup this will be downloaded
and placed at `/home/mailadmin/.ssh/authorized_keys`
