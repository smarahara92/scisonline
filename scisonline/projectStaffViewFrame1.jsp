
<%-- 
    Document   : projectStaffViewFrame1
    Created on : 12 Jun, 2013, 9:35:08 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.util.*"%>
<%    String url = "http://172.16.88.50:8084/AttendanceSystem/";
%>
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
                // alert(q);
                if (q === "")
                {
                    alert("Please choose a Stream");
                }


                else if (q === "faculty")
                {
                    parent.act_area.location = "./proj_view_staff.jsp?branch=" + q;

                }

                else if (q === "stream")
                {
                    //alert(q);
                    parent.act_area.location = "./select_option_staffViewStreamFrame.jsp?branch=" + q;
                } else if (q === "project")
                {
                    //alert(q);
                    parent.act_area.location = "./student_projects.jsp";
                }


            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert title here</title>
    </head>
    <body bgcolor="#CCFFFF">

        <table>

            <tr>
                <td> <font color="#c2000d"><b>Choose By</b></font></td> 

                <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="r" name="r" value="faculty"  onclick="to(this.value);"  >Faculty </td>
                <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="r" name="r" value="stream"  onclick="to(this.value);"  >Stream </td>
                <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="r" name="r" value="project"  onclick="to(this.value);"  >Unallocated Projects </td>

            </tr>           

        </table>

    </body>
</html>
