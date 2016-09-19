<%-- 
    Document   : recourselink
    Created on : Mar 19, 2012, 6:44:48 PM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.*"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file ="connectionBean.jsp" %>
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="#CCFFFF">
        <%
        Connection con = conn.getConnectionObj();
        Connection con1 = conn1.getConnectionObj();
        int month = Calendar.getInstance().get(Calendar.MONTH)+1;
        int year= Calendar.getInstance().get(Calendar.YEAR);
        String semester="";
        String[] sid=request.getParameterValues("sid");
        String[] sname=request.getParameterValues("sname");
        String[] new_subjid=request.getParameterValues("newsubname");
        //String[] oldtype=request.getParameterValues("select2");
        //String[] newsubject=request.getParameterValues("select3");
        
        String table="", att_table="",ass_table="";
        
        /*
        System.out.println(sid.length+" "+old_subjid.length+" "+new_subjid.length+"*******"+month);
        
        for(int i=0; i<10; i++)
                   {
            //if(sid[i].equals("---Enter Student Id---"))
               // ;
           // else
                System.out.println("---"+sid[i]+"---"+old_subjid[i]+"---"+new_subjid[i]+"---");
               }
        //int i=0;
        //int j=0;
        */
        
        try{
           for(int i=0; i<10; i++)
           {
               //System.out.println(i);
               
               
               if(sid[i].equals("") || sname[i].equals("") || new_subjid[i].equals("none")==true)
                {
                   System.out.println((i+1)+" th student details not valid");
                }
                else
                {
                     if(month<=6)
                         {semester="Winter";}
                     else
                         {semester="Monsoon";}                                                             
                    att_table=semester+"_"+year+"_"+new_subjid[i];
                    ass_table="Assessment_"+semester+"_"+year+"_"+new_subjid[i];
                    System.out.println(att_table+"\n"+ass_table);
                    Statement st1=con.createStatement();
                    Statement st2=con1.createStatement();
                    
                    
                    
                    st1.executeUpdate("insert into "+att_table+" (StudentId, StudentName) values('"+sid[i]+"', '"+sname[i]+"')");
                    st2.executeUpdate("insert into "+ass_table+" (StudentId, StudentName) values('"+sid[i]+"', '"+sname[i]+"')");          
                                             
                     out.print((i+1)+" th student details successfully added");   
                    }
                    
                    
            
             }
            //System.out.println(table);
        }

        catch(Exception e)
        {
            e.printStackTrace();
        }finally{
                               
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                
                            }
        
        %>
    </body>
</html>
