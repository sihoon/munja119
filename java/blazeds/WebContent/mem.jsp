<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.* , com.common.*, com.common.properties.*"%>
	<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>mem 확인</title>
</head>
<body>
<%


				
				 Runtime r = Runtime.getRuntime();
                DecimalFormat format = new DecimalFormat("###,###,###.##");
                
                //JVM이 현재 시스템에 요구 가능한 최대 메모리량, 이 값을 넘으면 OutOfMemory 오류가 발생 합니다.                
                long max = r.maxMemory();
                
                //JVM이 현재 시스템에 얻어 쓴 메모리의 총량
                long total = r.totalMemory();
                
                //JVM이 현재 시스템에 청구하여 사용중인 최대 메모리(total)중에서 사용 가능한 메모리
                long free = r.freeMemory();
                
				out.println("Max:" + format.format(max) + ", Total:" + format.format(total) + ", Free:"+format.format(free));
                System.out.println("Max:" + format.format(max) + ", Total:" + format.format(total) + ", Free:"+format.format(free));

/*
	ReadPropertiesAble rp = ReadProperties.getInstance();
	
	String str = rp.getPropertiesFileValue("filtering.properties","filteringMessage");
	String newStr = new String(str.getBytes("8859_1"), "KSC5601");
	out.println( newStr);
*/
//	out.println(VbyP.getValue("adminPhones"));
	/*
	Connection conn = null;
	conn = VbyP.getDB();
	if (conn != null) {
		out.println("ok");
		conn.close();
	}
	else
		out.println("no");
	
	conn = VbyP.getDB("smsd1");
	if (conn != null) {
		out.println("jdbc/smsd1ok");
		conn.close();
	}
	else
		out.println("jdbc/smsd1no");
	
	conn = VbyP.getDB("smsd2");
	if (conn != null) {
		out.println("jdbc/smsd2ok");
		conn.close();
	}
	else
		out.println("jdbc/smsd2no");
	
	conn = VbyP.getDB("sr_smsd1");
	if (conn != null) {
		out.println("jdbc/sr_smsd1ok");
		conn.close();
	}
	else
		out.println("jdbc/sr_smsd1no");
	
	conn = VbyP.getDB("smsd3");
	if (conn != null) {
		out.println("jdbc/smsd3ok");
		conn.close();
	}
	else
		out.println("jdbc/smsd3no");
	
	conn = VbyP.getDB("sr_smsd2");
	if (conn != null) {
		out.println("jdbc/sr_smsd2ok");
		conn.close();
	}
	else
		out.println("jdbc/sr_smsd2no");
	
	 */
%>
</body>
</html>