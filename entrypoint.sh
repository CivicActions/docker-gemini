#!/bin/bash -e

# To avoid file permission conflicts change the "node" user to the UID/GID of
# the owner of the working directory and run the command as the "node" user.
GID=$(stat -c '%g' .)
GROUP_NAME=$(stat -c '%G' .)

# Create group if doesn't exist yet.
if ! grep -q ":${GID}:" /etc/group ; then
  groupadd -g $GID $GROUP_NAME
fi;

usermod -o -u $(stat -c '%u' .) -g $GID -s /bin/bash -d /home/node/app node

# To ensure the node path is maintained and quoting arbitrary strings,
# run the user command via a temporary script.
echo "#!/bin/bash -e" > /tmp/user-entrypoint.sh
echo "PATH=${PATH}" >> /tmp/user-entrypoint.sh
echo "$@" >> /tmp/user-entrypoint.sh
chmod a+x /tmp/user-entrypoint.sh
su -c"/tmp/user-entrypoint.sh" node
