<%-- 
    Document   : projectFacultyAssessmentstatus
--%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <style>
            <%--body {color:white}--%>
            .style11 {color :#c2000d}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>

        <script type="text/javascript">

            function AllocatedCheck()
            {
                alert("Some Students are not allocated Projects. Project Assessment cannot be done.");
                window.location.replace("BlankPage.jsp");
            }

            function check1(temp)
            {
                // alert(temp)   ;
                var cmp1 = document.getElementById(temp).value;
                // alert(cmp1);

                cmp1 = cmp1.replace(/^\s+|\s+$/g, '');

                if (cmp1 < 0 || cmp1 > 60)
                {
                    alert("External Marks range is 0-60");
                    document.getElementById(temp).focus();
                    document.getElementById("xx").disabled = true;
                    return;
                }

                if (cmp1.length === 0)
                {
                    //document.getElementById(temp).value='0';
                    document.getElementById(temp).style.color = 'black';

                    document.getElementById("xx").disabled = false;
                    return;
                }
                var i = 0, j = 0;
                for (i = 0; i < cmp1.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (cmp1.charCodeAt(i) < 48 || cmp1.charCodeAt(i) > 57)
                    {
                        alert("Please enter a valid Input.");
                        document.getElementById("xx").disabled = true;
                        document.getElementById(temp).style.color = 'red';
                        document.getElementById(temp).focus();
                        return;
                    }
                }
                document.getElementById(temp).value = cmp1;
                document.getElementById(temp).style.color = 'black';
                document.getElementById("xx").disabled = false;
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


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="E0FFFF">

        <form  id="form" method="POST" onsubmit="" action="projectFacultyAssessmentstatus1.jsp" >

            <%                PreparedStatement pst = null;
                try {
                    Connection con = conn.getConnectionObj();
                    String user = (String) session.getAttribute("user");
                    String pgname = (String) request.getParameter("pgname");
                    String pyear = request.getParameter("year");
                    ResultSet rs1 = null;
                    ResultSet rs2 = null;
                    ResultSet rs3 = null;
                    ResultSet rs5 = null;
                    int i = 1;
            %>

            <table align="center" >
                <caption>
                    <h2 class="style11"><%=pgname%> Project Status</h2>
                </caption>
                <tr>
                    <th>Student ID </th>
                    <th>Student Name </th>
                    <th>Project Title </th>
                    <th>Status </th>
                </tr>      
                <%

                    String table = pgname.replace('-', '_') + "_Project_" + pyear;
                    try {
                        pst = con.prepareStatement("select * from " + table + " where(SupervisorId1=? or SupervisorId2=? or SupervisorId3=?) and Allocated=? ");
                        pst.setString(1, user);
                        pst.setString(2, user);
                        pst.setString(3, user);
                        pst.setString(4, "yes");
                        rs1 = pst.executeQuery();
                    } catch (Exception ex) {
                %>
                <center><h2>The Projects are not yet allocated.</h2></center>
                    <%
                            ex.printStackTrace();
                            return;
                        }
                        rs2 = scis.getProgramme(pgname.replace('_', '-'), 1);
                        while (rs1.next()) {

                            while (rs2.next()) {
                                String table1 = rs2.getString(1).replace('-', '_') + "_Project_Student_" + pyear;
                                System.out.println(table1);
                                pst = con.prepareStatement("select StudentId from " + table1 + " where ProjectId=?");
                                pst.setString(1, rs1.getString(1));
                                rs3 = pst.executeQuery();
                                while (rs3.next()) {

                                    String studId = rs3.getString(1);
                                    String studentName = scis.studentName(studId);
                                    pst = con.prepareStatement("select Status+0 from " + table1 + " where StudentId=?");
                                    pst.setString(1, studId);
                                    rs5 = pst.executeQuery();
                                    rs5.next();
                    %>
                                    <tr>
                                        <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=studId%>"  readonly size="9"  onKeyPress="return disableEnterKey(event)"></td>
                                        <td>&nbsp;<input type="text" id="sname" name="sname" value="<%=studentName%>" readonly size="25" onKeyPress="return disableEnterKey(event)"></td> 
                                        <td>&nbsp;<input type="text" id="ptid" name="ptid" value="<%=rs1.getString(2)%>"  readonly size="35" onKeyPress="return disableEnterKey(event)"></td>
                                        <td><select name="status" style=" width: 100%">
                                                <% int status = rs5.getInt(1);
                                                ResultSet rs6 = scis.getStatusList(pgname);
                                                   while(rs6.next() ){
                                                       int statusId = rs6.getInt(1);
                                                       if(status ==  statusId) {%>
                                                       <option value="<%=statusId%>" selected><%=rs6.getString(2)%></option>
                                                       <%
                                                       } else {%>
                                                       <option value="<%=statusId%>"><%=rs6.getString(2)%></option>

                                                <%     }
                                                   }
                                                %>
                                            </select>    
                                        </td>
                                    </tr>
                <%
                                }
                                i++;
                                }
                                //rs3.beforeFirst();
                            rs2.beforeFirst();
                            }
                        //rs2.beforeFirst();
                       // rs1.beforeFirst();
                        rs1.close();
                        rs2.close();
                        rs3.close();
                        rs5.close();
                        pst.close();
                        scis.close();
                        conn.closeConnection();
                        con = null;
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }

                    // ----------- END  ------------
%>
                <tr> </tr> <tr> </tr> <tr> </tr> 
                <tr> </tr> <tr> </tr> <tr> </tr> 
                <tr> 
                    <td align="center" colspan="8"> 
                        <input type="Submit" id="xx"value="Submit"> </td> 
                </tr>
            </table>
        </form>   

    </body>
</html>
