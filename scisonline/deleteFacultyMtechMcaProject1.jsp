<%-- 
    Document   : deleteFacultyMtechMcaProject1
    Created on : 4 Jun, 2013, 10:49:41 AM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@include file="dbconnection.jsp"%>
<%@page import="java.util.*"%>
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

        <script type="text/javascript">


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


            function activate1(c)
            {
                //alert("llll");
                if (c == true)
                {
                    document.getElementById("sup1").disabled = false;
                    var t = document.getElementById("check2").checked;
                    if (t = "true")
                        document.getElementById("check2").checked = false;
                    else
                        document.getElementById("check2").checked = false;
                    document.getElementById("proj").disabled = true;
                    document.getElementById("proj").value = "none";
                }
                else
                {
                    document.getElementById("sup1").value = "none";
                    document.getElementById("sup1").disabled = true;
                }


            }

            function activate2(d)
            {
                if (d == true)
                {
                    document.getElementById("proj").disabled = false;
                    var t = document.getElementById("check1").checked;
                    if (t = "true")
                        document.getElementById("check1").checked = false;
                    else
                        document.getElementById("check1").checked = false;
                    document.getElementById("sup1").disabled = true;
                    document.getElementById("sup1").value = "none";
                }
                else
                {
                    document.getElementById("proj").value = "none";
                    document.getElementById("proj").disabled = true;

                }
            }

            function activate3(e)
            {
                if (e == true)
                {
                    document.getElementById("internsup1").disabled = false;
                }
                else
                {
                    document.getElementById("internsup1").value = "none";
                    document.getElementById("internsup1").disabled = true;

                }
            }

            function closeWin(f)
            {
                var oldfaculty = f;
                var type = document.getElementById("type").value;
                //alert(type);
                if (type == 1)
                {
                    var h = document.getElementById("check1").checked;
                    var h1 = document.getElementById("check2").checked;
                    if (h == false && h1 == false)
                    {
                        alert("Please select atleast one option");
                        return false;
                    }

                    else if (h == true)
                    {
                        var m = document.getElementById("sup1").value;
                        //alert(m);
                        //alert(oldfaculty);
                        if (m == "none")
                        {
                            alert("Select a Supervisor Name");
                            return false;
                        }
                        if (m == oldfaculty)
                        {
                            alert("The Faculty to be deleted cannot be reassigned.");
                            document.getElementById("sup1").value = "none";
                            return false;
                        }

                    }
                    else if (h1 == true)
                    {
                        var m = document.getElementById("proj").value;
                        if (m == "none")
                        {
                            alert("Select  a Project");
                            return false;
                        }
                    }
                }
                else if (type == 2)                  // For Co-Supervisor Case
                {

                }

                else if (type == 3)                 // For Internship Case
                {

                    var h = document.getElementById("internsup1").value;

                    if (h == "none")
                    {
                        alert("Select a Supervisor Name");
                        return false;
                    }
                    if (h == oldfaculty)
                    {
                        alert("The Faculty to be deleted cannot be reassigned.");
                        document.getElementById("internsup1").value = "none";
                        return false;
                    }

                }
            }
        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="EOFFFF">
        <%                    //--------------Old Faculty Id Retrieval ------------------
            Statement st7 = con.createStatement();
            String oldfaculty = (String) session.getAttribute("oldfaculty");
          
            
    // ----------------------- END -------------------------		   

        %>
        <form name="frm" action="deleteFacultyMtechMcaProject2.jsp" onSubmit="return closeWin('<%=oldfaculty%>')">
            <%
            try{   
            Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                year = 2013;

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con.createStatement();
                Statement st8 = con.createStatement();
                Statement st9 = con.createStatement();

                //out.println(oldfaculty);
                String studId = request.getParameter("studentid");
                String batchYear = request.getParameter("batchYear");
                String pgname = request.getParameter("pgname");
                String sname = request.getParameter("sname");
                String projectYear = request.getParameter("pyear");

                System.out.println(studId + "****************************");
                //out.println(studid);
                int projectId = 0;
                String code = "";                 // Respective Branch Project Student Data Table
                String projectTitle = "";
                String name = "";
                String masterTable = "";          // Master table of Students
                String masterProjectTable = "";   // Master table of Projects

                ResultSet rs5 = null;     // Contains the Unallocated List of Projects..

                masterTable = pgname.replace('-', '_') + "_" + batchYear;
                code = pgname.replace('-', '_') + "_Project_Student" + "_" + projectYear;
                masterProjectTable = sname + "_project_" + projectYear;

                // Note : not in clause works only for the non null entries..
                rs5 = (ResultSet) st5.executeQuery("select * from  " + masterProjectTable + " as a where a.ProjectId not in(Select b.ProjectId from " + code + " as b where b.ProjectId<>'null' ) and a.Organization='uoh' and Allocated='no'");  // List of Unallocated Projects

                //-------------Fetching Student Names-----------------
                ResultSet rs1 = (ResultSet) st2.executeQuery("select StudentName from " + masterTable + " where StudentId='" + studId + "'");

                while (rs1.next()) {
                    //System.out.println(rs1.getString(1));
                    name = rs1.getString(1);
                }

                //--------------Fetching Project Id corressponding to a Student-----------
                ResultSet rs2 = (ResultSet) st2.executeQuery("select ProjectId from " + code + " where StudentId='" + studId + "'");

                while (rs2.next()) {
                    //System.out.println(rs1.getString(1));
                    projectId = Integer.parseInt(rs2.getString(1));
                    session.setAttribute("oldProjId", projectId);
                }

                System.out.println("Project Id of " + name + " is " + projectId);

                //---------------Fetching Data from Project Master Table based on Project Id-----------
                ResultSet rs3 = (ResultSet) st3.executeQuery("select * from " + masterProjectTable + " where ProjectId='" + projectId + "'");

                ResultSet rs4 = st4.executeQuery("select * from  faculty_data order By Faculty_Name");

                int noOfSup = 0;

                rs3.next();

                // -------------------- UoH Project Students --------------------		
                if (rs3.getString(6).equals("uoh")) {
                    if (rs3.getString(3) !=null &&rs3.getString(3).equalsIgnoreCase("none") == false) {
                        noOfSup++;
                    }
                    if (rs3.getString(4) !=null &&rs3.getString(4).equalsIgnoreCase("none") == false) {
                        noOfSup++;
                    }
                    if (rs3.getString(5) !=null &&rs3.getString(5).equalsIgnoreCase("none") == false) {
                        noOfSup++;
                    }

                    if (noOfSup == 1) {

            %>
            <input type="hidden" value="1" id="type" name="type">
            <table align="center">
                <tr  bgcolor="#c2000d">
                    <td align="center" class="style12"><font size="6">Reassign Project Student</font></td>
                </tr>
            </table>    

            <br>	
            <table align="center">

                <th>Student Id</th> 
                <th>Student Name</th> 
                <th></th>
                <th>Change Supervisor</th> 
                <th> </th>
                <th>Change Project</th>


                <tr>
                    <td>&nbsp;<input type="text" value="<%=studId%>" readonly id="stdid" name="stdid" size="8" ></td>
                    <td>&nbsp;<input type="text" value="<%=name%>" readonly id="stdname" name="stdname" size="20" ></td>

                    <td>&nbsp;<input type="radio" name="check1" id="check1" onclick="activate1(this.checked)" value=""></td>
                    <td>&nbsp;<select id="sup1" disabled="true" name="sup1"> 
                            <option value="none">none</option>
                            <% while (rs4.next()) {%>

                            <option value="<%=rs4.getString(1)%>"> <%=rs4.getString(2)%> </option>
                            <%}
                                rs4.beforeFirst();%>
                        </select></td>

                    <td>&nbsp;<input type="radio" name="check2" id="check2" onclick="activate2(this.checked)" value=""></td>
                    <td>&nbsp;<select id="proj" name="proj" disabled="true"> 
                            <option value="none">none</option>
                            <% while (rs5.next()) {%>

                            <option value="<%=rs5.getString(1)%>"> <%=rs5.getString(2)%> </option>
                            <%}
                                rs5.beforeFirst();%>
                        </select></td>	  

                </tr>
            </table>

            <input type="hidden" name="batchYear" value="<%=batchYear%>">
            <%
                //st8.executeUpdate("create table if not exists Temp_Reassign_MtechMCA_"+year+" (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFacId varchar(20),primary key(SubjectId))");
                //st9.executeUpdate("insert into  Temp_Reassign_Subject_"+year+" (SubjectId,OldFacId,NewFacId) values('"+b.get(i)+"', '"+oldfacultyid+"', '"+newfac1+"')");

            } else if (noOfSup >= 2) {
            %><input type="hidden" value="2" id="type" name="type"><%
                out.println(" Reassignment not required as Co-Supervisor(s) are present for the Project.");
            %>
            <br> <br>
            <table align="center">

                <tr  bgcolor="#c2000d">
                    <td align="center" class="style12"><font size="6">Reassign Project Student</font></td>
                </tr>
            </table>    

            <br>	
            <table align="center">

                <th>Student Id</th> 
                <th>Student Name</th> 


                <tr>
                    <td>&nbsp;<input type="text" value="<%=studId%>" readonly id="stdid" name="stdid" size="8" ></td>
                    <td>&nbsp;<input type="text" value="<%=name%>" readonly id="stdname" name="stdname" size="20" ></td>

                </tr>
            </table>
            <input type="hidden" name="batchYear" value="<%=batchYear%>">
            <%

                }
            } // Close of If that checks for Orgainization..
            //----------------------- END -----------------------------------
            //----------------------- Internship Project Students -----------											
            else if (!rs3.getString(6).equals("uoh")) {
            %>
            <input type="hidden" value="3" id="type" name="type">
            <table align="center">
                <tr  bgcolor="#c2000d">
                    <td align="center" class="style12"><font size="6">Reassign Project Student</font></td>
                </tr>
            </table>    

            <br>	
            <table align="center">

                <th>Student Id</th> 
                <th>Student Name</th> 
                <th>Change Supervisor</th> 



                <tr>
                    <td>&nbsp;<input type="text" value="<%=studId%>" readonly id="stdid" name="stdid" size="8" ></td>
                    <td>&nbsp;<input type="text" value="<%=name%>" readonly id="stdname" name="stdname" size="20" ></td>


                    <td>&nbsp;<select id="internsup1"  name="internsup1" > 
                            <option value="none">none</option>
                            <% while (rs4.next()) {%>

                            <option value="<%=rs4.getString(1)%>"> <%=rs4.getString(2)%> </option>
                            <%}
                                rs4.beforeFirst();%>
                        </select>
                    </td>

                </tr>
            </table>
<input type="hidden" name="batchYear" value="<%=batchYear%>">

            <%
                    //----------------------- END -----------------------------------	 
                }

            %>
            <table align="center">
                <tr>
                <br>
                <td > <input type="submit" value="OK" > </td>

                </tr>
            </table>
        </form>
            <%
            }catch(Exception ex){}
            %>
    </body>
</html>
