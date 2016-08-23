#/bin/bash
# This script generates a random password for new users

un=$1 	# Run as "./random_pw_generator.sh username" where username is the new username to create

genpasswd() {	# function which generates standard random password
    local l=$1
    [ "$1" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

genrichpasswd() { 
    local l=$1
    [ "$1" == "" ] && l=16
    # rich password with special char ...
    # rules:
		# want at least one number
		# want at least one lower
		# want at least one upper
    tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' < /dev/urandom| fold -w ${1} | \
    grep -P '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:<>?=])' | head -n 1
}

pass=$(genpasswd 8)	# Eight characters long (optionally use genrichpasswd func for stronger pw)
encrypt_pass=$(openssl passwd -crypt ${pass})	# Encrypt it.
useradd -m -s /bin/bash -g analytics -p ${encrypt_pass} ${un}	# Create the user with the password
echo ${un} ${pass} >> userlist.txt	# Append to userlist.txt
echo ${un} ${pass}
chmod og-rwx userlist.txt	# Make sure no can see your file of accounts and passwords