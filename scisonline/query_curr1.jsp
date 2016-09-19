<%-- 
    Document   : query_curr0
    Created on : 24 Apr, 2015, 1:39:09 AM
    Author     : root
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Hashtable"%>
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
            String pname = request.getParameter("pname");
            String latestCurrYear = request.getParameter("year");
                
            try {
                Hashtable hsSem = new Hashtable();
                Hashtable hsCore = new Hashtable();
                Hashtable hsOCore = new Hashtable();
                Hashtable hsLab = new Hashtable();
                Hashtable hsElective = new Hashtable();
                Hashtable hsProject = new Hashtable();
                
                ResultSet rs6 = scis.executeQuery("select * from " + pname.replace('-', '_') + "_" + latestCurrYear + "_currrefer");
                if (rs6 == null) {
                    out.println("Some internal error occurred. Please contact to system administrator.");
                    return;
                }
                while (rs6.next()) {
                    String sem = rs6.getString("Semester");
                    int key = scis.roman2num(sem);
                    hsSem.put(key, sem);
                    hsCore.put(key, rs6.getString("Cores"));
                    hsOCore.put(key, rs6.getString("OptionalCore"));
                    hsLab.put(key, rs6.getString("Labs"));
                    hsElective.put(key, rs6.getString("Electives"));
                    hsProject.put(key, rs6.getString("Projects"));
                }%>
                <table align="center" border="1" class = "maintable">
                    <th class="heading" align="center">Semester</th>
                    <th class="heading" align="center">#Cores</th>
                    <th class="heading" align="center">#Optional Cores</th>
                    <th class="heading" align="center">#Labs</th>
                    <th class="heading" align="center">#Electives</th>
                    <th class="heading" align="center">#Projects</th>
<%
                    String val = null;
                    for(int i = 1, j = 1; i <= hsSem.size(); i++) {%>
                        <tr><%
                            val = (String) hsSem.get(i);%>
                            <td class="cellpad"><%=val%></td><%
                            val = (String) hsCore.get(i); %>
                            <td class="cellpad"><%=val%></td><%
                            val = (String) hsOCore.get(i); %>
                            <td class="cellpad"><%=val%></td><%
                            val = (String) hsLab.get(i); %>
                            <td class="cellpad"><%=val%></td> <%
                            val = (String) hsElective.get(i); %>
                            <td class="cellpad"><%=val%></td> <%
                            if(i == j) {
                                val = (String) hsProject.get(j);
                                if (val.equals("0")) {
                                    ++j;%>
                                    <td class="cellpad">0</td><%
                                } else if(val.equals("1")){
                                    int pCount = 0;
                                    do {
                                        ++pCount;
                                        ++j;
                                        val = (String) hsProject.get(j);
                                    } while(val!= null && val.equals("1"));%>
                                    <td rowspan="<%=pCount%>" class="cellpad">1</td><%
                                }
                            }%>
                        </tr><%
                    }
                    hsSem.clear();
                    hsCore.clear();
                    hsOCore.clear();
                    hsLab.clear();
                    hsElective.clear();
                    hsProject.clear();%>                    
                </table><br/><%
                int MaxSemester;
                ResultSet rs = scis.executeQuery("SELECT COUNT(*),SUM(Cores), SUM(Electives),SUM(Labs),SUM(OptionalCore), BIT_OR(Projects) FROM " + pname.replace('-', '_') + "_" + latestCurrYear + "_currrefer");
                rs.next();
                MaxSemester = Integer.parseInt(rs.getString(1)) + 2;%>
                <table align="center" border="1" class = "maintable">
                    <tr><td class="cellpad" width="60%">Minimum number of Semesters</td><td class="cellpad" width="13%"><%=rs.getString(1)%></td></tr> 
                    <tr><td class="cellpad">Maximum number of Semesters</td><td class="cellpad"><%=MaxSemester%></td></tr>
                    <tr><td class="cellpad">Total Core Subjects </td><td class="cellpad"><%=Integer.parseInt(rs.getString(2))%></td></tr>
                    <tr><td class="cellpad">Total Elective Subjects</td><td class="cellpad"><%=Integer.parseInt(rs.getString(3))%></td></tr>
                    <tr><td class="cellpad">Total Labs</td><td class="cellpad"><%=Integer.parseInt(rs.getString(4))%></td></tr>
                    <tr><td class="cellpad">Total Optional Cores</td><td class="cellpad"><%=Integer.parseInt(rs.getString(5))%></td></tr>
                    <tr><td class="cellpad">Total Projects</td><td class="cellpad"><%=Integer.parseInt(rs.getString(6))%></td></tr>
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