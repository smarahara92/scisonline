<%-- 
    Document   : recourselink
    Created on : Mar 19, 2012, 6:44:48 PM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>s
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
        int month = Calendar.getInstance().get(Calendar.MONTH)+1;
        int cur_year= Calendar.getInstance().get(Calendar.YEAR);
        String[] sid=request.getParameterValues("sid");
        String[] old_subjid=request.getParameterValues("selectold");
        String[] new_subjid=request.getParameterValues("selectnew");
        //String[] oldtype=request.getParameterValues("select2");
        //String[] newsubject=request.getParameterValues("select3");
        
        String table="", att_table="";
        
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
               
               
               if(sid[i].equals("---Enter Student Id---") || sid[i].equals(""))
                {
                   //System.out.println(i);
                }
                else
                {
                    String student=sid[i];
                    
                    
                    if(new_subjid[i].equals("none"))
                        new_subjid[i]=old_subjid[i];
                    
                    //System.out.println(sid[i]+" "+old_subjid[i]+" "+new_subjid[i]);

                    String year1=student.substring(0,2);
                    String id=student.substring(5,6);
                    String year="20"+year1;

                
                    if(id.equalsIgnoreCase("t"))
                    {
                        table="MTech_CS"+"_"+year; 
                    }
                    else if(id.equalsIgnoreCase("b"))
                                                    {
                        table="MTech_IT"+"_"+year;
                    }
                    else if(id.equalsIgnoreCase("i"))
                                                    {
                        table="MTech_AI"+"_"+year;
                    }
                    else  if(id.equalsIgnoreCase("c"))
                                                {
                        table="MCA"+"_"+year;
                    }
                 
                    
                    Statement st1=con.createStatement();
                    Statement st2=con.createStatement();
                    Statement st3=con.createStatement();
                    ResultSet rs=st1.executeQuery("select * from "+table+" where StudentId='"+student+"'");
                    ResultSetMetaData rsmd=rs.getMetaData();
                    
                    int columns=rsmd.getColumnCount();
                    String col1="", col2="";
                    
                    
                    if(rs.next())
                    {
                        for(int j=1; j<=columns-1; j++)
                        {
                            if(rs.getString(j)!=null && rs.getString(j).equals(old_subjid[i]))
                            {
                                if(month>=6 && month<=11)
                                    att_table = "Monsoon_"+cur_year+"_"+new_subjid[i];
                                else
                                    att_table = "Winter_"+cur_year+"_"+new_subjid[i];
                                col1=rsmd.getColumnName(j);
                                col2=rsmd.getColumnName(j+1);
                                
                    //System.out.println(sid[i]+" "+old_subjid[i]+" "+new_subjid[i]+" "+col1+" "+col2);
                    //System.out.println(att_table);
                    st2.executeUpdate("update "+table+" set "+col1+"='"+new_subjid[i]+"', "+col2+"='R'" );
                    st3.executeUpdate("insert into "+att_table+" (StudentId, StudentName) values('"+rs.getString(1)+"', '"+rs.getString(2)+"')" );
                                break;
                            }                     
                        }
                    }
                    
                    
            
             }
            //System.out.println(table);
        }
           
               }catch(Exception e) {
                   e.printStackTrace();
                }finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                
                            }
        
        %>
    </body>
</html>
