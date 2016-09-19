<%-- 
    Document   : addSubject_link
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
    <body bgcolor="#CCFFFF"> <%
        Connection con = conn.getConnectionObj();
        try {
            String sid[] = request.getParameterValues("sid");
            String sname[] = request.getParameterValues("sname");
            String stype[] = request.getParameterValues("stype");
            String credits[] = request.getParameterValues("credits");

            Statement st1 = con.createStatement();
            int count = 0;
            for(int i = 0; i < sid.length; i++) {
                sid[i] = sid[i].trim().toUpperCase();
                sname[i] = sname[i].trim().toUpperCase();
                credits[i] = credits[i].trim();
                stype[i] = stype[i].trim().toUpperCase();
                
                if(sid[i].equals("")==false && sname[i].equals("")==false && credits[i].equals("")==false && stype[i].equals("")==false) {
                    count++;
                    if( stype[i].equalsIgnoreCase("E") ) {
                        st1.execute("insert into subjecttable(Code,Subject_Name,credits,type)values('"+sid[i]+"','"+sname[i]+"','"+credits[i]+"','E')");
                    } else if(stype[i].equalsIgnoreCase("O")) {
                        st1.execute("insert into subjecttable(Code,Subject_Name,credits,type)values('"+sid[i]+"','"+sname[i]+"','"+credits[i]+"','O')");
                    }
                }
            }
            if(count == 0) { %>
                <center><h2> at least enter one subject details</h2></center> <%
            } else if(count != 0) { %>
                <center><h1>details added successfully</h1></center> <%
            }
        } catch(Exception e) {
            System.out.println(e);
        }
        
        conn.closeConnection();
        con = null; %>
    </body>
</html>
