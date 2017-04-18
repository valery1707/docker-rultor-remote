#!/bin/sh

SCRIPT_DIR=$(dirname $(cd ${0%/*} && echo $PWD/${0##*/}))
D_NAME=rultor-remote

project=
file_list=
while [ "$#" -gt 0 ]
do
	case "$1" in
		('-p')
			shift
			project="$1"
		;;
		*)
			file_list="${file_list} $1"
			if [ -f "${PWD}/$1.asc" ] ; then
				rm -v ${PWD}/$1.asc
			fi
		;;
	esac
	shift
done

if [ "${project}" = "" ] ; then
	echo "Required parameter '-p' for project name."
	exit 1
fi

sudo docker build --tag ${D_NAME} ${SCRIPT_DIR}

for file in ${file_list}
do
	sudo docker run --rm -v "${PWD}":/work ${D_NAME} bash -c "rultor encrypt -p ${project} /work/${file} > /dev/null 2>&1"
	sudo chown ${USER}:${USER} "${PWD}/${file}.asc"
	echo "${file} encrypted into ${file}.asc"
done
