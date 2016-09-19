<%-- 
    Document   : detailStudentwise
    Created on : 14 Mar, 2012, 10:41:27 AM
    Author     : khushali
--%>

<%@include file="checkValidity.jsp"%>
<%@ include file="dbconnection.jsp" %>

<%@page import="java.util.Calendar"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page import="java.sql.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
   


<style type="text/css">
    table {
        border: solid #66CC99;
        border-width: 0px 1px 1px 0px;
        width: 400px;
    }
    th, td {
        border: solid #66CC99;
        border-width: 1px 0px 0px 1px;
        padding: 4px;
    }
    th {
        background-color: #339999;
        color: #FFFFFF;
    }
    tr.alt td {
        background-color: #EEEEEE;
    }
    tbody {
        height: 200px;
        }
</style>

 </head>
    <body>

         <% String rsubj="";
            Calendar now = Calendar.getInstance();
   
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
            int month=now.get(Calendar.MONTH)+1;
            int cyear=now.get(Calendar.YEAR);
            System.out.println("Current Month:"+month);
            System.out.println("Current Year:"+cyear);
           // String name=request.getParameter("user");
             String sem="";
    if(month>=7)
        sem="Summer";
          else if(month>=1 && month<=5)
           sem="Winter";
              String year1="";
    String id="";
    String num="";
    String name="";
             name = (String)session.getAttribute("user");
           // String year1=name.substring(0,2);
           // String id=name.substring(5,6);
             year1=name.substring(2,4);
             id=name.substring(5,6);
             num=name.substring(6,8);
            name=year1+"mcm"+id+num;
            int i=0;
            String stream="";
            String year="20"+year1;
            if(id.equalsIgnoreCase("t"))
            {
                stream="MTech_CS";
                
            }
                       else if(id.equalsIgnoreCase("b"))
                                                     {
                           stream="MTech_IT";
                       }
                       else if(id.equalsIgnoreCase("i"))
                                                     {
                           stream="MTech_AI";
                       }
                      else  if(id.equalsIgnoreCase("c"))
                                                   {
                          stream="MCA";
                      }
            
             System.out.println(year);
             System.out.println(stream);
             String batch=stream+"_"+year;
             System.out.println(batch);
             try
                                 {
              //   Class.forName("com.mysql.jdbc.Driver").newInstance();
                 System.out.println("driver connected");
               //  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
                 Statement st1=con.createStatement();
                 ResultSet rs1=st1.executeQuery("select * from "+stream+"_"+year+" where StudentId='"+name+"' ");
                 ResultSetMetaData rsmd = rs1.getMetaData ();
		 int colCount = rsmd.getColumnCount ();
                // rs1.next();
                // i=4;
 %>
 
 <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center>Grades of the Student:<%=name%></center>
<div>
    <table border="0" cellspacing="0" cellpadding="0" align="center" style="color:blue;background-color:#CCFFFF;">
        <thead>
              <tr>
                    <th>Course Id</th>
                    <th>Grade</th>
              </tr>
        </thead>
        <tbody>
            
            <%  
                 if(rs1.next()){  System.out.println("here in the if block::"+rs1.getString(1));
                                    i=4;
                do{
                    rsubj = rs1.getString (i);
			      // System.out.println(rsubj);
			      if (rsubj == null)
				rsubj = "";
                    
                    if(rsubj.equals("A+")||rsubj.equals("A")||rsubj.equals("B+")||rsubj.equals("B")||rsubj.equals("C")||rsubj.equals("D")||rsubj.equals("F"))
                                               { %>
                                                    <tr>
                                                     <td><%=rs1.getString(i-1)%></td>
                                                     <td><%=rs1.getString(i)%></td>
                                                     </tr>
                  <%  }
                        i++;
                    }while(i<colCount);
                    
                  %>
            
              
              <tr class="alt" align="center">
                    <td>CGPA</td>
                    <td><%=rs1.getString("cgpa")%></td>
              </tr>
              <%
                             }
                 
                             else{ int y=Integer.parseInt(year)+1;
                                        System.out.println("lokking into next batch:"+y);
                            String qry22="select * from "+stream+"_"+y+" where StudentId='"+name+"' ";
              Statement st22=con.createStatement();
              ResultSet rs22=st22.executeQuery(qry22);
               ResultSetMetaData rsmd1=rs22.getMetaData();
               int colCount1 = rsmd1.getColumnCount();
              i=4;
              rs22.next();
               do{  
                    rsubj = rs22.getString (i);
			      // System.out.println(rsubj);
			      if (rsubj == null)
				rsubj = "";
                    
                    if(rsubj.equals("A+")||rsubj.equals("A")||rsubj.equals("B+")||rsubj.equals("B")||rsubj.equals("C")||rsubj.equals("D")||rsubj.equals("F"))
                                               { %>
                                                    <tr>
                                                     <td><%=rs22.getString(i-1)%></td>
                                                     <td><%=rs22.getString(i)%></td>
                                                     </tr>
                  <%  }
                        i++;
                    }while(i<colCount);
                    System.out.println("i:"+i);
                  %>
            
              
              <tr class="alt" align="center">
                    <td>CGPA</td>
                    <td><%=rs22.getString("cgpa")%></td>
              </tr>
                 <% } %>
                                     
             
        </tbody>
    </table>
</div> 
                  <div align="center">
		<input type="button" value="Print"style="width: 50px; color: white; background-color: #6d77d9; border-color: red;"onclick="window.print();" /> 

                  
       <% }
            catch(Exception e)
                                       {
                               e.printStackTrace();
            }
                %>
   
    </body>