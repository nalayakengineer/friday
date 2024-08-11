#!/bin/zsh

#Setup the default values
CHOICE=0
CONFIRM="y"
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
FOLDER_NAME=""
BASE_DIR=""
PACKAGE_MANAGER="pnpm"


# Functions to print error, info and warning messages
EchoError() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${RED}${TIMESTAMP} ERROR: ${NC} $1"
}

EchoInfo() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${BLUE}${TIMESTAMP} INFO: ${NC} $1"
}

EchoWarning() {
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${YELLOW}${TIMESTAMP} WARN: ${NC} $1"
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

EchoInfo "Creating a new React project in $BASE_DIR using $PACKAGE_MANAGER package manager."
