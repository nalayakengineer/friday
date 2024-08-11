# Friday.sh

`friday.sh` is a shell script designed to quickly initialize a new React project using Vite, TypeScript, SWC, and Panda CSS. The script also allows you to choose your preferred package manager and automatically installs additional dependencies like Axios and React Router DOM.

## Features

- Initializes a new React project using Vite with TypeScript and SWC.
- Installs Panda CSS and updates the `index.css` file to import Panda's base CSS.
- Installs additional dependencies: Axios and React Router DOM.
- Allows you to specify the project directory and package manager.
- Checks if the specified package manager is installed on your system.
- Provides timestamped logs for each operation.

## Prerequisites

Ensure you have one of the following package managers installed on your system:

- `pnpm`
- `npm`
- `yarn`

## Usage

```bash
./friday.sh -d <directory> [-p <package-manager>] [-h]
## Options
    • -d <directory>: (Required) The directory where the React project will be created.
	•	-p <package-manager>: (Optional) The package manager to use (pnpm, npm, yarn). Defaults to pnpm.
	•	-h: (Optional) Print the help message and exit.
```