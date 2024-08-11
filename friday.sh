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


# Functions to print error, info and warning messages
EchoError() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${RED}${TIMESTAMP} error: ${NC} $1"
}

EchoInfo() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${BLUE}${TIMESTAMP} info: ${NC} $1"
}

EchoWarning() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${YELLOW}${TIMESTAMP} warn: ${NC} $1"
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
    EchoError "Package manager '$PACKAGE_MANAGER' is not installed on this system."
    exit 1
fi

EchoInfo "Creating a new React project in $BASE_DIR using $PACKAGE_MANAGER package manager."

# Create the directory if it doesn't exist
mkdir -p "$BASE_DIR" || { EchoError "Failed to create directory $BASE_DIR"; exit 1; }

# Navigate to the directory
cd "$BASE_DIR" || { EchoError "Failed to change directory to $BASE_DIR"; exit 1; }

# Initialize the React project using Vite with TypeScript + SWC
$PACKAGE_MANAGER create vite@latest . --template react-ts  -- --no-git || { EchoError "Failed to create React project"; exit 1; }

# Install dependencies
EchoInfo "Installing dependencies: panda-css, axios, react-router-dom..."
$PACKAGE_MANAGER install @pandacss/dev axios react-router-dom

EchoInfo "Initialise Panda CSS..."
#Initialise Panda CSS
$PACKAGE_MANAGER panda init --postcss

EchoInfo "Configuring the entry CSS with layers..."
# Update index.css
echo "@layer reset, base, tokens, recipes, utilities;" > src/index.css

EchoInfo "Project Setup Complete. 🚀"

EchoInfo "Run the following commands to start:\n cd $BASE_DIR\n $PACKAGE_MANAGER run dev"
