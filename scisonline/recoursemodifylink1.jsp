<%-- 
    Document   : recoursemodifylink1
    Created on : Mar 26, 2013, 6:24:34 PM
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
    </head>
    <body>
       
        <%
         Calendar now = Calendar.getInstance();
         Connection con = conn.getConnectionObj();
         Connection con1 = conn1.getConnectionObj();
         try{
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int cyear=now.get(Calendar.YEAR);
     String semester="";
     if(month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
          {
            semester="Winter";
          }
     else
         {  
           semester="Monsoon";
         }
        Statement st1=con.createStatement();
         Statement st2=con.createStatement();
        String []studentid=request.getParameterValues("sid");
        String []oldsubject=request.getParameterValues("select1");
        String []newsubject=request.getParameterValues("select3");
        System.out.println(newsubject.length);
        int i=0;String stream="";String year="";String mastertable="";
        for(i=0;i<studentid.length;i++)
          {
                   if(studentid[i].substring(4,6).equals("MT"))
                             stream="MTech_CS";
                    else if(studentid[i].substring(4,6).equals("MB"))
                             stream="MTech_IT";
                     else if(studentid[i].substring(4,6).equals("MI"))
                             stream="MTech_AI";
                     else
                         stream="MCA";
                    year=studentid[i].substring(0,2);
                    mastertable=stream+"_20"+year;
                    ResultSet rs=st1.executeQuery("select * from "+mastertable+" where StudentId='"+studentid[i]+"'");
                    rs.next();
                    ResultSetMetaData rsmd = rs.getMetaData();
                     int noOfColumns = rsmd.getColumnCount();   
                    int temp=(noOfColumns-2)/2;
                    int j=0;
                    String type=oldsubject[i].substring(0,1);
                    if(oldsubject[i].equals("none")!=true&&(newsubject[i].equals("none")!=true||type.equals("C")==true))
                         {
                             String old=oldsubject[i].substring(1);
                             if(type.equals("C"))
                               {
                                 newsubject[i]=oldsubject[i].substring(1);
                               }
                              while(temp>0)
                               {
                         
                                   int m=j+3;
                                   String columnname=rsmd.getColumnName(m);
                                   String columnname1=rsmd.getColumnName(m+1);
                                   
                                   if(old.equals(rs.getString(m))==true)
                                     {
                                       System.out.println(columnname);
                                       String modified=newsubject[i];
                                       //*******************************************************************
                                       Statement st3=con.createStatement();
                                         ResultSet rs11=st3.executeQuery("select Alias from "+stream+"_curriculum where subjId='"+modified+"'");
                                         while(rs11.next())
                                           {
                                                   if(rs11.getString(1)!=null)
                                                    modified=rs11.getString(1);
                                          }
                                         Statement st4=con.createStatement();
                                         Statement st5=con1.createStatement();
                                         try
                                          {
                                         st4.executeUpdate("delete from "+semester+"_"+cyear+"_"+modified+" where StudentId='"+studentid[i]+"'");
                                         st5.executeUpdate("delete from Assessment_"+semester+"_"+cyear+"_"+modified+" where StudentId='"+studentid[i]+"'");
                                         st4.executeUpdate("insert into "+semester+"_"+cyear+"_"+modified+"(StudentId,StudentName) values('"+studentid[i]+"','"+rs.getString(2) +"')");
                                         st5.executeUpdate("insert into Assessment_"+semester+"_"+cyear+"_"+modified+"(StudentId,StudentName) values('"+studentid[i]+"','"+rs.getString(2) +"')");
                                         st2.executeUpdate("update "+mastertable+" set "+columnname+"='"+newsubject[i]+"',"+columnname1+"='R' where StudentId='"+studentid[i]+"'");
                                         break; 
                                         }
                                         catch(Exception ex)
                                             {
                                               out.println("<center><h2>"+newsubject[i]+" subject not present in current semester</h2></center>");
                                             }
                                       //*******************************************************************
                                      
                                     }
                                      
                                 j=j+2;
                                 temp--;
                             }
                         }
                   
          }
        
      out.println("<center><h2>Recourse registration successfully done</h2></center>");
         } catch( Exception e)
                            {
                                
                            }finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                con1 = null;
                            }


        %>
    </body>
</html>
