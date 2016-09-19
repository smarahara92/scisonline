<%-- 
    Document   : select_option_staffProjectMCA
--%>

<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
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
        <title> JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css.css"> 
        <script type="text/javascript">
            function link()
            {
                window.location.replace("projectRegistrationInterns2.jsp");
            }

            function validate1(a)
            {
                var t = a.id;
                // alert(t);
                var value = a.value;
                var k = a.id.substring(0, 4);

                var e = t.substring(t.length, t.length - 1);





                var stu1 = document.getElementById("stu1" + e).value;

                var stu2 = document.getElementById("stu2" + e).value;
                var stu3 = document.getElementById("stu3" + e).value;
                var e1 = document.getElementById("hid").value;
                //alert(e1);
                var l, l1;



                if ((stu1 !== "Select Student Id" && stu2 !== "Select Student Id" && stu1 === stu2))
                {

                    alert("duplicate entry!");
                    document.getElementById("stu2" + e).value = "Select Student Id";

                    return;
                }
                if ((stu1 !== "Select Student Id" && stu3 !== "Select Student Id" && stu1 === stu3))
                {
                    alert("duplicate entry!");

                    document.getElementById("stu3" + e).value = "Select Student Id";

                    return;

                }
                if ((stu2 !== "Select Student Id" && stu3 !== "Select Student Id" && stu2 === stu3))
                {
                    alert("duplicate entry!");
                    document.getElementById("stu3" + e).value = "Select Student Id";

                    return;

                }
                stu1 = document.getElementById("stu1" + e).value;

                stu2 = document.getElementById("stu2" + e).value;
                stu3 = document.getElementById("stu3" + e).value;

                if (stu1 === "Select Student Id" && k !== "stu1")
                {
                    alert("enter student1 before studnet2 and 3");
                    document.getElementById("stu2" + e).value = "Select Student Id";
                    document.getElementById("stu3" + e).value = "Select Student Id";
                    return;
                }
                else if (stu2 === "Select Student Id" && stu3 !== "Select Student Id")
                {
                    alert("enter student2 before studnet3");

                    document.getElementById("stu3" + e).value = "Select Student Id";
                    return;
                }
                if (stu1 === "Select Student Id" && k === "stu1")
                {

                    document.getElementById("stu2" + e).value = "Select Student Id";
                    document.getElementById("stu3" + e).value = "Select Student Id";
                    return;
                }

                for (l = 1; l <= e1; l++) {
                    for (l1 = 1; l1 <= 3; l1++) {

                        var stuu = document.getElementById("stu" + l1 + "" + l).value;

                        document.getElementById("stu" + l1 + "" + l).style.color = "";
                        if (stuu !== "Select Student Id" && stuu === value && t !== "stu" + l1 + "" + l) {

                            alert("duplicate entry!");

                            document.getElementById(t).value = "Select Student Id";
                            document.getElementById("stu" + l1 + "" + l).style.color = "red";
                            return;
                        }
                    }

                }

                //*****************************************************************
                var val = document.getElementById(a).value;
                alert(val);
                var emailRegEx = /[1-9][0-9]+(MC|mc)+(MT|mt|MB|mb|MI|mi|MC|mc)+[0-9][0-9]/;
                var val1 = a.value;

                if (val1 !== (""))
                {
                    // alert("Please enter a Student ID.")
                    //return false;

                    if (val1.search(emailRegEx) === -1 || val1.length > 8)
                    {

                        alert("Please enter a valid StudentId");
                        a.focus();
                        return false;
                    }
                    // To check for mca			   

                    var id = val1.substring(5, 6);
                    //alert(id);

                    if (id === "t" || id === 'b' || id === 'i')
                    {
                        alert("Please enter a MCA Student Id");
                        return false;
                    }


                }
                return true;

                //*****************************************************************
            } 
            
             function disableEnterKey(e)
            {
                var key;
	 
                if(window.event)
	          key = window.event.keyCode;     //IE
                else
                  key = e.which;     //firefox
	 	
                if(key === 13)
	          return false;
                else
	          return true;
            }

        </script>
    </head>
    <body bgcolor="#CCFFFF">


        <form  id="prfrm" name="prfrm" method="POST" onsubmit="" action="select_option_staffProjectMCA1.jsp">

            <%  Connection con = conn.getConnectionObj();
                String pyear = request.getParameter("batch");
                String stream = request.getParameter("stream");
              
                int flag = 0, id_count = 0; // id_count1 = 0, id_count2 = 0;
                

                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();

                try {
                    ResultSet rs2 = (ResultSet) st2.executeQuery(" select * from  MCA_Project" + "_" + pyear + "  where Allocated='no'");
            %>
            <table align="center" id="table1">

                <caption><h2>List of Projects</h2></caption>
                <th> Project Title </th> 
                <th>Student ID 1</th>
                <th>Student ID 2</th>
                <th>Student ID 3</th>


                <%  Statement st4 = con.createStatement();
                    Statement st5 = con.createStatement();
                    Statement st6 = con.createStatement();

                    
                    
                    //retrieving studnets from master table
                    //ResultSet rs12 = (ResultSet) st6.executeQuery("select * from MCA_" + pyear + "");
                    ResultSet rs12 = scis.studentListUnallocatedProject(stream, pyear);
                    while (rs2.next()) {
                        id_count++;           // For Student Id 1

                %>
                <tr>
                    <%                        flag = 1;

                    %>

                <input type="text" value="<%=rs2.getString(1)%> " hidden readonly id="pid1" name="pid" size="3" > 
                <input type="text" value="<%=pyear%> " hidden readonly id="pid1" name="streamYear" size="3" > 

                <td><input type="text" value="<%=rs2.getString(2)%>"  readonly id="pid1" name="pname" size="50" onKeyPress="return disableEnterKey(event)"></td>


                <td><select name="sid1" id=stu1<%=id_count%> onchange="validate1(this);">
                        <option>Select Student Id</option>
                        <%while (rs12.next()) {
                        %>
                        <option value="<%=rs12.getString(1)%>" ><%=rs12.getString(1)%></option>
                        <%}
                            rs12.beforeFirst();
                        %>
                    </select>
                </td>

                <td>
                    <select name="sid2" id=stu2<%=id_count%> onchange="validate1(this);">
                        <option>Select Student Id</option>
                        <%while (rs12.next()) {
                        %>
                        <option value="<%=rs12.getString(1)%>"><%=rs12.getString(1)%></option>
                        <%}
                            rs12.beforeFirst();
                        %>
                    </select>
                </td>
                <td>
                    <select name="sid3" id=stu3<%=id_count%> onchange="validate1(this);">
                        <option>Select Student ID</option>
                        <%while (rs12.next()) {
                        %>
                        <option value="<%=rs12.getString(1)%>"><%=rs12.getString(1)%></option>
                        <%}
                            rs12.beforeFirst();
                        %>
                    </select>
                </td>
                </tr>
                <%
                    }

                    if (flag == 0) {%>

                <script type="text/javascript" language="javascript">
                    link();
                </script>
                <%                    }

                %>  

            </table>&nbsp;&nbsp;
            <input type="hidden" id="hid" value="<%=id_count%>">

            <div align="center"><input type="submit" value="submit"/></td></div>

            <%  rs2.close();
                st4.close();
                st5.close();
                st6.close();
                } catch (Exception ex) {%>
            <h2>Please register the Projects first.</h2>
            <%

                    ex.printStackTrace();

                } 
                st2.close();
                st3.close();
            %>

            <%String user = (String) session.getAttribute("user");
              conn.closeConnection();
              con = null;


            %>
            <!--  Welcome <%=user%>-->

        </form>

    </body>
</html>



