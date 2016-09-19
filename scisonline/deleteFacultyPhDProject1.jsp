<%-- 
    Document   : deleteFacultyPhDProject1
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
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



            function closeWin(f)
            {
                var oldfaculty = f;

                //alert(oldfaculty);
                var h = document.getElementById("sup").value;
                //alert(h);
                if (h == "none")
                {

                    alert("Select a Supervisor Name");
                    return false;
                }
                if (h == oldfaculty)
                {
                    alert("The Faculty to be deleted cannot be reassigned.");
                    document.getElementById("sup").value = "none";
                    return false;
                }
                return true;
            }

        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="EOFFFF">
        <%            //--------------Old Faculty Id Retrieval ------------------
        
        Connection con = conn.getConnectionObj();
        Connection con2 = conn2.getConnectionObj();
        
            Statement st7 = con.createStatement();
            String oldfaculty = (String) session.getAttribute("oldfaculty");
            String oldFacId = "";
            String studId = request.getParameter("studentid");
            studId = studId.toUpperCase();
            ResultSet rset = (ResultSet) st7.executeQuery("select ID from  faculty_data where Faculty_Name='" + oldfaculty + "'");
            while (rset.next()) {
                oldFacId = rset.getString(1);      // ID of the deleted faculty.
            }
            rset.beforeFirst();

            //out.println("Old fac id "+oldFacId);	  
            // ----------------------- END -------------------------		   

        %>
        <form name="frm" action="deleteFacultyPhDProject2.jsp" onSubmit="return closeWin('<%=oldFacId%>')">
            <%
                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                int month = now.get(Calendar.MONTH);
                String semester = "";
                if (month <= 6) {
                    semester = "Winter";
                    year = year - 1;
                } else {

                    semester = "Monsoon";

                }

                Statement st1 = con2.createStatement();
                Statement st2 = con2.createStatement();
                Statement st3 = con.createStatement();
                ResultSet rs2 = null;
                ResultSet rs1 = (ResultSet) st1.executeQuery("select * from PhD_" + year + " where StudentId='" + studId + "'  ");

                ResultSet rs4 = st3.executeQuery("select * from  faculty_data order By Faculty_Name");
                int check1 = 0;           // To check if the deleted faculty is one among the Supervisors or not..
                int check2 = 0;           // To check if the deleted faculty is one among the DRC or not..
                int noOfSup = 0;

                if (rs1.next()) {


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
                <th>Change Supervisor</th> 
                <tr>
                    <td>&nbsp;<input type="text" value="<%=studId%>" readonly id="stdid" name="stdid" size="8" ></td>
                    <td>&nbsp;<input type="text" value="<%=rs1.getString("StudentName")%>" readonly id="stdname" name="stdname" size="20" ></td>
                        <%
                            try {
                                rs2 = (ResultSet) st2.executeQuery("select * from Temp_Reassign_PhD_Student_" + year + " where StudentId='" + studId + "'");
                            } catch (Exception e) {

                            }
                            if (rs2.next()) {
                        %>
                    <td>&nbsp;<select id="sup"  name="sup" > 
                            <option value="none">none</option>
                            <% while (rs4.next()) {%>
                            <%
                                if (rs2.getString(3).equalsIgnoreCase(rs4.getString(1))) {
                            %>
                            <option value="<%=rs4.getString(1)%>" selected="yes"> <%=rs4.getString(2)%> </option>
                            <%} else {%>
                            <option value="<%=rs4.getString(1)%>"> <%=rs4.getString(2)%> </option>


                            <%
                                    }

                                }
                                rs4.beforeFirst();%>
                        </select>
                    </td>
                    <%
                    } else {
                    %>
                    <td>&nbsp;<select id="sup"  name="sup" > 
                            <option value="none">none</option>
                            <% while (rs4.next()) {%>

                            <option value="<%=rs4.getString(1)%>"> <%=rs4.getString(2)%> </option>
                            <%}
                                rs4.beforeFirst();%>
                        </select>
                    </td>
                    <%
                        }
                    %>
                </tr>
            </table>


            <%
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
          conn.closeConnection();
          con = null;
          conn2.closeConnection();
          con2 = null;
        %>

    </body>
</html>
