<%-- 
    Document   : attmodify2
    Created on : 21 Nov, 2012, 1:11:31 AM
    Author     : laxman
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file="dbconnection.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String subjectId=request.getParameter("subjectid");
        String sname=request.getParameter("subjectname");
     System.out.println("llll"+subjectId+sname);
     Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
    
    String semester="";
    if(month==7 || month==8 || month==9 || month==10 || month==11 || month==12)
               {
   semester="Monsoon";
    }else if (month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
               {
         semester="Winter";
    }
     
        Statement stat1=con.createStatement();
        Statement stat2=con.createStatement();
        Statement stat3=con.createStatement();
       // String qery1="select * from subject_attendance_"+semester+"_"+year+" where subjectId='"+subjectid+"'";
        //ResultSet rs=stat1.executeQuery(qery1);
       // rs.next();
        try
         {        
        String qry1="show columns from "+semester+"_"+year+"_"+subjectId;
        ResultSet rs1=stat1.executeQuery(qry1);
        rs1.next();rs1.next();rs1.next();rs1.next();
         
        
     %>   
     <form name="form1" action="attmodify3.jsp" target="facultyaction" method="POST">
       <table  align="center" border="0" cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="97%">
            <tr>
                <td align="center">Year</td>
               
                <td align="center">Semester</td>
                <td align="center">Subject</td>
                <td align="center">Code</td>
            </tr>
             <tr>
                <td align="center"><input type="text" name="year" id="year" value="<%=year%>" size="10" readonly="readonly" /></td>
                 <td align="center"><input type="text" id="semester" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></td>
          
             <td align="center"><input type="text" name="subjname" id="subjname" value="<%=sname%>" size="28" readonly="readonly" /></td>  
                   <% //session.setAttribute("subjname",sname);%>
                <td align="center"><input type="text" name="subjid" id="subjid" value="<%=subjectId%>" size="10" readonly="readonly" /></td>    
                  <%  //session.setAttribute("subjid",subjectId);%>
                
                
            </tr>
       </table>
                  </br></br></br>
    <center> Select Month:</br></br> <select name="dates"  style="width:200px;">
                  <%
                     int i=1;
                     %>
                     <option value="none">None</option>
                     <%
                     while(rs1.next())
                     {
                        String[] nameOfMonth = { "Jan", "Feb", "Mar", "Apr",
                        "May", "Jun", "Jul", "Aug", "Sep", "Oct",
                        "Nov", "Dec" };
                        String columnname=rs1.getString(1);
                        System.out.println(columnname);
                        String frommonth=columnname.substring(5,7);
                        String tomonth=columnname.substring(17,19);
                        String fromdate=columnname.substring(8,10);
                        String todate=columnname.substring(20);
                        String fm=nameOfMonth[Integer.parseInt(frommonth)-1];
                        String tm=nameOfMonth[Integer.parseInt(tomonth)-1];
                        String range=fm+" "+fromdate+" - "+tm+" "+todate;
                        %>
                        <option value="<%=i+rs1.getString(1)%>"><%=range%></option>
                        <%
                        i++;
                     }
                  
                  %>
                   </select>
                   </br></br>
                   <input type="Submit" value="Modify" onclick=""></center>
     </form>
           <%        }
        catch(Exception e)
           {
            out.println("<center><h2>Faculty dont have any subjects.</h2></center>");
           }%>
    </body>
</html>
