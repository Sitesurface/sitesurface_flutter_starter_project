# #!/bin/bash

# # set the path to the root folder as a variable
# root_folder_path="/assets"

# # create an array to store the file names
# declare -a file_names

# # function to convert a string to camel case
# camel_case() {
#     local camel_case_name=""
#     for word in $1
#     do
#         camel_case_name+="${word}"
#     done
#     echo "$camel_case_name"
# }

# # function to process a folder and add its files to the file_names array
# process_folder() {
#     local folder_path=$1
#     # loop through the files in the folder
#     for file in "$folder_path"/*
#     do
#         if [ -d "$file" ]; then
#             # if the file is a folder, recursively process it
#             process_folder "$file"
#         else
#             # get the file name and extension
#             filename=$(basename -- "$file")
#             extension="${filename##*.}"
#             filename="${filename%.*}"

#             # convert the file name to camel case
#             camel_case_name=$(camel_case "$filename")

#             # add the file name to the array
#             file_names+=("$camel_case_name$extension")
#         fi
#     done
# }

# # process the root folder
# process_folder "/assets"

# # generate the Dart class
# echo "class AssetConstants {"
# for i in "${!file_names[@]}"
# do
#     echo "  static const ${file_names[i]} = '"${file_names[i]}"';"
#     echo " "
# done
# echo "}"