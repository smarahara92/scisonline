<%-- 
    Document   : query_curr0
    Created on : 24 Apr, 2015, 1:39:09 AM
    Author     : root
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="checkValidity.jsp"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body><%
        try {
            int v = 0;
            int colTypeCount = 0;
            String typePname = "";

            String pname = request.getParameter("pname");
            String latestCurrYear = request.getParameter("year");
            
            try {
                ResultSet rs = scis.executeQuery("select * from " + pname.replace('-', '_') + "_" + latestCurrYear + "_curriculum");
                if(rs == null) {
                    out.println("Curriculum does not exists..");
                    return;
                }
                
                ResultSetMetaData metadata = rs.getMetaData();
                int columnCount = metadata.getColumnCount();%>
                <table align="center" border="1" class = "maintable">
                    <col width = 10%>
                    <col width = 10%>
                    <col width = 50%>
                    <col width = 10%>
                    <col width = 10%>
                    <col width = 10%><%
                    for (v = 1; v <= columnCount; v++) {
                        if (rs.getMetaData().getColumnName(v).equalsIgnoreCase("type")) {
                            colTypeCount = v;
                        }
                        if (rs.getMetaData().getColumnName(v).equalsIgnoreCase("SubCode")) {%>
                            <th class="heading" align="center">Course Code</th><%
                        } else if (rs.getMetaData().getColumnName(v).equalsIgnoreCase("SubName")) {%>
                            <th class="heading" align="center">Course Name</th><%
                        } else {%>
                            <th class="heading" align="center"> <%=rs.getMetaData().getColumnName(v)%> </th><%
                        }
                    }
                    while (rs.next()) {%>
                        <tr><%
                            for (v = 1; v <= columnCount; v++) {
                                if (colTypeCount != v) {
                                    if (rs.getString(v) == null) {%>
                                        <td class = "cellpad"></td><%
                                    } else {%>
                                        <td class="cellpad"><%=rs.getString(v)%></td><%
                                    }
                                } else {
                                    if (rs.getString(v) == null) {%>
                                        <td class="cellpad"></td><%
                                    } else {
                                        if (rs.getString(v).equalsIgnoreCase("C")) {
                                            typePname = "Core";
                                        } else if (rs.getString(v).equalsIgnoreCase("E")) {
                                            typePname = "Elective";
                                        } else if (rs.getString(v).equalsIgnoreCase("L")) {
                                            typePname = "Lab";
                                        } else if (rs.getString(v).equalsIgnoreCase("P")) {
                                            typePname = "Project";
                                        }%>
                                        <td class="cellpad"><%=typePname%></td><%
                                    }
                                }
                            }%>
                        </tr><%
                    }%>
                </table><%
            } catch (Exception e) {
                System.out.println(e);
                return;
            } 
        } catch (Exception ex) {
            System.out.println(ex);
        }
        scis.close(); %>            
    </body>
</html>