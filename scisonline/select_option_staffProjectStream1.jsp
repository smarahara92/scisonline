<%-- 
    Document   : select_option_staffProjectStream1
--%>

<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
        </style>
        <script type="text/javascript">

            function to(q)
            {
                if (q === "none")
                    alert("Please choose a Faculty name.");
                else
                {
//                    parent.left.location = "select_option_staffProjectStream1.jsp?fid=" + q;
                    parent.act_area.location = "select_option_staffProjectStream2.jsp?fid=" + q;
                }
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert title here</title>
    </head>
    <body bgcolor="#CCFFFF">
        <%  
            
            String streamName = (String) session.getAttribute("projectStreamName");
            String streamYear = (String) session.getAttribute("projectStreamYear");

            ResultSet rs =scis.facultyList();
            String fid = request.getParameter("fid");

        %>

        <table>
            <%try {%>    
            <tr> <td><font><b>Choose Faculty :</b></font></td></tr>
            <tr>

                <td><select id="sel" name="sel" onchange="to(this.value)"> 
                        <option value="none">none</option>
                        <% while (rs.next()) {
                                if (rs.getString(1).equals(fid)) {
                        %> <option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%> </option>
                        <%  } else {
                        %>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%> </option>
                        <%
                                }
                            }%>
                    </select>
                </td>		

        </table>
        <%
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            rs.close();
            scis.close();
        %>
    </body>
</html>
