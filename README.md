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
 -d <directory>: (Required) The directory where the React project will be created.
 -p <package-manager>: (Optional) The package manager to use (pnpm, npm, yarn). Defaults to pnpm.
 -h (Optional) Print the help message and exit.
```

## Examples
1.	Initialize a React project in a specified directory using the default package manager (pnpm):	
```bash
./friday.sh -d /path/to/project-directory
```

2. Initialize a React project with a specific package manager (e.g., npm):
```bash
./friday.sh -d /path/to/project-directory -p npm
```

3. Display the help message:
```bash
./friday.sh -h
```

## Script Workflow
1. **Directory Check**: Ensures the target directory is specified and created if it doesn’t exist.
2.	**Package Manager Verification**: Checks if the specified package manager is installed on your system.
3.	**Project Initialization**: Uses Vite to create a new React project with TypeScript and SWC.
4.	**Dependency Installation**: Installs Panda CSS, Axios, and React Router DOM.
5.	**Panda CSS Configuration**: Initializes Panda CSS and updates the index.css file to import Panda’s base CSS.
6.	**Completion**: Logs a success message indicating the project setup is complete.

## Logging
Each operation performed by the script is logged with a timestamp, making it easy to track the progress of the setup process.

## Contributing
If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## Contact Me:
Get in touch today. Let’s talk; if you want to collaborate or an idea you may have 
contact@bharatbhushan.me ✉️ 