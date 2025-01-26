#!/bin/bash

# Default configuration
SCRIPT_DIR="$(dirname "$(realpath "$0")")"  # Get the script's directory
CONFIG_FILE="$SCRIPT_DIR/config"
BASE_PACKAGE="com.example"
DEFAULT_MODULE="default"

# Load defaults from config file if it exists
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
  echo "Loaded configuration from $CONFIG_FILE."
else
  echo "No configuration file found. Using default values."
fi

# Check if project name is provided as the second parameter
if [ -z "$PROJECT_NAME" ]; then
  # Prompt for project name (proxy part) if not provided
  read -p "Enter project package: " PROJECT_NAME
fi

# Set full module name
MODULE_NAME="$BASE_PACKAGE.$PROJECT_NAME"

# Parse command-line arguments (override defaults)
while getopts ":m:p:" opt; do
  case $opt in
    m) MODULE_NAME="$OPTARG";;
    p) PROJECT_NAME="$OPTARG";;
    \?) echo "Invalid option: -$OPTARG"; exit 1;;
  esac
done

# Create project structure
mkdir -p "$PROJECT_NAME/src/main/java"
cat > "$PROJECT_NAME/src/main/java/module-info.java" <<EOF
module $MODULE_NAME {
    exports $MODULE_NAME;
}
EOF

# Generate Main.java with the correct package and module
mkdir -p "$PROJECT_NAME/src/main/java/$(echo $MODULE_NAME | tr '.' '/')"
cat > "$PROJECT_NAME/src/main/java/$(echo $MODULE_NAME | tr '.' '/')/Main.java" <<EOF
package $MODULE_NAME;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from $MODULE_NAME!");
    }
}
EOF

# Generate build script
cat > "$PROJECT_NAME/build.sh" <<EOF
#!/bin/bash

# Clean up any previous build output
rm -rf out
mkdir -p out

# Compile the module
javac -d out \\
    --module-source-path $MODULE_NAME=src/main/java \\
    \$(find src/main/java -name "*.java")

# Check if the compilation was successful
if [ \$? -eq 0 ]; then
    echo "Compilation successful. Running the module..."
    # Run the compiled module
    java --module-path out -m $MODULE_NAME/$MODULE_NAME.Main
else
    echo "Compilation failed!"
    exit 1
fi

rm -rf out
EOF
chmod +x "$PROJECT_NAME/build.sh"

# Generate README.md with basic information
cat > "$PROJECT_NAME/README.md" <<EOF
# $PROJECT_NAME

This is a simple Java project scaffold created using the $MODULE_NAME module.

## Project Structure

- **src/main/java**: Contains the module's source code.
  - **module-info.java**: Module descriptor for the project.
  - **Main.java**: Entry point of the project.

## Build and Run

To build and run the project:

1. Navigate to the project directory.
2. Execute the following command to build and run:

   \`\`\`bash
   ./build.sh
   \`\`\`

This will compile the project and run the Main class.

## Default Configuration

- **BASE_PACKAGE**: "$BASE_PACKAGE"
- **DEFAULT_MODULE**: "$DEFAULT_MODULE"
EOF

# Output message
echo "Project $PROJECT_NAME created with module $MODULE_NAME."
echo "README.md and build script generated. Run './build.sh' to build and run the project."

