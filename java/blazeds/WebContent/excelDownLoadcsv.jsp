<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%
response.setHeader("Content-Disposition", "attachment; filename=119.xls");
response.setHeader("Content-Description", "JSP Generated Data");

String data = SLibrary.IfNull( request.getParameter("excelData") );

try {
	


%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>munja119</title>
</head>
<body>

	<table border=1> <!-- border=1은 필수 excel 셀의 테두리가 생기게함 -->
        <tr bgcolor=#CACACA> <!-- bgcolor=#CACACA excel 셀의 바탕색을 회색으로 -->
            <td colspan=3><H3>munja119</H3></td>
        </tr>
        <%
        	String[] row = data.split("||");
        	int count = row.length;
        	
        	String[] col = null;
        	int colCount = 0;
        	for( int i = 0; i < count; i++) {
        		
        		col = row[i].split(",");
        		colCount = col.length;
        		
        		if (col != null) {
        			
	        		out.println("<tr>");
	        		
	        		for ( int j = 0; j < colCount; j++) {
	        			
	        			out.println(" <td style=\"mso-number-format:'@'\">"+col[j]+"</td>");
	        		}
	        		
	        		out.println("</tr>");
        		}
        	}
        %>
    </table>
</body>
</html>
<%
}catch(Exception e) {
	
}
%>