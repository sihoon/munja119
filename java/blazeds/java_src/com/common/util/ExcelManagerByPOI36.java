package com.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelManagerByPOI36 {
	
	String sheetName = null;
	int maxCountColumn = 0;
	int limitColumn = 0;
	int limitRow = 0;
	boolean bLimitRow = false;
	int lastRow = 0;
	int sheetNum = 0;
	boolean bLimitColumn = false;
	
	public ExcelManagerByPOI36() {
		
		sheetName = null;
		maxCountColumn = 0;
		limitColumn = 50;
		limitRow = 5000000;
	}
	
	public void setSheetName(String str){ this.sheetName = str; }
	public void setlimitColumn(int i){ this.limitColumn = i; }
	public void setlimitRow(int i){ this.limitRow = i; }
	public String getSheetName(){ return this.sheetName; }
	public int getlimitColumn(){ return this.limitColumn; }
	public int getlimitRow(){ return this.limitRow; }
	public boolean getbLimitColumn() { return this.bLimitColumn; }
	public boolean getbLimitRow() { return this.bLimitRow; }
	
	public int getmaxCountColumn(){ return this.maxCountColumn;}
	
	public String[][] Read(String filePath) {
		
		InputStream fin = null;
		Workbook workbook =  null;
		try {
			fin = new FileInputStream(filePath);
			workbook = WorkbookFactory.create(fin);
		}catch(IOException ie) {
			System.out.println(ie);
		}catch(InvalidFormatException ins) {
			System.out.println(ins);
		}catch(Exception e) {
			System.out.println(e);
		}

		
		Sheet sheet = null;
		int countColumn = 0; 
		
		
		if (sheetName == null) sheet = workbook.getSheetAt(0);
		else sheet = workbook.getSheet(sheetName);
		
		lastRow = sheet.getLastRowNum();
		
		if (lastRow > limitRow) { lastRow = limitRow-1; bLimitRow = true; }
		
		
		String[][] result = new String[lastRow+1][];
		
		int countReadColumn = 0;
		DecimalFormat df = new DecimalFormat("#");

		for (int i = 0; i <= lastRow; i++) {
			
			countReadColumn = 0;
			Row row = sheet.getRow(i);

			if(row == null) {				
				result[i] = new String[0];
				continue;
			}
			countColumn = row.getLastCellNum();
			if(countColumn < 0) countColumn = 0;
			if (countColumn > limitColumn) { countColumn = limitColumn-1; bLimitColumn = true;}
			result[i] = new String[countColumn];
			
			//for (int j = row.getFirstCellNum(); j < countColumn; j++) {
			for (int j = 0 ; j < countColumn; j++) {
				countReadColumn++;
				
				
				Cell cell = row.getCell(j);

				if (cell == null)
					continue;

				int cellType = cell.getCellType();
				
				// cell Ÿ�Կ� �� ���� ��½�Ų��
				switch (cellType) {
					case Cell.CELL_TYPE_NUMERIC:		// 0
						double d = cell.getNumericCellValue();
						// ����Ʈ Ÿ�Կ��θ� üũ�Ѵ�.
						if (DateUtil.isCellDateFormatted(cell)) {
							// format in form of YYYYMMDD
							SimpleDateFormat formatter =
								new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
							String cellText = formatter.format(DateUtil.getJavaDate(d));
							result[i][j] = cellText;
						} else {
							result[i][j] = df.format(d);
						}
						
						break;
					case Cell.CELL_TYPE_STRING:			// 1
						result[i][j] = cell.getRichStringCellValue().getString();
						break;
					case Cell.CELL_TYPE_FORMULA:		// 2
						result[i][j] = cell.getCellFormula();
						break;
					case Cell.CELL_TYPE_BLANK:			// 3
							result[i][j] = "";
						break;
					case Cell.CELL_TYPE_BOOLEAN:		// 4
						result[i][j] = String.valueOf(cell.getBooleanCellValue());
						break;
					case Cell.CELL_TYPE_ERROR:			// 5
						result[i][j] = String.valueOf(cell.getErrorCellValue());
						break;
					default:
						result[i][j] = "";
						break;
				}
			}
			if (countColumn > this.maxCountColumn) this.maxCountColumn = countReadColumn;
		}
		return result;

	}

	public Map<String,Object> ReadMultiSheet(String filePath) {
		
		InputStream fin = null;
		Workbook workbook =  null;
		try {
			fin = new FileInputStream(filePath);
			workbook = WorkbookFactory.create(fin);
		}catch(IOException ie) {
			System.out.println(ie);
		}catch(InvalidFormatException ins) {
			System.out.println(ins);
		}catch(Exception e) {
			System.out.println(e);
		}

		
		Sheet sheet = null;
		int countColumn = 0; 
		Map<String,Object> arrMap = new HashMap<String,Object>();

		//시트갯수 읽어옴
		sheetNum = workbook.getNumberOfSheets();
		
		if(sheetNum > 0){
			for(int k=0; k<sheetNum; k++){

				if (sheetName == null) sheet = workbook.getSheetAt(k);
				else sheet = workbook.getSheet(sheetName);
				
				lastRow = sheet.getLastRowNum();
				
				System.out.println("sheet"+k+".lastRow::"+lastRow);
				
				//최대 5000000건까지만 읽도록 설정
				if (lastRow > limitRow) { lastRow = limitRow-1; bLimitRow = true; }
				
				String[][] result = new String[lastRow+1][];
				
				int countReadColumn = 0;
				DecimalFormat df = new DecimalFormat("#");

				for (int i = 0; i <= lastRow; i++) {
					
					countReadColumn = 0;
					Row row = sheet.getRow(i);

					if(row == null) {				
						result[i] = new String[0];
						continue;
					}
					countColumn = row.getLastCellNum();
					if(countColumn < 0) countColumn = 0;
					if (countColumn > limitColumn) { countColumn = limitColumn-1; bLimitColumn = true;}
					result[i] = new String[countColumn];
					
					//for (int j = row.getFirstCellNum(); j < countColumn; j++) {
					for (int j = 0 ; j < countColumn; j++) {
						countReadColumn++;
						
						
						Cell cell = row.getCell(j);

						if (cell == null)
							continue;

						int cellType = cell.getCellType();
						
						// cell
						switch (cellType) {
							case Cell.CELL_TYPE_NUMERIC:		// 0
								double d = cell.getNumericCellValue();
								// 
								if (DateUtil.isCellDateFormatted(cell)) {
									// format in form of YYYYMMDD
									SimpleDateFormat formatter =
										new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
									String cellText = formatter.format(DateUtil.getJavaDate(d));
									result[i][j] = cellText;

								} else {
									result[i][j] = df.format(d);
								}
								
								break;
							case Cell.CELL_TYPE_STRING:			// 1
								result[i][j] = cell.getRichStringCellValue().getString();
								break;
							case Cell.CELL_TYPE_FORMULA:		// 2
								result[i][j] = cell.getCellFormula();
								break;
							case Cell.CELL_TYPE_BLANK:			// 3
									result[i][j] = "";
								break;
							case Cell.CELL_TYPE_BOOLEAN:		// 4
								result[i][j] = String.valueOf(cell.getBooleanCellValue());
								break;
							case Cell.CELL_TYPE_ERROR:			// 5
								result[i][j] = String.valueOf(cell.getErrorCellValue());
								break;
							default:
								result[i][j] = "";
								break;
						}
						System.out.println("result["+i+"]["+j+"]::"+result[i][j].toString());
					}
					if (countColumn > this.maxCountColumn) this.maxCountColumn = countReadColumn;
					arrMap.put("arrMap"+k, result);
				}
			}
		}
		
		return arrMap;
	}
	
}
