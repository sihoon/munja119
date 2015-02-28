package com.common.util;

import com.m.common.FileUtils;

public class FileLoader {

	public String uploadFile(byte[] bytes, String path, String fileName) throws Exception  {
		

		FileUtils fu = new FileUtils();
		return fu.doUploadRename(bytes, path, fileName);
	}

}
