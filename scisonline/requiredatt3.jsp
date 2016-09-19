<%-- 
    Document   : requiredatt3
    Created on : Apr 25, 2013, 11:57:21 AM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    <style type="text/css">
          
    @media print {
       
        .noPrint
        {
            display:none;
        }
    }
    </style>
    </head>
    <body>
        <%
        
        Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
     int date=now.get(Calendar.DATE);
    String semester="";
    if(month==7 || month==8 || month==9 || month==10 || month==11 || month==12)
               {
   semester="Monsoon";
    }else if (month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
               {
         semester="Winter";
    }
    

    String sname=request.getParameter("subjectname");
    String sid=request.getParameter("subjectid");          
    String att=request.getParameter("att"); 
    Float ratt=Float.parseFloat(att);
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
    Statement st4=con.createStatement();
    Statement st9=con.createStatement();
    HashMap hm = new HashMap(); 
    HashMap hm1 = new HashMap(); 
    //out.println(sid+"   "+att);    
   %> <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>List of Students having less than <%=att%>% Attendance</b></center>
        </br></br>  <%
        String qry3="select * from "+semester+"_subjectfaculty";
         ResultSet rs3=st4.executeQuery(qry3);    
    
        %>
      <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
       
     <tr>
        <th>StudentID</th>
        <th>StudentName</th>
        <th>Subjects</th>
        
     </tr>
     <%
     while(rs3.next())
              {
      String qry2="select StudentId,StudentName,percentage from "+semester+"_"+year+"_"+rs3.getString(1)+"";
      String qry7="select Subject_Name from subjecttable where Code='"+rs3.getString(1)+"'";
       ResultSet rs9=st9.executeQuery(qry7); 
      rs9.next();           
      String subjectname=rs9.getString(1);
      ResultSet rs2=st3.executeQuery(qry2);        
       while(rs2.next())
        {
           if(Math.ceil(rs2.getFloat(3))<ratt)
            {
               if(hm.containsKey(rs2.getString(1))==true)
                {
                 String k=(String)hm1.get(rs2.getString(1));
                 k=k+" ,"+subjectname+" : "+Math.ceil(rs2.getFloat(3));
                 hm1.put(rs2.getString(1),k);
                }
               else
                {                                                   
                 hm.put(rs2.getString(1),rs2.getString(2));
                 hm1.put(rs2.getString(1),subjectname+" : "+Math.ceil(rs2.getFloat(3)));
                }
              %>
              
              <%
            }
        }
     }
         
     Set set = hm.entrySet();
// Get an iterator
Iterator i = set.iterator();
// Display elements
while(i.hasNext()) 
 {
    Map.Entry me = (Map.Entry)i.next(); 
   %> <tr>
                 <td><%=me.getKey()%></td>
            <td><%=me.getValue()%></td>
            <td><%=hm1.get(me.getKey())%></td>
              </tr><%
}     
     %>
      </table>
      </br>
      <table align="center"><tr><td><div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
</div>
        </td></tr></table> 
    </body>
</html>
