package com.m.excel;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.util.ExcelManagerByPOI36;
import com.m.common.FileUtils;


public class ExcelLoader extends ExcelManagerByPOI36  implements ExcelLoaderAble {

	@Override
	public String uploadExcelFile(byte[] bytes, String path, String fileName) throws Exception  {
		

		FileUtils fu = new FileUtils();
		return fu.doUploadRename(bytes, path, fileName);
	}

	@Override
	public List<HashMap<String, String>> getExcelData(String path, String fileName) throws Exception {
		

		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		String[][] rslt = null;
		int countMaxColumn = 0;
		int rowCount = 0;
		int mCount = 0;
		int alsize = 0;
		String mkey = "";
		HashMap<String, String> hm = null;
		
		// 여러개의 시트를 읽기위해 map으로 시트들을 모아서 받아옴
		Map<String,Object> rsltMap = super.ReadMultiSheet(path + fileName);
//		rslt = super.Read(path + fileName);
		mCount = rsltMap.size();
		
		for(int k=0; k<mCount; k++){
			mkey = "arrMap"+k;
			System.out.println(mkey);
			rslt = (String[][]) rsltMap.get(mkey);
			countMaxColumn = super.getmaxCountColumn();
			
			rowCount = rslt.length;
			alsize = al.size();
			
			for (int i = 0; i < rowCount; i++) {
				
				hm = new HashMap<String, String>();
				hm.put("/", Integer.toString( (i+1) + alsize )); //시트 2개 이상인 경우 arrayList에 이미 들어가있는 갯수를 더해서 인덱스 맞춰줌
				for (int j = 0; j < countMaxColumn; j++) {
					
					hm.put( this.getExcelColumnTitle(j+1), ( j >= rslt[i].length  )?"":rslt[i][j] );
				}
				
				al.add(hm);
			}
			
		}
		
		
		return al;
	}
	
	private String getExcelColumnTitle(int index) {
		
		int base = (int)(char)'A';
		int div = (int)(char)'Z' - base +1;		
		StringBuffer buf = new StringBuffer();
		
		if ( (index-1) >= 0 ){
			
			//twoLength String
			if ( index-1 >= div ) {
				
				buf.append( new Character( (char)(base + (int)( (index-1)/div ) -1) ).toString() );
				buf.append( new Character( (char)(base + (int)( (index-1)%div ) ) ).toString() );
			}else {
				buf.append( new Character( (char)(base+index-1) ).toString() );
			}
		}
				
		return buf.toString();
	}

}
