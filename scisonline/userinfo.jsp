<%-- 
    Document   : userinfo
    Created on : May 27, 2014, 4:08:31 PM
    Author     : veeru
--%>
<%@ include file="dbconnection.jsp" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css" media="all" />
        <link rel="stylesheet" type="text/css" href="demo.css" media="all" />
        <link rel="stylesheet" href="calendarview.css">
        <script src="prototype.js"></script>
        <script src="calendarview.js"></script>
        <script>
            function setupCalendars() {
                // Embedded Calendar
                Calendar.setup(
                        {
                            dateField: 'popupDateField',
                            triggerElement: 'popupDateField'
                        }
                )


                // Popup Calendar

            }

            Event.observe(window, 'load', function() {
                setupCalendars()
            })
            function onsub()
            {
                var uid=document.getElementById("uid").value;
                var uname=document.getElementById("name").value;
                if(uid==="" || uname==="")
                {
                    alert("Enter user Id");
                    return false;
                }
                
            }
            
        </script>
        <style>
            body {
                font-family: Trebuchet MS;
            }
            div.calendar {
                max-width: 240px;
                margin-left: auto;
                margin-right: auto;
            }
            div.calendar table {
                width: 100%;
            }
            dateField {
                width: 140px;
                padding: 6px;
                -webkit-border-radius: 6px;
                -moz-border-radius: 6px;
                color: #555;

                background-color: #F8F8F8;

                -align: center;
            }
            div#popupDateField:hover {
                background-color: #cde;
                cursor: pointer;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <%            String userId = request.getParameter("userId");
            if (userId == null) {
                userId = "";
            }
            PreparedStatement pst = null;
            String role = null;
            ResultSet rs = null;
            String userName = null;
            String userName2 = "";
            String userName1 = null;
            try {

                try {
                    userName = scis.facultyName(userId);
                } catch (Exception e) {
                }
                try {
                    userName1 = scis.studentName(userId);
                } catch (Exception e) {
                }

                if (userId.equalsIgnoreCase("Admin")) {
                    role = "admin";
                    userName2 = "Admin";
                } else if (userId.equalsIgnoreCase("staff")) {
                    role = "staff";
                    userName2 = "staff";
                } else if (userName != null) {
                    role = "faculty";
                    userName2 = userName;
                    System.out.println(userName2 + "========");
                    System.out.println(userId);

                } else if (userName1 != null) {
                    role = "studnet";
                    userName2 = userName1;

                } else {
                    userName2 = "";

                    System.out.println("Invalid user Id.");
                }
                pst = con.prepareStatement("create table if not exists userinfo (Userid varchar(20), Emailid varchar(50), Mobileno varchar(50),Dob varchar(20),Address varchar(300),Gender varchar(10),Role varchar(20),photo longblob,primary key(Userid))");
                pst.executeUpdate();

                pst = con.prepareStatement("select * from userinfo where Userid=?");
                pst.setString(1, userId);
                rs = pst.executeQuery();
            } catch (Exception e) {
            }
            try {
                if (rs.next()) {


        %>

        <form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST" onsubmit="return onsub();" name="myform">
            <input type="hidden" name="check" value="7" />
            <div class="container">
                <div  class="form">

                    <input type="hidden" value="<%=role%>" name="userrole">
                    <table>
                        <tr>
                            <td>
                                <p class="contact"><label for="phone">User Id</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="phone">User Name</label></p>
                                <input id="uid" name="userId" placeholder="User Id" readonly="yes" value="<%=userId%>" required="" style="width:100px;" tabindex="1" type="text">

                                <input id="name" name="userName" placeholder="User Name" readonly="yes" required="" value="<%=userName2%>" style="width:300px;" tabindex="1" type="text"></td>
                        </tr>
                        <tr>

                            <td>
                                <p class="contact"><label for="email">Email Id</label></p> 

                                <input type="email" id="email" style="width:300px;" name="email" value="<%=rs.getString("EmailId")%>" placeholder="example@domain.com" required="" > </td>
                        </tr>
                        <tr>
                            <td>
                                <p class="contact"><label for="Dob">Date of Birth</label></p> 

                                <div id="popupExample">

                                    <input type="text" class="dateField" id="popupDateField" name="dob" style="width:100px;" value="<%=rs.getString("Dob")%>">  

                                </div>


                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <%
                                    if (rs.getString("Gender").equalsIgnoreCase("Male")) {
                                %>
                                <label>Male</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" checked="yes" name="g1" value="Male" id="g1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>Female</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" name="g1" value="g" id="Female">
                                <%
                                } else {
                                %>
                                <label>Male</label>&nbsp;&nbsp;&nbsp;<input type="radio" required=""  name="g1" value="Male" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>Female</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" checked="yes" name="g1" value="Female">
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <p class="contact"><label for="Address">Address</label></p> 

                                <textarea name="textarea" cols="25" rows="5" placeholder="Address..."><%=rs.getString("Address")%></textarea><br>


                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <p class="contact"><label for="phone">Mobile Number</label></p> 
                                <input id="phone" name="phone" placeholder="phone number" value="<%=rs.getString("Mobileno")%>" style="width:150px;" required="" type="text"> <br>
                            </td>
                        </tr>
                        <tr>

                            <td>
                                <p class="contact"><label for="phone">Upload Photo</label></p> 
                                <input type="file" name="imagefile" required="">
                            </td>
                        </tr>
                    </table>
                    <div align="center"><input class="buttom" name="submit" id="submit" tabindex="5" value="Submit" type="submit"> 	 </div>


                </div>  

            </div>
        </form>
        <%} else {
        %>
        <form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST" onsubmit="return onsub();" name="myform">
            <input type="hidden" name="check" value="7" />      
            <div class="container">

                <div  class="form">

                    <input type="hidden" value="<%=role%>" name="userrole">
                    <table>
                        <tr>
                            <td>
                                <p class="contact"><label for="phone">User Id</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="phone">User Name</label></p>
                                <input id="uid" name="userId" placeholder="User Id" readonly="yes" value="<%=userId%>" required="" style="width:100px;" tabindex="1" type="text">

                                <input id="name" name="userName" placeholder="User Name" readonly="yes" required="" value="<%=userName2%>"  style="width:300px;" tabindex="1" type="text"></td>
                        </tr>
                        <tr>

                            <td>
                                <p class="contact"><label for="Email">Email Id</label></p> 

                                <input type="email" class="register-input" id="email" style="width:300px;" name="email" placeholder="example@gmail.com" required="">
                        <tr>
                            <td>
                                <p class="contact"><label for="Dob">Date of Birth</label></p> 

                                <div id="popupExample">

                                    <input type="text" required="" class="dateField" id="popupDateField" placeholder="Date of Birth" name="dob" style="width:100px;">  

                                </div>


                            </td>
                        </tr>
                        <tr>
                            <td><br>

                                <label>Male</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" name="g1" value="Male" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>Female</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" name="g1" value="Female" >

                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <p class="contact"><label for="Address">Address</label></p> 

                                <textarea name="textarea" cols="25" rows="5" placeholder="Address..."></textarea><br>


                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <p class="contact"><label for="phone">Mobile Number</label></p> 
                                <input type="text" id="phone" name="phone" placeholder="phone number"  style="width:150px;" required="" > <br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p class="contact"><label for="phone">Upload Photo</label></p> 
                                <input type="file" name="imagefile" required="">
                            </td>
                        </tr>
                    </table>
                    <div align="center"><input type="submit" class="buttom"  tabindex="5" value="Submit"> 	 </div>


                </div>  

            </div>
        </form>
        <%
            }
        } catch (Exception e) {
        %>
        <form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST" onsubmit="return onsub();" name="myform">
            <input type="hidden" name="check" value="7" />
            <div class="container">

                <div  class="form">

                    <input type="hidden" value="<%=role%>" name="userrole">
                    <table>
                        <tr>
                            <td>
                                <p class="contact"><label for="phone">User Id</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&sp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="phone">User Name</label></p>
                                <input id="uid" name="userId" placeholder="User Id" readonly="yes" value="<%=userId%>" required="" style="width:100px;" tabindex="1" type="text">

                                <input id="name" name="userName" placeholder="User Name" readonly="yes" required="" value="<%=userName2%>"  style="width:300px;" tabindex="1" type="text"></td>
                        </tr>
                        <tr>

                            <td>
                                <p class="contact"><label for="Email">Email Id</label></p> 

                                <input type="email" class="register-input" id="email" style="width:300px;" name="email" placeholder="example@gmail.com" required="">
                        <tr>
                            <td>
                                <p class="contact"><label for="Dob">Date of Birth</label></p> 

                                <div id="popupExample">

                                    <input type="text" required="" class="dateField" id="popupDateField" placeholder="Date of Birth" name="dob" style="width:100px;">  

                                </div>


                            </td>
                        </tr>
                        <tr>
                            <td><br>

                                <label>Male</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" name="g1" value="Male">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>Female</label>&nbsp;&nbsp;&nbsp;<input type="radio" required="" name="g1" value="Female">

                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <p class="contact"><label for="Address">Address</label></p> 

                                <textarea name="textarea" cols="25" rows="5" placeholder="Address..."></textarea><br>


                            </td>
                        </tr>
                        <tr>
                            <td><br>
                                <p class="contact"><label for="phone">Mobile Number</label></p> 
                                <input type="text" id="phone" name="phone" placeholder="phone number"  style="width:150px;" required="" > <br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p class="contact"><label for="phone">Upload Photo</label></p> 
                                <input type="file" name="imagefile" required="">
                            </td>
                        </tr>
                    </table>
                    <div align="center"><input type="submit" class="buttom"  tabindex="5" value="Submit"> 	 </div>


                </div>  

            </div>
        </form>
        <%
            }

        %>
    </form>
</body>
</html>
