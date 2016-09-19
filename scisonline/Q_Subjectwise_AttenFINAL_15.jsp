<%-- 
    Document   : Q_Subjectwise_AttenFINAL_15
    Created on : Mar 27, 2015, 3:16:01 PM
    Author     : richa
--%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="javascript" src="print.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body>
        <%  int flag =0 ;
        String sname ="";
        String sid ="";
        int sno =1;
            Connection con = conn.getConnectionObj();
             try {
                 String id ="";
                 String name ="";
                 float per = 0;
                 Calendar now = Calendar.getInstance();

                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);
                int date = now.get(Calendar.DATE);
                String semester = "";
                if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
                    semester = "Monsoon";
                } else if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                    semester = "Winter";
                }
              // sid ="CS931";
              // sname="Grid Computing";
              // sname = request.getParameter("subjectname");
                sid = request.getParameter("subjectid");
                //System.out.println(sname + sid);
                Statement stmt1 = con.createStatement();
                Statement stmt2 = con.createStatement();
                Statement stmt3 = con.createStatement();
                Statement stmt4 = con.createStatement();
                Statement stmt5 = con.createStatement();
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                sname = scis.subjectName(sid);
                %>
                
      <%
                String sql1 ="select * from "+sid+"_Attendance_"+semester+"_"+year;
                rs1 =stmt1.executeQuery(sql1);
                while(rs1.next()){
                    id = rs1.getString(1);
                    name=rs1.getString(2);
                   String sql2 ="select percentage from "+sid+"_Attendance_"+semester+"_"+year+" where StudentId ='"+id+"'";   
                   rs2 = stmt2.executeQuery(sql2);
                   rs2.next();
                   per = rs2.getFloat(1);
                  // out.println(per);
                   if(Math.ceil(per)<75){
                       flag++;
                      /* out.println(id);
                       out.println(name);
                       out.println(per);
                       out.println("***");*/ 
                if(flag == 1 ){%>
                  <center><h3  style="color:red"> List of students who have less than 75% attendance in <%=sid%>: <font style="color: blue"><%=sname%></font></h3></center>   
                 <table align ='center' border=1 class = "maintable">
                     <col width="10%">
                     <col width="15%">
                     <col width="45%">  
                     <col width="30%">
                                    
                <tr>
                    <th class="heading" align="center">SNo</font></th>
                <th class="heading" align="center">Student Id</font></th>
                <th class="heading" align="center">Student Name</font></th>
                <th class="heading" align="center">Percentage</font></th>
                </tr>
                <% flag++; 
                }
                 if(flag >1) {%>
           <tr> 
                <td class = "cellpad"><%=sno++%></b></font></td>
               <td class = "cellpad"><%=rs1.getString(1)%></b></font></td>
               <td class = "cellpad"><%=rs1.getString(2)%></b></font></td> 
               <%  if( rs1.getString(8) ==null  ){
                    System.out.println("null marks");
               %>
                   <td class = "cellpad"><%="  "%></font></td>
              
               
              <% } else {%>
               <td class = "cellpad"><%=Math.ceil(per)%></font></td>
          </tr>
                       <%
               }
                 }
                   }
                }
             }catch(Exception e){
                 System.out.println(e);
             }finally{
                 conn.closeConnection();
                 con = null ;
             }
             %>
              </table>
<%          if(flag >1) { }
              else{
%>
                  <center><h3 style="color: red" >There are no students with less than 75% attendance in <font style="color: blue"><%=sname%></font></h3></center>
                   
<%              }
              
%>
</body>
</html>
