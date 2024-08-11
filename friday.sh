#!/bin/zsh

# Author: Bharat Bhushan
# Date: 2024-08-11
# Version: 1.0
# Description: A script to create a new React project using Vite with TypeScript + SWC


#Setup the default values
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BASE_DIR=""
PACKAGE_MANAGER="pnpm"
PANDA_CONFIG_FILE="panda.config.ts"

# Functions to print error, info and warning messages
EchoError() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "💔${RED}${TIMESTAMP} error: ${NC} $1"
}

EchoInfo() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "❕${BLUE}${TIMESTAMP} info: ${NC} $1"
}

EchoWarning() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "✋🏻${YELLOW}${TIMESTAMP} warn: ${NC} $1"
}


# Function to print usage
usage() {
    echo "Usage: $0 -d <directory> [-p <package-manager>]"
    echo "  -d  Directory where the React project will be created."
    echo "  -p  Package manager to use (npm, yarn, pnpm). Default is pnpm."
    echo "  -h  Display this help and exit."
    exit 1
}

# Parse command-line arguments
while getopts ":d:p:h" opt; do
    case "$opt" in
        d) BASE_DIR="$OPTARG" ;;
        p) PACKAGE_MANAGER="$OPTARG" ;;
        h) usage ;;
        \?) EchoError "Invalid option: -$OPTARG" >&2; usage ;;
        :) EchoError "Option -$OPTARG requires an argument." >&2; usage ;;
    esac
done

# Check if directory is provided
if [ -z "$BASE_DIR" ]; then
    usage
fi

# Ask for the package manager if not provided
if [ -z "$PACKAGE_MANAGER" ]; then
    EchoInfo "Package manager is not provided. Asking for the package manager."
    read -p "Enter package manager (npm, yarn, pnpm) [pnpm]: " package_manager
    PACKAGE_MANAGER=${package_manager:-pnpm}
fi

# Check if the package manager is installed
if ! command -v "$PACKAGE_MANAGER" &> /dev/null; then
    EchoError "Package manager '$PACKAGE_MANAGER' is not installed on this system. Trying to install."
        case "$PACKAGE_MANAGER" in
        pnpm)
            npm install -g pnpm || { log "Failed to install pnpm"; exit 1; }
            ;;
        yarn)
            npm install -g yarn || { log "Failed to install yarn"; exit 1; }
            ;;
        npm)
            log "npm should already be installed. Exiting."
            exit 1
            ;;
        *)
            log "Unknown package manager: $package_manager. Exiting."
            exit 1
            ;;
    esac
    else
    EchoInfo "Package manager '$PACKAGE_MANAGER' is installed."
fi

EchoInfo "Creating a new React project in $BASE_DIR using $PACKAGE_MANAGER package manager."

# Create the directory if it doesn't exist
mkdir -p "$BASE_DIR" || { EchoError "Failed to create directory $BASE_DIR"; exit 1; }

# Navigate to the directory
cd "$BASE_DIR" || { EchoError "Failed to change directory to $BASE_DIR"; exit 1; }

# Initialize the React project using Vite with TypeScript + SWC
if [ "$PACKAGE_MANAGER" = "yarn" ]; then
    $PACKAGE_MANAGER create vite . --template react-swc-ts --no-git || { EchoError "Failed to create React project"; exit 1; }
else
    $PACKAGE_MANAGER create vite@latest . --template react-swc-ts -- --no-git || { EchoError "Failed to create React project"; exit 1; }
fi

# Install dependencies
EchoInfo "Installing dependencies: panda-css (dev), axios, react-router-dom...."
$PACKAGE_MANAGER add axios react-router-dom
$PACKAGE_MANAGER add -D @pandacss/dev
$PACKAGE_MANAGER install

#Initialise Panda CSS
EchoInfo "Initialise Panda CSS..."
if [ "$PACKAGE_MANAGER" = "npm" ]; then
   npx panda init --postcss
else
    $PACKAGE_MANAGER panda init --postcss
fi


#Updating package.json scripts
EchoInfo "Updating package.json scripts..."
jq '.scripts.prepare = "panda codegen"' package.json > tmp.json && mv tmp.json package.json


# Update index.css
EchoInfo "Configuring the entry CSS with layers..."
if [ -f src/index.css ]; then
    echo "@layer reset, base, tokens, recipes, utilities;" | cat - src/index.css > tmpfile && mv tmpfile src/index.css
else
    EchoWarning "src/index.css not found. Skipping index.css update."
fi

EchoInfo "Updating panda.config.ts file..."
#Update panda.config.ts file
if [ -f "$PANDA_CONFIG_FILE" ]; then
    #Add the jsxFramework property to the configuration file
    sed -i '' '/^}/i\   
    jsxFramework: "react",\
    ' "$PANDA_CONFIG_FILE" || { EchoWarning "Failed to update $PANDA_CONFIG_FILE";}
else
    EchoWarning "$PANDA_CONFIG_FILE not found. Skipping configuration update."
fi

EchoInfo "Panda Config Prepare..."
$PACKAGE_MANAGER run prepare

EchoInfo "Project Setup Complete. 🚀"

EchoInfo "Run the following commands to start:\ncd $BASE_DIR\n$PACKAGE_MANAGER run dev"
