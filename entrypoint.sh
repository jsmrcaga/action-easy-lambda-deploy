#!/bin/bash
FUNCTION_NAME=$INPUT_FUNCTION_NAME
REGION=$INPUT_REGION
ZIP_COMMAND=$INPUT_ZIP_COMMAND
ZIP_FILES=$INPUT_ZIP_FILES

ZIP_FILENAME="easy-lambda-deploy.zip"
BASIC_ZIP="zip -r $ZIP_FILENAME"

# Choose zip command to run
if [[ -n $ZIP_COMMAND ]]
then
	echo "Running provided ZIP command: \"$ZIP_COMMAND\""
	eval $ZIP_COMMAND
else
	if [[ -n $ZIP_FILES ]]
	then
		FILES_COMMAND="$BASIC_ZIP $ZIP_FILES"
		echo "Running ZIP with custom files: \"$FILES_COMMAND\""
		eval $FILES_COMMAND
	else
		echo "Running ZIP with all files: \"$BASIC_ZIP *\""
		eval "$BASIC_ZIP *"
	fi
fi

# Update lambda
echo "Updating lambda code"
aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file "fileb://$ZIP_FILENAME" --region $REGION
