#!/bin/bash

./entry_commands.sh
exit_status=$?
if [[ $exit_status -ne 0 ]]; then
	echo "Exit status = $exit_status ... running bash to for debugging ..."
	bash
	exit
fi
echo "Running: $@ [with -I option"]
exec "$@"

