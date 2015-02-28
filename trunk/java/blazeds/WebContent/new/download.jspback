<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.io.*" %>
<%
 try{

  String path = "/home/sms/webapps/WebContent/new/flexlib/"  ;

  String fileName = new String(request.getParameter("filename").getBytes("euc-kr"), "ISO-8859-1");
  
  File file = new File(path+fileName);
  
  response.reset();
  
  response.setContentType("application/octer-stream");

  response.setHeader("Content-Disposition", "attachment;filename="+fileName+"");

  response.setHeader("Content-Transper-Encoding", "binary");


  response.setContentLength((int)file.length());

  response.setHeader("Pargma", "no-cache");

  response.setHeader("Expires", "-1");
  
  byte[] data = new byte[1024 * 1024];
  BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file));
  // response가 사용하는 OutputStream()을 out 스트림으로 사용 
  BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
  
  int count = 0;
  while((count = fis.read(data)) != -1){
   fos.write(data);
  }
  
  if(fis != null) fis.close();
  if(fos != null) fos.close();
  
 }catch(Exception e){
  System.out.println("download error : " + e);
 }
 // jsp 에는 이미 내장객체로 out이 사용되고 있기 때문에 
 // outputstream을 사용하려면 비워 줘야 한다고 함! out.clear();
 // pageContext.pushBody() 이건 또 뭐란 말인가?
 out.clear();
 out = pageContext.pushBody();
%>