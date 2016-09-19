<%-- 
    Document   : projectStaffChangeSupervisorMCA
    Created on : 20 May, 2013, 9:40:54 AM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>
        <link rel="stylesheet" href="table_css1.css" type="text/css">
        <script type="text/javascript">

            function validate()
            {
                var x = document.getElementById("rb").value;

                if (x == null)
                {
                    alert("Please Choose a Project.");
                    return false;
                }

                return true;
            }

            function check1(q)
            {


                var id = q;
                alert(id + " is not assigned any project.");
                //alert("The selected Student is currently not assigned any Project.")
                history.back();
                return false;

            }

            function check2(q)
            {
                var id = q;
                alert(id + " is an Internship Student.");
                history.back();
                //alert("The selected Student is currently not assigned any Project.")
                //window.location.replace("projectStaffModify.jsp");
            }



            function ChangeSupRB()
            {

                var val = document.getElementById("rb").value;
                if (val = (""))
                {
                    alert("Please Choose a Project.");
                    return false;
                }

            }

            function unallocated()
            {
                alert("There are no Unallocated Projects currently.");
                history.back();
            }

            //#####################################################################################      
        </script>    


    </head>
    <body>

        <%

            String cBox = request.getParameter("r");         // 1. Change Sup 
            session.setAttribute("Combo", cBox);            // whether it is change sup or new internship.
            String StudId = request.getParameter("sid");
            String branchYear = request.getParameter("branchYear");
            System.out.println(branchYear);
            // System.out.println(cBox);
            int pyear = scis.studentBatchYear(StudId);
            Connection con = conn.getConnectionObj();
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st7 = con.createStatement();


            ResultSet rs2 = null;

            try {
                rs2 = (ResultSet) st2.executeQuery("select * from  MCA_Project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from MCA_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "' )");    // Indicates some project is allocated to the student.
            } catch (Exception ex) {%>
        `		   <center><h2>The Projects are not yet allocated.</h2></center>
        <%
                ex.printStackTrace();
                return;
            }

            ResultSet rs4 = (ResultSet) st4.executeQuery("select * from  MCA_Project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from MCA_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "' ) and a.Organization<>'uoh'"); // Student doing Internship.
            ResultSet rs5 = (ResultSet) st5.executeQuery("select * from  MCA_Project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from MCA_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "') and a.Organization='uoh'");  // Student doing project in Univ.
            ResultSet rs6 = (ResultSet) st6.executeQuery("select * from  MCA_Project" + "_" + pyear + " as a where a.ProjectId not in(Select b.ProjectId from MCA_Project_Student_" +pyear + " as b where b.ProjectId<>'null' ) and a.Organization='uoh'");  // List of Unallocated Projects

            //Means that the student is allocated a project 
            // select a.ProjectId from Mtech_project_2013 as a where a.ProjectId not in(Select b.ProjectId from project_student_data as b); 

            String table = "";

            table = "MCA" + "_" + pyear;

            ResultSet rs3 = (ResultSet) st3.executeQuery("select StudentName from " + table + " where StudentId='" + StudId + "'");
            String Name = "";
            while (rs3.next()) {
                System.out.println(rs3.getString(1));
                Name = rs3.getString(1);
            }



            // Checking if a Student is not allocated any project for  change sup .                                                   
            if ("cs".equals(cBox)) {
                if (rs2.next() != true) {%>
    <script type="text/javascript" language="javascript">
        check1('<%=StudId%>');
        // alert("hiiiiiii");
    </script>   

    <%
                return;
            }

        }

//out.println(cBox + "        ");
        rs2.beforeFirst();

        while (rs2.next()) {


            session.setAttribute("ProjectIdOld", rs2.getString(1));   // Backing up this original student id which is getting to be changed later on.

            // Checking for an internship doing student for Change Supervisor         
            if (!rs2.getString(6).equals("uoh") && "cs".equals(cBox)) {

    %>
    <script type="text/javascript" language="javascript">
        check2('<%=StudId%>')
    </script>
    <%

    } //**************************Logic for Change Supervisor***********************************
    else if ("cs".equals(cBox)) {
        //out.println(cBox + "        ");
        if (rs2.getString(6).equals("uoh")) {

    %>

    <form  id="form" method="POST" onsubmit="return validate();" action="projectStaffChangeSupervisorMCA1.jsp">

        <table align="center">

            <th>Student ID </th> 
            <th>Student Name</th>
            <tr>
                <td><input type="text" id="stid" name="stid"  readonly value="<%=StudId%>" size="8" maxlength="8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><input type="text" id="sid1" name="sname" readonly value="<%=Name%>" size="25"></td>
            </tr>

        </table>         
        &nbsp;&nbsp;
        <input type="hidden" name="branchYear" value="<%=branchYear%>">

        <table align="center" border="1" class="table"> 

            <caption><h4>Unallocated Projects</h4></caption>
            <th class="th">Supervisor Name</th>&nbsp;
            <th class="th">Project Title</th>
                <%

                    //----------New Modification---------
                    if (!rs6.next() == true) {%>
            <script type="text/javascript" language="javascript">
        unallocated();

            </script>   
            <% }

                rs6.beforeFirst();


                while (rs6.next()) {
                    ResultSet rs = st1.executeQuery("select Faculty_Name from faculty_data where ID='" + rs6.getString(3) + "'");
                    if (rs.next()) {
                        session.setAttribute("newSupervisor", rs6.getString(3));
            %>

            <tr>
                <td class="td">
                    <input type="radio" id="rb" name="rb"  value="<%=rs6.getString(1)%>"><%=rs.getString(1)%> 
                </td>
                <td class="td"><%=rs6.getString(2)%></td>
            </tr>  

            <%} 
                    rs.close();
                }%>

        </table>&nbsp;&nbsp;&nbsp;

        <%
                    }

                }

            }

        %>
        <table align="center">
            <tr>
                <td> <input type="submit" value="Submit" class="Button"></td></td>
            </tr>
        </table>
        <%
            st1.close();
            st2.close();
            st3.close();
            st4.close();
            st5.close();
            st6.close();
            st7.close();
            rs2.close();
            rs3.close();
            rs4.close();
            rs5.close();
            rs6.close();
            conn.closeConnection();
            con = null;
            scis.close();
        %>

    </form>
</body>
</html>