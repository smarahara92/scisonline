<%-- 
    Document   : list1staff
    Created on : 8 May, 2015, 3:43:52 PM
    Author     : nwlab
--%>

<%@include file="checkValidity.jsp"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {width:300px}
        </style>
        <link rel="stylesheet" type="text/css" href="button.css">

        <script type="text/javascript">


            function checked()
            {
                parent.facultyaction.location = "./BalankPage2.jsp";
                var selectlist = document.getElementById("mySelect1");
                var type = selectlist.options[selectlist.selectedIndex].id;

                var subname = selectlist.options[selectlist.selectedIndex].text;

                if (subname === "Select Subject")
                {
                    parent.facultyaction.location = "./BalankPage2.jsp";
                    parent.triggering.location = "./BalankPage2.jsp";
                } else {
                    var value = selectlist.options[selectlist.selectedIndex].value;
                    if (type === "s") {

                        window.document.forms["frm"].action = "triggering.jsp?subjectname=" + subname + "&subjectid=" + value + "&type=" + type;
                        document.frm.submit();
                    } else {

                        window.document.forms["frm"].action = "triggering.jsp?subjectname=" + subname + "&subjectid=" + value + "&type=" + type;
                        document.frm.submit();
                    }

                }
            }
        </script>
    </head>
    <body>
        <% //String csubj;
            String username = (String) session.getAttribute("user");
            if (username == null) {
                username = "";
            }
            System.out.println(username);

            Calendar now = Calendar.getInstance();

            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            if (month <= 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }
               Connection con = conn.getConnectionObj();
            try {
                String qry2 = "select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subject_faculty_" + semester + "_" + year + ")";

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(qry2);
                ResultSet rs1 = scis.getStream("PhD");
                List subj = new ArrayList();
                int i = 0;
        %>
        <form name="frm" target="triggering" method="POST">
            <select align="left" valign="bottom" style="width:250px" name="subjectname" id="mySelect1" onchange="checked();"> 
                <option id="s">Select Subject</option>
                <%  while (rs.next()) {
                    %> <option value="<%=rs.getString(1)%>" id="s" onclick="checked();"> <%=rs.getString(2)%> </option> <%

                    }
                    while (rs1.next()) {
                %> <option value="<%=rs1.getString(1)%>" id="p" onclick="checked();"><%=rs1.getString(1)%> Project</option> <%
                    }
                %>     
                <br> 
                <br>
               

        </form>
        </br>
        <br>

        <!--<input type="Submit" value="Go">-->

        <%   } catch (Exception e) {
                out.println(e);
            }finally{
                conn.closeConnection();
                con = null ;
            }

        %>
    </body>
</html>
