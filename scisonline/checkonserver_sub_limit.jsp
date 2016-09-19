<%-- 
    Document   : checkonserver
    Created on : Oct 15, 2013, 2:08:09 PM
    Author     : sri
--%>


<%@ include file="dbconnection.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Calendar"%>

<%@page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>


        <title>JSP Page</title>
    </head>
    <body>
        <%
        try{
            String selected_code = request.getParameter("subj_code");
            String selected_stream = request.getParameter("stream");
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            String hmap=request.getParameter("hmap");
            HashMap s_hm=(HashMap)session.getAttribute("value");
            int i=1;
            if(i==1){ 
                //String print=System.out.println(hmap);
        %> 
        
        
        <%=s_hm%>   

        
        <%
            
            }
            
                           else{
            System.out.println("test here :" + selected_code);

            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            Statement st9 = con.createStatement();
            Statement st10 = con.createStatement();

         
            ResultSet rs_course1 = (ResultSet) st7.executeQuery("select " + selected_stream + " from " + given_year + "_" + given_session + "_elective where  " + selected_stream + "!=0 and ( course_name = '"+selected_code+"')"  );
            if (rs_course1.next()) {
                String slimit = rs_course1.getString(1);
                int limit = Integer.parseInt(slimit);
                if(limit!=0){
                    limit=limit-1;
                    st8.executeUpdate("UPDATE " + given_year + "_" + given_session + "_elective SET "+selected_stream+" = "+limit+" WHERE course_name = '"+selected_code+"'");
               
        %>

        
        abc
        <%=limit%>

        <%}    } 
                           else{
                           
                           
                           %> 
        
         ZERO
        
        <%
                           
                                     
            
            }

            }
        }
          catch(Exception e){
              %> 
        exception
        
        <%=e%>
              <%
          }


        %>    




    </body>
</html>
