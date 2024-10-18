# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/dev/learn/nestjs-course/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "nestjs-course"; then

  new_window "DB"
  run_cmd " cd db && docker-compose up"  # Change to the db directory and run docker-compose
  split_v 70
  run_cmd " cd db && sleep 5 && mysql --defaults-file=./my.cnf"  # Change to the db directory and run docker-compose

  # Create a new window inline within session layout definition.
  new_window "E"

  # Create a new window inline within session layout definition.
  new_window "API"
  run_cmd " cd api && nv"

  # Create a new window inline within session layout definition.
#
#  # Select the default active window on session creation.
  select_window 2

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
