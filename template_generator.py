import os
import shutil

def main():
    print("Welcome to the Template Generator!")

    # Save the starting directory
    starting_dir = os.getcwd()

    # Define the generic template directory
    generic_template_dir = os.path.join(starting_dir, "generic_template")

    if not os.path.exists(generic_template_dir):
        print(f"Error: Generic template directory '{generic_template_dir}' does not exist.")
        return

    # Step 1: List available template types
    available_templates = [d for d in os.listdir(generic_template_dir) if os.path.isdir(os.path.join(generic_template_dir, d))]
    if not available_templates:
        print(f"Error: No templates found in '{generic_template_dir}'.")
        return

    print("Available template types:")
    for template in available_templates:
        print(f"- {template}")

    # Step 2: Ask for template type
    template_type = input("What type of template would you like to create? ")
    if template_type not in available_templates:
        print(f"Error: Template type '{template_type}' does not exist in '{generic_template_dir}'.")
        return

    # Step 3: Ask for project name
    project_name = input("Enter the name of your project: ")

    # Step 4: Ask for destination directory
    destination_dir = input("Enter the destination directory: ")

    # Validate destination directory
    if not os.path.exists(destination_dir):
        print(f"The directory '{destination_dir}' does not exist. Creating it now...")
        os.makedirs(destination_dir)

    # Step 5: Copy the selected template type to the destination
    template_dir = os.path.join(generic_template_dir, template_type)
    project_dir = os.path.join(destination_dir, project_name)
    shutil.copytree(template_dir, project_dir)

    # Step 6: Replace placeholders in the copied files
    for root, _, files in os.walk(project_dir):
        for file in files:
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as f:
                content = f.read()

            # Replace placeholder with project name
            content = content.replace("{{PROJECT_NAME}}", project_name)

            with open(file_path, 'w') as f:
                f.write(content)

    # Step 7: Notify the user
    print(f"Template '{template_type}' has been successfully created at '{project_dir}'.")

    # Return to the starting directory
    os.chdir(starting_dir)

if __name__ == "__main__":
    main()