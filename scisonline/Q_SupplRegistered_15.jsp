<%-- 
    Document   : Q_ImpRegistered_15
    Created on : Apr 22, 2015, 4:03:20 PM
    Author     : richa
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
        <center><h3 style="color:red">List of all students who are registered for Supplementary</h3></center>
        <title>JSP Page</title>
    </head>
    <body>
        <%
          Connection con = conn.getConnectionObj();
          try{
              String by ="";
              Statement stmt1 = null;
              ResultSet rs1 = null;
              Statement stmt2 = null;
              ResultSet rs2 = null;
              Statement stmt3 = null;
              Statement stmt4 = null;
              ResultSet rs3 = null;
              ResultSet rs4 = null;
              stmt1 = con.createStatement();
              stmt2 = con.createStatement();
              stmt3 = con.createStatement();
              stmt4 = con.createStatement();
              String sem = scis.getLatestSemester();
              int year = scis.getLatestYear();
              String supp_sem ="";
              int supp_year =0;
              int sno =1;
              String ID= "";
              String sname= "";
              String batch ="";
              String batchyear ="";
              String stream ="";
             String name ="";
             String subid ="";
             String subName = "";
              if(sem.equalsIgnoreCase("Winter") ){
                  supp_sem ="Monsoon";
                  supp_year = year-1 ;
              }
              else {
                  supp_sem ="Winter";
                  supp_year = year ;
              }%>
           
              <table  align="center" border="1" class = "maintable">
                                        <col width="5%">
                                      <col width="10%">  
                                      <col width="15%"> 
                                    <col width="65%">   
                                <tr>
                                    <th class="heading" align="center">SNo</th>
                                    <th class="heading" align="center">Student ID</th>
                                    <th class="heading" align="center">Student Name</th>
                                    <th class="heading" align="center">Subjects</th>
                                    
                                </tr>
              <%
               String r ="";
              String sql1 ="select * from supp_"+supp_sem+"_"+supp_year ;
              rs1 =stmt1.executeQuery(sql1);
              ResultSetMetaData rsmd = rs1.getMetaData();
              int colum = rsmd.getColumnCount();
              int i = 2;
              while(rs1.next() ){
                    r= "";
                    i = 2;
                    ID = rs1.getString(1);
                    batch =ID.substring(0, 2);
                    stream = ID.substring(4,6);
                    int readmin = 0 ;
                    by = "20"+batch ;
                  //  System.out.println(by);
                    int byear =Integer.parseInt(by);
                    String sql2 ="select  Programme_name from programme_table where Programme_code = '"+stream+"'";
                    rs2 = stmt2.executeQuery(sql2);
                    rs2.next();
                    String pname = rs2.getString(1);
                    System.out.println("by"+by);
                    String pname1 = pname.replace('-', '_');
                    System.out.println("Before rs3  "+ID);
                    String sql3 ="select StudentName from "+pname1+"_"+by+" where StudentId = '" +ID+ "'" ;
                    rs3 = stmt3.executeQuery(sql3);
                    if(!rs3.next()){
                        readmin =(Integer.parseInt(by)) + 1; 
                        System.out.println(readmin);
                        String sql4 ="select StudentName from "+pname1+"_"+readmin+" where StudentId = '" +ID+ "'" ;
                        rs4 = stmt4.executeQuery(sql4);
                        if(rs4.next())
                        name = rs4.getString(1);
                    } 
                  else
                      name = rs3.getString(1);
                  System.out.println("Before i loop "+ID);
                  while(i< colum){
                        System.out.println("in i loop "+ID);
                        subid = rs1.getString(i);
                        if( !( subid==null ) ){
                           System.out.println("in i loop and if condition"+ID);
                           subName = scis.subjectName(subid, pname1, byear);
                           r = r + subid+":   "+subName+"<br />" ;
                          // out.println(r);
                           // out.println("i = "+i+"in if part");
                           //out.println(ID+"    "+pname1+"   "+by+" "+subid +""+subName);
                      }
                      else {
                          // out.println("i = "+i+"in break part");
                            break;
                        }
                      i+=3;
                  }
                   // System.out.println(rs3.getString(1));
                 //  out.println(ID+"    "+pname1+"   "+by+" "+subid +""+r);
                    //System.out.println(rs1.getString(1)+"\t\t\t"+rs3.getString(1));%>
                <tr>
                            <td class = "cellpad"><%=sno++%></td>
                             <td class = "cellpad"><%=ID%></td>
                             <td class = "cellpad"><%=name%></td>
                             <td class = "cellpad"><%=r%></td>
                           
                   </tr>    
              <%      
              
              }
              
          }catch(Exception e){
              System.out.println(e);
          }finally{
              conn.closeConnection();
              con = null;
          }
        %>
    </body>
</html>
