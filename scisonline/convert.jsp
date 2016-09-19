<%-- 
    Document   : convert
    Created on : Apr 22, 2013, 12:28:02 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jxl.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         try
    {
      //String saveFile=(String)session.getAttribute("saveFile");
      String filename = "/var/lib/mysql/dcis_attendance_system/data.xls";
      WorkbookSettings ws = new WorkbookSettings();
      ws.setLocale(new Locale("en", "EN"));
      Workbook w = Workbook.getWorkbook(new File(filename),ws);
      System.out.println("llll");
      File f = new File("/var/lib/mysql/dcis_attendance_system/new.csv");
      OutputStream os = (OutputStream)new FileOutputStream(f);
      String encoding = "UTF8";
      OutputStreamWriter osw = new OutputStreamWriter(os, encoding);
      BufferedWriter bw = new BufferedWriter(osw);


      for (int sheet = 0; sheet < w.getNumberOfSheets(); sheet++)
      {
        Sheet s = w.getSheet(sheet);

        //bw.write(s.getName());
        //bw.newLine();

        Cell[] row = null;

        for (int i = 0 ; i < s.getRows() ; i++)
        {
          row = s.getRow(i);

          if (row.length > 0)
          {
            bw.write(row[0].getContents());
            for (int j = 1; j < row.length; j++)
            {
              bw.write(',');
              bw.write(row[j].getContents());
            }
          }
          bw.newLine();
        }
      }
      bw.flush();
      bw.close();
    }
    catch (Exception e)
    {
      System.err.println(e);
    }
        
        %>
    </body>
</html>
