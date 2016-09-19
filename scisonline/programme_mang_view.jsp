<%-- 
    Document   : programme_mang_view
    Created on : Aug 28, 2013, 3:22:45 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .caption{
                font-weight: bold;
            }

            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .heading1
            {
                color: white;
                background-color:#003399;
            }
            .td1
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;

            }

            .td2
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
                color: #003399;
            }
            .td3
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: blue;
                padding: 4px;
            }


        </style>
        <script type="text/javascript">

            function action2() {
                
                i = 0;
                if (form3.pname.value === 'Select Programme') {
                    i++;
                    document.getElementById('errfn').innerHTML = "*Please select Programme name.";
                    document.getElementById("pn1").focus();
                } else if (form3.year.value === 'Select Year') {
                    i++;
                    document.getElementById('errfn').innerHTML = "*Please select Year.";
                    document.getElementById("yr").focus();
                }
                if (i === 0) {
                    document.getElementById('errfn').innerHTML = "";
                    action1();
                }
            }
            function action1()
            {
                if (form3.pname.value === 'PhD') {
                    document.form3.action = "programme_mang_viewlink2.jsp";
                    document.form3.submit();
                } else {
                    document.form3.action = "programme_mang_viewlink1.jsp";
                    document.form3.submit();
                }
            }
        </script>
    </head>
    <body>
        <%
            try {
                ResultSet rs1 = null;
               
                rs1 =scis.getProgramme();
                
        %>
        
        <form name="form3" target="pgmview">
            <table align="center">
                <td>
                    
                    <select name="pname" onclick="count++;" id="pn1" onchange="action2();">
                        <option>Select Programme</option>
                        <%
                            int p = 2001, cyear1;
                            Calendar now = Calendar.getInstance();
                            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                                    + "-"
                                    + now.get(Calendar.DATE)
                                    + "-"
                                    + now.get(Calendar.YEAR));
                            int cyear = now.get(Calendar.YEAR);
                            cyear1 = cyear + 3;
                            while (rs1.next()) {
                                String pgrm = rs1.getString(1);
                                 System.out.print(pgrm);
                                pgrm = pgrm.replace('_', '-');
                        %>
                        <option><%=pgrm%></option>
                        <%}%>
                    </select>
                </td>
                <td><select name="year" id="yr" onchange="action2();">
                        <option>Select Year</option>
                        <%while (cyear1 >= p) {
                                                %>
                        <option><%=cyear1%></option>
                        <% cyear1--;
                            }%>
                        <option>All</option>
                    </select></td>
            </table>
            <table align="center">
                <tr>
                    <td><div class="style30" id="errfn"></div></td>
                </tr>
            </table>&nbsp;
        </form>
        <%
                rs1.close();
            } catch (Exception e) {
               
                System.out.println(e);
            } 
        %>
    </body>
</html>
