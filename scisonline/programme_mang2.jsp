<%-- 
    Document   : subject_database
    Created on : Jul 11, 2013, 10:41:47 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%-- @ include file="dbconnection.jsp" --%>
<%@include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <%  
        Connection con = conn.getConnectionObj();
        try {
            ResultSet rs1 = null;
            Statement st1 = con.createStatement();
            
            try {
                rs1 = st1.executeQuery("select * from programme_table");
                if (rs1.next()) {// programme_table is empty
                } else {
    %>
    <script type="text/javascript">
        alert("Add at least one programme");
    </script> 
    <%
        }
    } catch (Exception ex) {//programme_table is not there....
        System.out.println(ex);
    %>
    <script type="text/javascript">
        alert("Add at least one programme");
    </script> 
    <%
            //return;
        }


    %>
    <frameset rows="12%,*" target="main">
        <frame src="programme_mang_view.jsp" name="left" scrolling="no">
            <frame src="" name="pgmview">
                </frameset>
                <%      rs1.close();
                        st1.close();
                    } catch (Exception e) {//internal error
                %>
                <script>


                    window.open("Project_exceptions.jsp?check=6", "subdatabase");//here check =6 means error number (if condition number.)
                </script>

                <%  return;
                    }%>
<%--
    try {
        con.close();
        con1.close();
        con2.close();
    } catch(Exception e) {
        System.out.println(e);
    } finally {
        con.close();
        con1.close();
        con2.close();
    }
--%>
<% conn.closeConnection(); con = null; %>
                </html>
