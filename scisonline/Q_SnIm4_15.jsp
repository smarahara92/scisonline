<%-- 
    Document   : Q_SnIm4_15
    Created on : Mar 3, 2015, 11:36:42 PM
    Author     : richa
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import ="java.sql.*" %>
<jsp:useBean id="prog" class="com.hcu.scis.automation.GetProgramme" scope="session">
</jsp:useBean>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="print.css" media="print" />
        <style type="text/css">
            
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold{
                font-weight: bold;
            }
            @media print {

                .noPrint
                {
                    display:none;
                }
            } 

            
        </style>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        
    
    
    
        <link rel="stylesheet" type="text/css" href="table_css.css">
      <% 
          
             String subjCode = request.getParameter("pname");
           // out.println(subjCode);
           String S=(String) session.getAttribute("suppyear");
           String S1 =(String) session.getAttribute("suppsem");
        %>
             
             <center><h2 style="color:red">List of all  students who are registered for supplementary in a particular subject <h2></center>
           </br></br>
          <% Connection con = null;
           try{Class.forName("com.mysql.jdbc.Driver");
           
                    con = DriverManager.getConnection
                ("jdbc:mysql://localhost/dcis_attendance_system","root","");
                 ResultSet rs=null;
                  ResultSet rs3=null;
                 Statement stmt =con.createStatement();
                 Statement stmt1 =con.createStatement();
                  Statement stmt4 =con.createStatement();
                String sql ="select * from supp_"+S1+"_"+S+"";
                int i =0;
                int n =0 ;
                  rs = stmt1.executeQuery(sql);
                  ResultSetMetaData md =rs.getMetaData() ;
                  int c = md.getColumnCount();
                  int value = (c-1)/3;%>
                  <table align ='center'>
                   <tr><th><font color='WHITE'>Student ID</font></th>
                       </tr>
                  <%
                          
                  while(rs.next() ){
                    //  out.println("in loop1");
                      i=1;
                      while(i<value)
                      {
                      String sql2 ="select * from supp_"+S1+"_"+S+" where coursename"+i+ " = '"+subjCode+"' and studentId='"+ rs.getString(1)+"'";
                      rs3 = stmt4.executeQuery(sql2);
                      if(rs3.next())
                     {
%>                           
                        <td><b><font color='#663300'><%=rs3.getString(1)%></font></b></td>
                       </tr>
                           
                          <%
                       // out.println(rs3.getString(1));
                            break;
                     }
                     
                        i ++;
                      }
                  }
                  
               
           }catch(Exception e){
               
           }
            %>
            </table>
            <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
            </div>
            </body>
            </html>