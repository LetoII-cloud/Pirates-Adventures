class_name FileReader extends Node

func read_file (path : String) -> String:
	var file_as_text : String = FileAccess.open(path, FileAccess.READ).get_as_text()
	return file_as_text
	
	
