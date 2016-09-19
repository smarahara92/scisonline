<%-- 
    Document   : deleteFacultyLink1.jsp
    Created on : 19 Nov, 2012, 6:28:11 PM
    Author     : varun
--%>

<%@page import="java.util.Calendar"%>
<%@include file="checkValidity.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp"%>


<!DOCTYPE html>



<html>
    <head>
        <style>
            .style30 {color: red}
            .style31 {color: white}
            .style32 {color: green}
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>

            function find(v)
            {
                var i;

                //alert(v);
                for (i = 0; i < v; i++)
                {
                    //alert(i);
                    var j = document.getElementById("reassign" + i).value;
                    //alert(j);
                    var k = document.getElementById("csel" + i).value;
                    //alert(k);
                    var l = document.getElementById("subid" + i).value;
                    //alert(l);
                    if (j == "Reassign")
                    {
                        if (k == "None")
                        {
                            alert("Please Reassign a Faculty for " + l);
                            return false;
                        }
                    }

                    if (j == "None")
                    {
                        alert("Please choose Reassign/Drop for " + l);
                        return false;
                    }

                }
            }

            function check(a)
            {

                if (a == 0) {
                    form.action = "deleteFacultyLink2.jsp";

                } else if (a == 1) {

                    form.action = "deleteFacultyMtechMcaProject.jsp";
                }
            }
            function check1(c, d)
            {
                var fac = c;  // New Faculty
                var old = d;  // Old Faculty

                //alert(fac);
                //alert(old);

                if (fac == old)
                {
                    alert("The Faculty to be deleted cannot be reassigned.");
                    document.getElementById("xx").disabled = true;
                }
                //document.getElementById("xx").disabled=false;
                if (fac != old)
                {
                    //alert("The Faculty to be deleted cannot be reassigned.");
                    document.getElementById("xx").disabled = false;
                }
            }

            function drop(b, c)
            {
                //alert(c);
                var val = b;

                //alert(j);
                if (val == "Drop")
                {

                    document.getElementById("csel" + c).disabled = true;
                }

                else if (val == "Reassign")
                {

                    document.getElementById("csel" + c).disabled = false;
                }
            }
        </script>


    </head>
    <body bgcolor="#E0FFFF" onload="onload1();">
        <%            try {
                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                int year3 = year;
                int month = now.get(Calendar.MONTH);
                String semester = "";
                if (month <= 6) {
                    semester = "Winter";
                    year3 = year3 - 1;
                } else {

                    semester = "Monsoon";

                }
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                String query = null;
                ResultSet rs1 = null;

                String oldfaculty = (String) session.getAttribute("oldfaculty");
                try {
//                    query = "Select * from faculty_data";
//                    //rs1 = st1.executeQuery(query);
                    rs1=scis.facultyList();
                } catch (Exception ex) {

                    System.out.println(ex);
        %>
        <script>


            window.open("Project_exceptions.jsp?check=6", "subdatabase");
        </script>    
        <%                    return;

            }

            ArrayList b = (ArrayList) session.getAttribute("arraylist");
            HashMap<String, String> hmap = (HashMap) session.getAttribute("hashmap");

            Collection<String> collection = hmap.values(); // Dumping HashMap into Collection
            Iterator it = collection.iterator();


        %>

        <form name="form"  method="post" onSubmit="return find('<%=hmap.size()%>')">
            <%
                if (hmap.isEmpty() != true) {
            %>
            <center><h2 style=" color: darkred">Reassign/Drop Subjects</h2></center>

            <table align="center">

                <th>Subject Name</th>
                <th>Reassign / Drop</th>
                <th>Faculty</th>
                    <%
                        for (int i = 0; i < hmap.size(); i++) {
                            // Checking if the course is Core/Elective using the contents of ArrayList.
                            String query1 = "Select type,Subject_Name from subjecttable where Code='" + b.get(i) + "'";
                            ResultSet rs2 = st2.executeQuery(query1);
                           

                            System.out.println(b.get(i) + "nowwwwwwwww");  // Array List Contents

                            while (rs2.next()) {

                                //  If the chosen subject is a Core..
                                if (rs2.getString(1).equals("C")) {
                                    System.out.println("Core Subject selected");

                    %><tr>

                    <td> <input readonly name="subid" id="subid<%=i%>" value="<%=rs2.getString(2)%>" style="width:300px"></td>
                    <td><input readonly id="reassign<%=i%>" name="reassign" value="Reassign" width="10" size="13.5"></td>
                    <td><select  name="csel<%=i%>" id="csel<%=i%>" onchange="check1(this.value, '<%=oldfaculty%>')" >
                            <option value="None">None</option>
                            <%
                                String subCode = null;
                                try {

                                    rs1.beforeFirst();
                                    ResultSet rs11 = (ResultSet) st3.executeQuery("select NewFac from  Temp_Reassign_Subject_" + year + " where SubjectId='" + b.get(i) + "'");
                                    if (rs11.next()) {
                                        subCode = rs11.getString(1);
                                    }
                                } catch (Exception ex) {
                                    ex.printStackTrace();
                                }
                                System.out.println(subCode);
                                while (rs1.next()) {
                                    if (subCode != null && subCode.equalsIgnoreCase(rs1.getString(1))) {
                            %>
                            <option value="<%=rs1.getString(1)%>" selected="yes"><%=rs1.getString(2)%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
                            <%}
                                }

                            %>


                        </select></td>
                </tr>
                <% } // Else if the chosen subject is elective
                else if (rs2.getString(1).equals("E")) {

                %><tr>

                    <td> <input readonly name="subid" id="subid<%=i%>" value="<%=rs2.getString(2)%>" style="width:300px"></td>
                    <td><select  name="sel11<%=i%>" id="reassign<%=i%>" onchange="drop(this.value, '<%=i%>')" style="width:175px">
                            <%
                                String subCode = null;
                                ResultSet rs11 = null;
                                int flag = 0;
                                try {

                                    rs1.beforeFirst();
                                    rs11 = (ResultSet) st3.executeQuery("select NewFac,Reassign from  Temp_Reassign_Subject_" + year + " where SubjectId='" + b.get(i) + "'");
                                    if (rs11.next()) {
                                        subCode = rs11.getString(1);
                                        flag++;
                                    }
                                } catch (Exception ex) {
                                    ex.printStackTrace();
                                }
                                if (flag > 0 && rs11.getString(2).equalsIgnoreCase("yes")) {
                            %>
                            <option value="None">None</option>
                            <option value="Reassign" selected="yes">Reassign</option>
                            <option value="Drop">Drop</option>
                            <%
                            } else if (flag > 0 && rs11.getString(2).equalsIgnoreCase("no")) {
                            %>
                            <option value="None">None</option>
                            <option value="Reassign">Reassign</option>
                            <option value="Drop" selected="yes">Drop</option>
                            <%
                            } else {
                            %>
                            <option value="None">None</option>
                            <option value="Reassign">Reassign</option>
                            <option value="Drop">Drop</option>
                            <%
                                }
                            %>



                        </select></td>

                    <td><select  name="esel<%=i%>" id="csel<%=i%>" onchange="check1(this.value, '<%=oldfaculty%>')">
                            <option value="None">None</option>
                            <%

                                while (rs1.next()) {
                                    if (subCode != null && subCode.equalsIgnoreCase(rs1.getString(1))) {
                            %>
                            <option value="<%=rs1.getString(1)%>" selected="yes"><%=rs1.getString(2)%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
                            <%}
                                }

                            %>



                        </select></td>
                </tr>
                <%                            }
                        }  // While closing
                    }%>                   
            </table>
            <%} else {
            %> 
            <h2 align="center"> The selected faculty is not teaching any Subject.</h2> 
            <table align="center">
                <tr>
                <br>
                <td > <input type="submit" id="xx" value="Continue" onClick="check(1)"> </td>

                </tr>
            </table>
        </form> 
        <% return;
            }

        %>
        <script>
            function onload1() {
                document.getElementById("xx1").focus();
            }

            function Cancelto() {
                window.open("deleteFaculty.jsp", "subdatabase");//here check =6 means error number (if condition number.)
            }
        </script> 
        <table align="center">
            <tr>
            <br>
            <td> <input type="button" id="xx1" value="Cancel" onclick="Cancelto();">&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td > <input type="submit" id="xx" value="Continue" onClick="check(0)"> </td>

        </tr>
    </table>
</form>    
<%            } catch (Exception e) {
        System.out.println(e);
    }
%>
</body>
</html>
