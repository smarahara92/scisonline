<%-- 
    Document   : deleteFacultyPhDProject
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <script type="text/javascript">

            function validate(b)      // Checking if all checkBoxes are ticked or not..
            {
                var hmapSize = b;
                //alert(b);

                var i;
                for (i = 0; i < hmapSize; i++)
                {
                    //alert("varun");
                    var a = document.getElementById(i).checked;
                    //alert(a);
                    if (a == false)
                    {
                        alert("Some Project Students are not reassigned");
                        //document.getElementById("xx").disabled=true;
                        return false;
                    }
                }
                //document.getElementById("xx").disabled=false;
                return true;

            }

            function link1(a, c)
            {
                //alert(a);
                if (c == true)
                    window.open("deleteFacultyPhDProject1.jsp?studentid=" + a, "_blank", "directories=no, status=no, menubar=no, scrollbars=yes, resizable=no,width=900, height=200,top=230,left=300");

                // myWindow = window.open("deleteFacultyPhDProject1.jsp?studentid=" + a, menubar = "no", toolbar = "no", width = 600, height = 700, alwaysRaised = 'yes');
                //window.location.replace("BlankPage.jsp");
            }

        </script>	
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>
    </head>
    <body bgcolor="#E0FFFF" onload="onload1();">

        <%
            Connection con = conn.getConnectionObj();
            Connection con2 = conn2.getConnectionObj();
        
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st4 = con2.createStatement();
            Statement st5 = con2.createStatement();
            Statement st6 = con2.createStatement();
            Statement st7 = con2.createStatement();
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH);
            ResultSet rs3 = null;
            int rowcount = 0;
            String semester = "";
            if (month <= 6) {
                semester = "Winter";
                year = year - 1;
            } else {

                semester = "Monsoon";

            }
            String oldfaculty = (String) session.getAttribute("oldfaculty");
             String facName = oldfaculty;
            //--------------------------

            try {
                PreparedStatement pst = con.prepareStatement("select Faculty_Name from  faculty_data where ID=?");
                pst.setString(1, oldfaculty);
                ResultSet rss6 = (ResultSet) pst.executeQuery();
               
                if (rss6.next()) {
                    facName = rss6.getString(1);
                }
                rs3 = (ResultSet) st2.executeQuery("select * from PhD_" + year + " where supervisor1='" + oldfaculty + "'  or supervisor2='" + oldfaculty + "' or supervisor3='" + oldfaculty + "' or drc1='" + oldfaculty + "' or drc2='" + oldfaculty + "'  ");

                //------Counting the Result Set rs3 Elements-------
                rowcount = 0;
                if (rs3.last()) {
                    rowcount = rs3.getRow();

                }

                rs3.beforeFirst();

                //-------------
            } catch (Exception e) {
        %>
        <h3 align="center">There are currently no Ph.D. students under <%=facName%>.</h3>
        <%
            }
        %>
        <form  id="form" method="POST"  action="deleteFacultyFinal.jsp" onSubmit="return validate('<%=rowcount%>')">

            <%
                //****************************************************************************

                try {

                    if (!rs3.next()) {%>
            <h3 align="center">There are currently no Ph.D. students under <%=facName%>.</h3>
            <%} else {%>
            <table align="center" border="1">
                <caption><h3 style=" color: darkred">Reassign Ph.D. Project Students</h3></caption>
                <th> </th> 
                <th>Student Id</th> 
                <th>Student Name</th> 
                <th>Thesis Title </th> 
                <th>&nbsp;Supervisor 1</th>
                <th>&nbsp;Supervisor 2</th>
                <th>&nbsp;Supervisor 3</th>
                <th>&nbsp;DRC Member 1</th> 
                <th>&nbsp;DRC Member 2</th> 

                <% }

                    rs3.beforeFirst();
                    int rb = 0;

                    while (rs3.next()) {
                        int projectId = 0;
                        String code = "";                 // Respective Branch Project Student Data Table  
                        String table = "";
                        String masterProjectTable = "";   // Master table of Projects
                        String studId = rs3.getString("StudentID");
                        studId = studId.toUpperCase();
                        String Name = rs3.getString("StudentName");

                %>

                <tr>
                    <%                        // If case true then disabling the checkbox indicating that Co-Supervisors are present..
                        if ((rs3.getString("supervisor1") != null && rs3.getString("supervisor2") != null) || (rs3.getString("supervisor2") != null && rs3.getString("supervisor3") != null) || (rs3.getString("supervisor1") != null && rs3.getString("supervisor3") != null)) {

                            if ((oldfaculty.equals(rs3.getString("drc1"))) || (oldfaculty.equals(rs3.getString("drc2")))) {  //disabled="true" checked="true"
%>
                    <td><input type="checkbox" id="<%=rb++%>" name="rb" value="" disabled="true" checked="true"></td>
                        <%
                            }
                        %>
                    <td><input type="checkbox" id="<%=rb++%>" name="rb" value="" disabled="true" checked="true"></td>
                        <%

                        } else {%>
                    <td><input type="checkbox" id="<%=rb++%>" name="rb" value="" onchange="link1('<%=rs3.getString(1)%>', this.checked)"></td>
                        <%}%>	

                    <td><input type="text" value="<%=studId%>" readonly id="sid" name="pid" size="8" ></td>
                    <td><input type="text" value="<%=Name%>" readonly id="sname" name="sname" size="12" ></td>
                    <td><input type="text" value="<%=rs3.getString("thesistitle")%>"  readonly id="thesis" name="thesis" size="30"></td>

                    <%if (rs3.getString("supervisor1") != null) {
                    %>
                    <td><input type="text" value="<%=rs3.getString("supervisor1")%>"  readonly id="sup1" name="sup1" size="8"></td>
                        <%} else {%>
                    <td><input type="text" value=""  readonly id="sup1" name="sup1" size="8"></td>
                        <%}

                            if (rs3.getString("supervisor2") != null) {%>
                    <td><input type="text" value="<%=rs3.getString("supervisor2")%>"  readonly id="sup2" name="sup2" size="8"></td> 
                        <%} else {%>
                    <td><input type="text" value=""  readonly id="sup2" name="sup2" size="8"></td>
                        <%}

                            if (rs3.getString("supervisor3") != null) {%>
                    <td><input type="text" value="<%=rs3.getString("supervisor3")%>"  readonly id="sup3" name="sup3" size="8"></td>
                        <%} else {%>
                    <td><input type="text" value=""  readonly id="sup3" name="sup3" size="8"></td>
                        <%}

                            if (rs3.getString("drc1") != null) {%>
                    <td><input type="text" value="<%=rs3.getString("drc1")%>"  readonly id="sup3" name="sup3" size="8"></td>
                        <%} else {%>
                    <td><input type="text" value=""  readonly id="sup3" name="sup3" size="8"></td>
                        <%}

                            if (rs3.getString("drc2") != null) {%>
                    <td><input type="text" value="<%=rs3.getString("drc2")%>"  readonly id="sup3" name="sup3" size="8"></td>
                        <%} else {%>
                    <td><input type="text" value=""  readonly id="sup3" name="sup3" size="8"></td>
                        <%}%>
                </tr>

                <%

                        }
                    } catch (Exception e) {
                    }

                %>   

            </table> 
            <br>
            <script>
                function onload1() {
                    document.getElementById("xx1").focus();
                }

                function Cancelto() {
                    window.open("deleteFaculty.jsp", "subdatabase");//here check =6 means error number (if condition number.)
                }
            </script> 

            <div align="center"> <input type="button" id="xx1" value="Cancel" onclick="Cancelto();">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <input type="submit" id="xx" value="Continue" onClick="check(0)"> </div>


        </form>
        <%
          conn.closeConnection();
          con = null;
          conn2.closeConnection();
          con2 = null;
        %>


    </body>
</html>
