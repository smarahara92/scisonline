<%-- 
    Document   : attmodify3
    Created on : 21 Nov, 2012, 2:49:35 AM
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function dothis(temp)
            { 
                
                
                var cmp1=parseInt(document.getElementById(temp).value);
                var cmp2=parseInt(document.frm.elements[5].value);
                
               
              //alert("enter only digits less than the total number of hours"+cmp1);
               // if(Integer.parseInt(cmp1) > Integer.parseInt(cmp2))
               
               if(cmp2 >= cmp1)
                    {
                        document.getElementById(temp).style.color='black';
                        document.getElementById(temp).focus();
                        //documemt.getElementById(temp).value=0;
                         
                        //documemt.getElementById(temp).value=0;
                    }
               else
               if(cmp2 < cmp1)
                   {
                      alert("Number of hours attendanded exceeds the number of hours taught"); 
                      document.getElementById(temp).style.color='red';
                      document.getElementById(temp).focus();
                      
                   }
                   else
                       {
                           alert("Not a valid input"); 
                       }
                
            }
            
           
            
            </script>
    </head>
    <body>
        <%
        Statement stat1=con.createStatement();
        Statement stat2=con.createStatement();
        Statement stat3=con.createStatement();
        String date 	= (String)request.getParameter("dates");
        try
                           {
             if(date.equals("none"))
                  {System.out.println("kkkkk");
                   throw new Exception();}
        }
        catch(Exception e)
            {out.println("<center><h1>Invalid Operation</h1></center>");
            return;}
        
        String year=request.getParameter("year");
        String semester=request.getParameter("semester");
        String subjectName=request.getParameter("subjname");
        String subjectId=request.getParameter("subjid"); 
        System.out.println(date);
        System.out.println(year);
        System.out.println(semester);
        System.out.println(subjectName);
        System.out.println(subjectId);
        int value=Integer.parseInt(date.substring(0,1));
        String dates=date.substring(1);
        String qry2="select col"+value+" from subject_attendance_"+semester+"_"+year+" where subjectId='"+subjectId+"'";
        ResultSet rs2=stat1.executeQuery(qry2);
        rs2.next();
        int pmc=rs2.getInt(1);
        session.setAttribute("columnname",dates);
        session.setAttribute("value",value);
        String qry1="select StudentId,StudentName,"+dates+" from "+semester+"_"+year+"_"+subjectId+" ";
        ResultSet rs1=stat1.executeQuery(qry1);
        
        System.out.println(value+"  iiiiiiiiiiii  "+dates+"LLLLLL"+pmc);
         %>
         <form  id="frm" name="frm" action="attmodify4.jsp" method="POST">  
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
          
             <td align="center"><input type="text" name="subjname" id="subjname" value="<%=subjectName%>" size="28" readonly="readonly" /></td>  
                   
                <td align="center"><input type="text" name="subjid" id="subjid" value="<%=subjectId%>" size="10" readonly="readonly" /></td>    
                  
                
                
            </tr>
       </table>
                </br>
          <table align="center" border="0" style="color:blue;background-color:#CCFF99" cellspacing="10" cellpadding="0" >
            <tr>
                <td><center>Number of Hours<br/>taught in selected month:</center></td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                
                <td align="center">Maximum classes<input type="text" id="pmc" name="pmc" value="<%=pmc%>" readonly="readonly" size="15"/></td>
               
                <td align="center">You Want To Modify<input type="text" id="mmc" name="mmc" value="<%=pmc%>"  size="15"/></td>
                
            </tr>   
         </table>
                  </br>
         <table border="1" cellspacing="0" cellpadding="0" align="center">
            <tr>
                
                <th  align ="center">Registration No.</th>
                <th  width="300" align ="center" >Name of the Student</th>
                <th  align ="center">Attendance</th>
            </tr>
            <%  int i=1;
                   while(rs1.next())
                   {%>
                       <tr>
                
                <td  align ="center"><%=rs1.getString(1)%></td>
                <td   align ="center" ><%=rs1.getString(2)%></td>
                <td><input type="text" name="student" id="<%=Integer.toString(i)%>"  value="<%=rs1.getInt(3)%>" size="5" onchange="dothis(<%=Integer.toString(i)%>);"/></td>
            </tr> 
                    <%   
                    i++;
                   }
            %>
         </table>
         <center><input type="Submit" value="upload" onclick=""></center>
         </form>
    </body>
</html>
