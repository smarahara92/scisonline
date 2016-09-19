<%-- 
    Document   : aslink5
    Created on : 20 Mar, 2012, 1:12:25 PM
    Author     : khushali
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="dbconnection.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function checked1()
            {
                var prgm = document.getElementById("mySelect1").value;
                if (prgm === "-- Programme --") {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Select programme.";
                }
                else if (prgm === "New"){
                    parent.staff_left.location = "./new_grade_formula.jsp";
                    parent.staffaction.location = "./BalankPage2.jsp";
                }
                else {
                    parent.staffaction.location = "./GradeFormula.jsp?streamname="+prgm+"";
                    document.getElementById("errfn").innerHTML = "";
                    // window.document.forms["frm"].submit();
                }
            }
        </script>
    </head>
    <body>
        <%
            Calendar now = Calendar.getInstance();

            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            System.out.println("Current Month:" + month);
            System.out.println("Current Year:" + year);
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            ResultSet rs1 = null;
            ResultSet rs2 = null;



            String selected_prgm = request.getParameter("streamname");
            if(selected_prgm==null) selected_prgm=" ";
            
            String qry10 = "create table if not exists Other_schools(Name varchar(20),primary key(Name))";
            st1.executeUpdate(qry10);

            rs1 = st2.executeQuery("select Distinct(Programme_group) from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
            rs2 = st3.executeQuery("select * from Other_schools");

        %>  
        <form name="frm"  target="staffaction" method="POST">
            <input type="hidden" name="year" value="<%=year%>"/>
            <h3> Course of study: </h3>

            <table align="center">
                <tr>
                    <td>
                        <select valign="bottom" name="streamname" id="mySelect1" onchange="checked1();"> 
                            <option> -- Programme -- </option>
                            <%while (rs1.next()) {
                                    if (selected_prgm.equalsIgnoreCase(rs1.getString(1))) {
                            %>

                            <option selected="selected"><%=rs1.getString(1)%></option>

                            <%} else {%>

                            <option ><%=rs1.getString(1)%></option>

                            <%

                                }

                                while (rs2.next()) {
                                    if (selected_prgm.equalsIgnoreCase(rs2.getString(1))) {
                            %>

                            <option selected="selected"><%=rs2.getString(1)%></option>

                            <%} else {%>

                            <option ><%=rs2.getString(1)%></option>

                            <%

                                        }

                                    }
                                }
                            %>

                            <option>New</option>
                        </select>
                    </td>
                </tr>
            </table>

            &nbsp;
            <table align="center">
                <tr>
                    <td>
                        <div align="left" id="errfn" style="color: red"></div>
                    </td>
                </tr>
            </table>

        </form>

    </body>
</html>
