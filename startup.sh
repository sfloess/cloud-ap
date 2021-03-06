#!/bin/bash

#rm -f /lib/modules/`uname -r`
#ln -s /lib/modules/* /lib/modules/`uname -r`

depmod
#modprobe fuse

chmod -R 700 /root/.ssh
chmod 777 /run/screen

chmod u+s /usr/bin/sudo
chmod g+s /usr/bin/sudo

#ntpdate pool.ntp.org
#ntpdate admin-ap

/usr/sbin/ntpdate-debian

chmod 700 -R /etc/ssh /var/run/sshd

/etc/init.d/rsyslog    start
/etc/init.d/ntp        start
/etc/init.d/cron       start
/etc/init.d/rpcbind    start
/etc/init.d/postfix    start
/etc/init.d/nis        start
/etc/init.d/ssh        start
/etc/init.d/rsync      start
/etc/init.d/mysql      start
/etc/init.d/postgresql start

# Start mega cmd server
/usr/local/bin/mega-whoami

mkdir -p /mnt/admin-ap/home/mnt/admin-ap/home/root /sfloess /mnt/admin-ap/etc /mnt/admin-ap/opt/flossware /mnt/admin-ap/backups /mnt/admin-ap/media /mnt/admin-ap/nas /mnt/admin-ap/shared /mnt/admin-ap/root

echo "Mount user dirs..."

for aMount in /mnt/admin-ap/root/.samba/*.smb
do
	userName=`basename ${aMount} .smb`
	mkdir -p /mnt/admin-ap/home/${userName}

	echo "    Mounting ${userName} -> ${aMount}"

	mount -t cifs //admin-ap/sfloess /mnt/admin-ap/home/${userName} -o "credentials=${aMount}"
done

#sshfs -o allow_other,default_permissions,nonempty,reconnect sfloess@admin-ap:/home/sfloess /mnt/admin-ap/home/sfloess
#sshfs -o allow_other,default_permissions,nonempty,reconnect root@admin-ap:/etc             /mnt/admin-ap/etc
#sshfs -o allow_other,default_permissions,nonempty,reconnect root@admin-ap:/root            /mnt/admin-ap/root

#sshfs -o allow_other,default_permissions,reconnect          root@admin-ap:/opt/backups     /mnt/admin-ap/backups
#sshfs -o allow_other,default_permissions,reconnect          root@admin-ap:/opt/media       /mnt/admin-ap/media
#sshfs -o allow_other,default_permissions,reconnect          root@admin-ap:/opt/nas         /mnt/admin-ap/nas
#sshfs -o allow_other,default_permissions,reconnect          root@admin-ap:/opt/shared      /mnt/admin-ap/shared

#sshfs -s -o allow_other,default_permissions,nonempty,reconnect sfloess@admin-ap:/home/sfloess /mnt/admin-ap/home/sfloess
#sshfs -s -o allow_other,default_permissions,nonempty,reconnect root@admin-ap:/root            /mnt/admin-ap/root

#sshfs -s -o allow_other,default_permissions,nonempty root@admin-ap:/etc             /mnt/admin-ap/etc
#sshfs -s -o allow_other,default_permissions,nonempty root@admin-ap:/flossware       /mnt/admin-ap/flossware
#sshfs -s -o allow_other,default_permissions          root@admin-ap:/opt/backups     /mnt/admin-ap/backups
#sshfs -s -o allow_other,default_permissions          root@admin-ap:/opt/media       /mnt/admin-ap/media
#sshfs -s -o allow_other,default_permissions          root@admin-ap:/opt/nas         /mnt/admin-ap/nas
#sshfs -s -o allow_other,default_permissions          root@admin-ap:/opt/shared      /mnt/admin-ap/shared

#mount -o bind /mnt/admin-ap/root /root

mount -a

