<%-- 
    Document   : addFaculty_link
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="#CCFFFF"><%
        Connection con = conn.getConnectionObj();
        try {
            String fid[]=request.getParameterValues("fid");
            String fname[]=request.getParameterValues("fname");
            String ou[]=request.getParameterValues("ou");
            Statement st1=con.createStatement();
            
            int count=0;
            for(int i=0;i<fid.length;i++) {
                fid[i] = fid[i].trim();
                fname[i] = fname[i].trim().toUpperCase();
                ou[i] = ou[i].trim().toUpperCase();
                if(fid[i].equals("")==false && fname[i].equals("")==false) {
                    count++;
                    st1.execute("insert into faculty_data(ID,Faculty_Name,Organization)values('"+fid[i]+"','"+fname[i]+"','"+ou[i]+"')");
                }
            }
            if(count==0) { %>
                <center><h2> at least enter one faculty details</h2></center> <%
            } else if(count!=0) {%>
                <center><h1>details added successfully</h1></center> <%
            }
        } catch(Exception e) {
            out.println(e);
        }
          
        conn.closeConnection();
        con = null; %>
    </body>
</html>
