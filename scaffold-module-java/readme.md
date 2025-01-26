# Java Project Creator

## Features

- **Creates a new Java project with a modular structure**
- **Generates a `module-info.java` file** with the specified module name
- **Creates a `Main.java` file** with a basic `main` method
- **Generates a `build.sh` script** to compile and run the project
- **Automatically adds an alias to `~/.bashrc` and `~/.zshrc` for first-time setup**
- **Allows default parameters to be set via a configuration file**

## Usage

1. Clone this repository or download the `create-java-project.sh` script.
```
git clone ... && cd scaffold-module-java
```
2. Make the script executable:
   ```bash
   chmod +x scaffold.sh
   ```

3. Run the initialization script to set up aliases for `bash` and `zsh` (first-time setup):
   ```bash
   cd init && create-alias.sh
   ```

   This script will:
   - Add an alias for `scaffold` to both `~/.bashrc` and `~/.zshrc`.
   - Reload the shell configuration to make the alias available immediately.

4. Run the script:
   ```bash
   scaffold -m <module-name> -p <project-name>
   ```
 ***Configuration File***
The configuration file contains the following parameters:
```java
BASE_PACKAGE="com.elitekaycy"
DEFAULT_MODULE="default"
```
  ***You can update these values if you need a different base package or module name for your new projects. Just edit the config file and re-run the create-java-project command to use the updated defaults.***
        
- If default parameters are configured, you can simply run

```bash
scaffold -p <project-name>
```

## Options

- `-m <module-name>`: Specifies the module name (required)
- `-p <project-name>`: Specifies the project name (optional)

## Example

```bash
create-java-project -m com.elitekaycy.myproject -p MyProject
```

This will create a new Java project with the module name `com.elitekaycy.myproject` and project name `MyProject`.

If you want to use default parameters configured in a file, you can simply run:
```bash
scaffold proxy
```

This will create a project based on the predefined defaults (e.g., `com.elitekaycy.proxy.Main.java`).

## Project Structure

The script generates the following directory structure:
```
MyProject/
├── src/
│   ├── main/
│   │   └── java/
│   │       ├── module-info.java
│   │       └── Main.java
├── build.sh
```

## Notes

- The script assumes that you have Java and the `javac` compiler installed on your system.
- The script generates a basic `module-info.java` file and `Main.java` file. You will need to modify these files to suit your specific needs.
- Use the `init.sh` script to set up the alias for the first time.


