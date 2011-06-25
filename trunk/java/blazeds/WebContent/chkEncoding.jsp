<%@ page import="javax.servlet.http.*,
		 java.text.*,
		 java.util.*,
		 java.io.*"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/css/global.css?20110223"/>
<link rel="stylesheet" type="text/css" href="/css/layout.css?20110223"/>
<title>문자메시지</title>

</head> 
<body>
<table align="center" width="80%" border="0">
    <tr><td align="center">
        <h1>Java에서 Encoding 확인</h1>
    </td></tr>
</table>

<table align="center" width="80%" border="1">
    <tr>
        <td width="20%"></td>
        <td width="30%"></td>
        <td width="5%"></td>
        <td width="35%"></td>
    </tr>
    <tr>
        <td align="center">Browser</td>
        <td align="right">contentType</td>
        <td>&nbsp;</td>
        <td>&nbsp;"text/html; charset=UTF-8"</td>
    </tr>
    <tr>
        <td align="center">UNIX</td>
        <td align="right">LANG</td>
        <td>&nbsp;</td>
        <td>&nbsp;utf-8</td>
    </tr>
    <tr>
        <td align="center">DataBase</td>
        <td align="right">mysql</td>
        <td>&nbsp;</td>
        <td>&nbsp;utf-8</td>
    </tr>

<!------------------------------------------------------------------------------------------------->
    <tr>
        <td align="center" rowspan="3">JVM</td>
        <td align="right">file.encoding</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= System.getProperty("file.encoding") %></td>
    </tr>
    <tr>
        <td align="right">file.client.encoding</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= System.getProperty("file.client.encoding") %></td>
    </tr>
    <tr>
        <td align="right">client.encoding.override</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= System.getProperty("client.encoding.override") %></td>
    </tr>
 
<!------------------------------------------------------------------------------------------------->
<%
    String[] strGetEncoding    = {"UTF-8", "KSC5601", "ISO-8859-1"};
    String[] strPutEncoding    = {"UTF-8", "KSC5601", "ISO-8859-1"};

    String chkStr = "한글 테스트";
%>
    <tr>
        <td align="center" rowspan="<%= strGetEncoding.length * strPutEncoding.length + 1 %>">Java</td>
        <td align="right">String</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= chkStr %></td>
    </tr>
<%
    for (int i = 0;i < strGetEncoding.length;i++) {
        for (int j = 0;j < strPutEncoding.length;j++) {
            String strGet = new String(chkStr.getBytes(strGetEncoding[i]), strPutEncoding[j]);
%>
    <tr>
        <td align="right"><%= strGetEncoding[i] %>로 분해 후 <%= strPutEncoding[j] %>로 재조립</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= strGet %></td>
    </tr>
<%
        }
    }
%>

<!------------------------------------------------------------------------------------------------->
<%
    String[] reqGetEncoding    = {"UTF-8", "KSC5601", "ISO-8859-1"};
    String[] reqPutEncoding    = {"UTF-8", "KSC5601", "ISO-8859-1"};

    String chkPara = request.getParameter("para");
    if ((chkPara != null) && (0 < chkPara.length())) {
%>
    <tr>
        <td align="center" rowspan="<%= reqGetEncoding.length * reqPutEncoding.length + 1%>">Servlet/JSP</td>
        <td align="right">request</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= chkPara %></td>
    </tr>
<%
        for (int i = 0;i < reqGetEncoding.length;i++) {
            for (int j = 0;j < reqPutEncoding.length;j++) {
                String strGet = new String(chkPara.getBytes(reqGetEncoding[i]), reqPutEncoding[j]);
%>
    <tr>
        <td align="right"><%= reqGetEncoding[i] %>로 분해 후 <%= reqPutEncoding[j] %>로 재조립</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= strGet %></td>
    </tr>
<%
            }
        }
    } else {
%>
    <tr>
            <form method="post" action="chkEncoding.jsp" target="_blank">
        <td align="center">Servlet/JSP</td>
        <td align="center" colspan="3">
                파라메타 : <input type="text" name="para" value="한글 test"></input>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="submit" value=" 확인 "></input>
        </td>
            </form>
    </tr>
<%
    }
%>

<!------------------------------------------------------------------------------------------------->
<%
    String[] paraEncoding    = {"UTF-8", "KSC5601", "ISO-8859-1"};
    String[] fileGetEncoding = {"UTF-8", "KSC5601", "ISO-8859-1"};
    String[] filePutEncoding = {"UTF-8", "KSC5601", "ISO-8859-1"};

    String fileName = request.getParameter("fileName");
    if ((fileName != null) && (0 < fileName.length())) {
        try {
            File newFile = new File("/tmp", fileName);
            newFile.createNewFile();
        } catch (Exception ex) { }

        for (int i = 0;i < paraEncoding.length;i++) {
            for (int j = 0;j < fileGetEncoding.length;j++) {
                for (int k = 0;k < filePutEncoding.length;k++) {
                    String fileName1 = new String(fileName.getBytes("ISO-8859-1"), paraEncoding[i]);
                    String fileName2 = paraEncoding[i] + "__" + fileGetEncoding[j] + "__" + filePutEncoding[k] + "__" + fileName1 + "_한글.ppt";
                    String fileName3 = new String(fileName2.getBytes(fileGetEncoding[j]), filePutEncoding[k]);
                    try {
                        File newFile = new File("/tmp", fileName3);
                        newFile.createNewFile();
                    } catch (Exception ex) { }
                }
            }
        }
%>
    <tr>
        <td align="center">File Write</td>
        <td align="center" colspan="3">UNIX의 /tmp 디렉토리를 확인하세요.</td>
    </tr>
<%
    } else {
%>
    <tr>
            <form method="post" action="chkEncoding.jsp" target="_blank">
        <td align="center">File Write</td>
        <td align="center" colspan="3">
                한글 파일 명 : <input type="text" name="fileName" value="한글file"></input>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="submit" value=" 확인 "></input>
        </td>
            </form>
    </tr>
<%
    }
%>

<!------------------------------------------------------------------------------------------------->
<%
    try {
        File newDir = new File("/tmp/chkEncoding");
        String[] fileList = newDir.list();
        chkPara = fileList[0];
    } catch (Exception ex) { }
%>

<%
    if ((chkPara != null) && (0 < chkPara.length())) {
%>
    <tr>
        <td align="center" rowspan="<%= reqGetEncoding.length * reqPutEncoding.length + 1 %>">File Read</td>
        <td align="right">File name</td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= chkPara %></td>
    </tr>
<%

        for (int i = 0;i < reqGetEncoding.length;i++) {
            for (int j = 0;j < reqPutEncoding.length;j++) {
                String strGet = new String(chkPara.getBytes(reqGetEncoding[i]), reqPutEncoding[j]);
%>
    <tr>
        <td align="right">From <%= reqGetEncoding[i] %> to <%= reqPutEncoding[j] %></td>
        <td>&nbsp;</td>
        <td>&nbsp;<%= strGet %></td>
    </tr>
<%
            }
        }
    }
%>

<!------------------------------------------------------------------------------------------------->
    <tr>
        <td align="center">DataBase Read/Write</td>
        <td align="center" colspan="3">Reserved</td>
    </tr>

    <tr>
        <td align="center">Upload/Download</td>
        <td align="center" colspan="3">Reserved</td>
    </tr>

</table>
</body>
</html>
