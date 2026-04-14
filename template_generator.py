import os
import shutil

def main():
    print("Welcome to the Template Generator!")

    # Step 1: Ask for template type
    template_type = input("What type of template would you like to create? ")

    # Step 2: Ask for project name
    project_name = input("Enter the name of your project: ")

    # Step 3: Ask for destination directory
    destination_dir = input("Enter the destination directory: ")

    # Validate destination directory
    if not os.path.exists(destination_dir):
        print(f"The directory '{destination_dir}' does not exist. Creating it now...")
        os.makedirs(destination_dir)

    # Define the generic template directory
    generic_template_dir = os.path.join(os.getcwd(), "generic_template")

    if not os.path.exists(generic_template_dir):
        print(f"Error: Generic template directory '{generic_template_dir}' does not exist.")
        return

    # Step 4: Copy the generic template to the destination
    project_dir = os.path.join(destination_dir, project_name)
    shutil.copytree(generic_template_dir, project_dir)

    # Step 5: Replace placeholders in the copied files
    for root, _, files in os.walk(project_dir):
        for file in files:
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as f:
                content = f.read()

            # Replace placeholder with project name
            content = content.replace("{{PROJECT_NAME}}", project_name)

            with open(file_path, 'w') as f:
                f.write(content)

    # Step 6: Notify the user
    print(f"Template '{template_type}' has been successfully created at '{project_dir}'.")

if __name__ == "__main__":
    main()