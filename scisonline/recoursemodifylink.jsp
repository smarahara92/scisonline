<%-- 
    Document   : recoursemodifylink
    Created on : Mar 26, 2013, 3:22:40 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file ="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
           <style>
.style30 {width:300px}
</style>
        <script>
            
            function display(temp)
            {
              var x=document.getElementById("selecta"+temp).value;  
              if(x=="none")
                  {document.getElementById("selectb"+temp).value="none";
                   return;}
               var s=x.substring(0,1);
               if(s=='C')
                    {document.getElementById("selectb"+temp).value="none";
                     
                    }
                else if(s=='E')
                    document.getElementById("selectb"+temp).disabled=false;
                else
                    document.getElementById("selectb"+temp).disabled=false;
             // alert(s);
            }
            function display1(temp)
            {
        var x=document.getElementById("selectb"+temp).selectedIndex;
     
               
                if(document.getElementById("selecta"+temp).value=="none")
                    {
                alert("Old Subject not selected");
                document.getElementById("selecta"+temp).focus();
                document.getElementById("selectb"+temp).value="none";
                    }
                var x=document.getElementById("selecta"+temp).value;  
               var s=x.substring(0,1);
                if(s=='C')
                    {document.getElementById("selectb"+temp).value="none";
                     
                    }
            }
        </script>
    </head>
    <body>
        <form action="recoursemodifylink1.jsp" method="get" name="form1" onsubmit="return check();">
        <table align="center">
                <tr  bgcolor="#c2000d">
                    <td align="center" class="style31"><font size="6">Re-Course Registration</font></td>
                </tr>
            </table>
        <table align="center">
            
            <tr>
                <th>Student Id</th>
                <th>Old Subject</th>
                <th>New Subject</th>
               
            </tr>
        <%
        Connection con = conn.getConnectionObj();
        try{
         Statement st1=con.createStatement();
                   Statement st2=con.createStatement();
                   Statement st3=con.createStatement();
                   Statement st4=con.createStatement();
           String []studentid=request.getParameterValues("sid");
           System.out.println(studentid.length);
           int i=0;
           int find=0;
           ResultSet rs1=st4.executeQuery("select a.Code,a.Subject_Name from subjecttable as a,subjectfaculty as b where b.subjectid=a.Code order by a.Subject_Name");
            for(i=0;i<studentid.length;i++)
             {
                String s=studentid[i];
                String stream="";
                String year="";
                String mastertable="";
                if(s.equals("---Enter Student Id---")||s.equals(""))
                   {}
                else
                  {
                    
                    s = s.toUpperCase();
                    if(s.substring(4,6).equals("MT"))
                             stream="MTech_CS";
                    else if(s.substring(4,6).equals("MB"))
                             stream="MTech_IT";
                     else if(s.substring(4,6).equals("MI"))
                             stream="MTech_AI";
                     else
                         stream="MCA";
                    year=s.substring(0,2);
                    mastertable=stream+"_20"+year;
                    System.out.println(s+"   "+mastertable);
                  
                    ResultSet rs=st1.executeQuery("select * from "+mastertable+" where StudentId='"+s+"'");
                    ResultSetMetaData rsmd = rs.getMetaData();
                     int noOfColumns = rsmd.getColumnCount();   
                    int temp=(noOfColumns-2)/2;
                    int j=0;
                    System.out.println(temp);
                    int count=0;
                    while(rs.next())
                          count++;
                    rs.beforeFirst();
                    
                 %>   <tr>
                <td><input type="text" name="sid" value="<%=s%>" readonly="readonly"></td>
                <td>
                    <select name="select1" class="style30" id="selecta<%=find%>" onchange="display(<%=find%>);">
                        <option value="none">none</option>
                  <%
                  while(rs.next())
                   while(temp>0&&count!=0)
                    {
                      int m=j+3;
                      String F="F";
                     
                       if(F.equals(rs.getString(m+1))==true)
                        {
                          String subjid=rs.getString(m);
                           ResultSet rs13=st2.executeQuery("select * from "+stream+"_curriculum where subjId='"+subjid+"'");
                          String type="E";
                          while(rs13.next())
                               {
                                 type="C";
                               }
                          ResultSet rs11=st2.executeQuery("select Alias from "+stream+"_curriculum where subjId='"+subjid+"'");
                 while(rs11.next())
                      {
                       if(rs11.getString(1)!=null)
                              subjid=rs11.getString(1);
                      }
                         
                          ResultSet rs12=st2.executeQuery("select * from subjecttable where Code='"+subjid+"'");
                          rs12.next();
                  %><option value="<%=type+rs.getString(m)%>"><%=rs12.getString(2)%></option><%
                        }
                      temp--;j=j+2;
                    }
                    rs.close();
                    
                    %></select></td>
                
                    <td>
                    <select name="select3" class="style30" id="selectb<%=find%>" onchange="display1(<%=find%>);">
                        <option value="none">none</option>
                        <%
                        rs1.beforeFirst();
                        while(rs1.next())
                                                       {%>
                        <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
                        
                        <%}%>
                    </select>
                    
                </td>
                
                  
                    <%
                    find++;
                 //
                  }
             }
        } catch( Exception e)
                            {
                                
                            }finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                              
                            }


        
        %>
         <tr ><td colspan="3" align="center"><input type="submit" name="submit" value="submit"></td></tr>
        </table>
        </form>
    </body>
</html>
