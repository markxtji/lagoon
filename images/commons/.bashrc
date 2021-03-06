#!/bin/sh

# Make sure that new files generated by Docker have group write permission
source /lagoon/entrypoints/00-umask.sh

# Loading environment variables from .env and friends
source /lagoon/entrypoints/50-dotenv.sh

# a nicer prompt
if [ "$PS1" ]; then
  NORMAL="\[\e[0m\]"
  RED="\[\e[1;31m\]"
  GREEN="\[\e[0;32m\]"
  YELLOW="\[\e[1;33m\]"
  BLUE="\[\e[1;34m\]"
  WHITE="\[\e[1;37m\]"
  PS1="${YELLOW}\w${NORMAL}$ "
  if [ "$LAGOON" ]; then
    PS1="${GREEN}$LAGOON${NORMAL}:$PS1"
  fi
  if [ "$LAGOON_GIT_BRANCH" ]; then
    # production environments get a red color
    if [ "$LAGOON_ENVIRONMENT_TYPE" == "production" ]; then
      PS1="${RED}$LAGOON_GIT_BRANCH${NORMAL}@$PS1"
    else
      PS1="${BLUE}$LAGOON_GIT_BRANCH${NORMAL}@$PS1"
    fi
  fi
  if [ "$LAGOON_PROJECT" ]; then
    PS1="[${WHITE}$LAGOON_PROJECT${NORMAL}]$PS1"
  fi
fi
