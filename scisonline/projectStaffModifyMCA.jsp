<%-- 
    Document   : projectStaffModifyMCA
    Created on : 19 May, 2013, 7:07:57 PM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%-- 
    Document   : projectStaffModifyMtech
    Created on : 18 Mar, 2013, 5:40:35 PM
    Author     : varun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css1.css">
        <script type="text/javascript">

            function validate(branch)
            {
                //alert(branch);
                var emailRegEx = /[0-9][0-9]+(MC|mc)+(MT|mt|MB|mb|MI|mi|MC|mc)+[0-9][0-9]/;
                var val = document.getElementById("StudId").value;
                if (val === (""))
                {
                    alert("Please enter a Student ID.")
                    return false;
                }
                if (val.search(emailRegEx) === -1 || val.length > 8)
                {

                    alert("Please enter a valid Student ID.");

                    document.getElementById("StudId").focus();
                    return false;
                }

                var id = val.substring(5, 6);   // to check for mca
                //alert(id);

                if (id === "t" && branch === "mca")
                {
                    alert("Please enter a MCA Student Id");
                    return false;
                }


                return true;

            }

            function link()
            {
                //var x=document.getElementById("StudId").value;
                //alert(x);
                document.form1.action = "projectStaffChangeSupervisorMCA.jsp";
            }

            function link1()
            {
                document.form1.action = "projectStaffNewInternshipMCA.jsp";
            }


        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <% String branch = request.getParameter("branch");  // mca or mtech
            //out.println(branch);	
%>

        <form  id="form" name="form1"  action="" onsubmit="return validate('<%=branch%>');">

            <table align="center">
                <caption style=" color: #c2000d;"><h2>Modify Project</h2></caption>
                <tr> <td><input type="radio" name="r" value="cs" class="Button" onChange="link();">Change Supervisor&nbsp;&nbsp;&nbsp;</td>&nbsp;&nbsp;&nbsp;

                    <td><input type="radio" name="r" value="ni" class="Button" onChange="link1();">New Internship</td>&nbsp;</tr>
                <tr><td><br></td></tr>
                                               
                <%
                    Connection con = conn.getConnectionObj();
                    
                    Statement st = con.createStatement();
                    Statement st1 = con.createStatement();
                    Statement st2 = con.createStatement();
                    String pyear = request.getParameter("year");
                    //******************************************************************************
                    ResultSet rs2 = st2.executeQuery("select * from MCA_" + pyear + "");

                %>
                <tr>
                    <td colspan="2" align="center">Student ID:
                        <select name="sid">
                            <option>Select Student ID</option>
                            <%while (rs2.next()) {
                                    System.out.println("iam here" + rs2.getString(1));
                            %>
                            <option><%=rs2.getString(1)%></option>
                            <%}
                            %>
                        </select>
                   </td>
                </tr>

            </table>
            &nbsp;&nbsp;
            <table align="center">
                <input type="hidden" name="branchYear" value="<%=pyear%>">
                <tr>
                    <td><input type="submit" value="Submit" class="Button"></td>
                </tr>
            </table>
                    <%
                        st.close();
                        st2.close();
                        st1.close();
                        rs2.close();
                        conn.closeConnection();
                        con = null;
                    %>
        </form>

    </body>
</html>