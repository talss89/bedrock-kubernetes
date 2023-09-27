#!/bin/bash
set +e  # Continue on errors

# Ensure file permissions
chown -R www-data:www-data .

export COMPOSER_ALLOW_SUPERUSER=1
if [ -f "composer.json" ]; then
   echo "Installing PHP dependencies"
   composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist
fi

export NODE_ENV=development
if [ -f "yarn.lock" ]; then
   echo "Installing Yarn Dependencies"
   yarn
else 
   if [ -f "package.json" ]; then
      echo "Installing NPM Dependencies"
      npm install
   fi
fi

COLOR_BLUE="\033[0;94m"
COLOR_GREEN="\033[0;92m"
COLOR_RESET="\033[0m"

# Print useful output for user
echo -e "${COLOR_BLUE}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓             ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
                      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                     
                     ▓▓▓▓▓▓                              ▓▓▓▓▓▓▓▓▓▓                       ▓▓▓▓                                  ▓▓▓▓       
           ▓▓▓▓▓▓▓▓▓▓▓                                   ▓▓▓▓▓▓▓▓▓▓▓▓                     ▓▓▓▓                                  ▓▓▓▓       
 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                   ▓▓▓▓    ▓▓▓▓     ▓▓▓         ▓▓▓ ▓▓▓▓              ▓▓▓         ▓▓▓     ▓▓▓▓       
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓              ▓▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓  ▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              ▓▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓  ▓▓▓▓ ▓▓▓▓▓  ▓▓▓▓▓ ▓▓▓▓▓    ▓▓▓▓   ▓▓▓▓ ▓▓▓▓   ▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓ 
▓▓▓▓▓▓▓▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              ▓▓▓▓    ▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓    ▓▓▓▓ ▓▓▓▓     ▓▓▓▓   ▓▓▓▓ ▓▓▓▓        ▓▓▓▓▓▓▓▓   
                      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              ▓▓▓▓     ▓▓▓  ▓▓▓▓       ▓▓▓▓    ▓▓▓▓ ▓▓▓▓     ▓▓▓▓   ▓▓▓▓ ▓▓▓▓   ▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓ 
                      ▓▓▓▓▓▓▓▓▓▓▓                        ▓▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓  ▓▓▓▓▓
                ▓▓▓▓▓▓                                   ▓▓▓▓▓▓▓▓▓▓      ▓▓▓▓▓▓      ▓▓▓▓▓▓▓▓   ▓▓▓        ▓▓▓▓▓       ▓▓▓▓▓▓    ▓▓▓    ▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                                     
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓             ▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                                                                ${COLOR_RESET}


${COLOR_GREEN}Welcome to your development container!${COLOR_RESET}

This is how you can work with it:
- Files will be synchronized between your local machine and this container
- Visual Studio Code has been started, and will allow you to work inside the development container
- An ingress has been created for you at ${COLOR_GREEN}${WP_HOME}${COLOR_RESET}, but you may need to set up a host record.
"

# # Open shell
bash
