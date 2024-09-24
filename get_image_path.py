import logging
import os


def list_files_in_directory(directory):
    file_paths = []  # This list will store all file paths

    for root, _, all_files in os.walk(directory):
        for i, each in enumerate(all_files):
            file_path = os.path.join(root, each)
            file_paths.append(file_path)
            if i > 10:
                return file_paths
    return file_paths


if __name__ == '__main__':
    logging.info(f'In the output folder, there are {list_files_in_directory("images")} images')
