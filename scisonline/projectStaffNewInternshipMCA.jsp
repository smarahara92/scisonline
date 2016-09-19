<%-- 
    Document   : projectStaffNewInternshipMCA
    Created on : 20 May, 2013, 9:41:13 AM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">

            function check2(q)
            {
                var StudId = q;
                alert(StudId + " is not assigned any Project.")
                history.back();
            }

            function check1(q)
            {
                var StudId = q;
                alert(StudId + " is an Internship Student.")
                //window.location.replace("projectStaffModifyMCA.jsp");
                history.back();
            }

            function validate1()
            {
                var org = document.getElementById("orgname").value;
                var pTid = document.getElementById("projtitle").value;
                var iSup = document.getElementById("sel3").value;
                var orgSup = document.getElementById("sid").value;
                //alert(oldpid);
                if (org == "")
                {
                    alert("Please enter an Organization Name.")
                    return false;
                }

                if (pTid == "")
                {
                    alert("Please enter a Project Title.")
                    return false;
                }

                if (iSup == "none")
                {
                    alert("Please enter an Internal Supervisor.")
                    return false;
                }

                if (orgSup == "")
                {
                    alert("Please enter an Orgainization Supervisor.")
                    return false;
                }
                return true;
            }

        </script>
    </head>
    <body bgcolor="E0FFFF">
        <%
            String val = request.getParameter("r");   // if it is change sup or new internship
            String StudId = request.getParameter("sid");
            String branchYear = request.getParameter("branchYear");
            int pyear = scis.studentBatchYear(StudId);

            Connection con = conn.getConnectionObj();
             
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();

            ResultSet rs = st1.executeQuery("select * from  faculty_data order By Faculty_Name");
            ResultSet rs2 = null;

            try {
                rs2 = (ResultSet) st2.executeQuery("select * from  MCA_Project" + "_" + pyear + " where Organization<>'uoh'");
            } catch (Exception ex) {%>
        `		   <center><h2>The required Project Master Tables does not exists in Database. <br>
            Please follow a sequential order.</h2></center>
            <%
                    ex.printStackTrace();
                    return;
                }

                ResultSet rs5 = (ResultSet) st5.executeQuery("select * from  MCA_Project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from MCA_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "' ) and a.Organization<>'uoh'");   // Means He is already an internship student.
                ResultSet rs4 = (ResultSet) st4.executeQuery("select * from  MCA_Project" + "_" + pyear + " where Organization<>'uoh'  ");  // Same as rs2
                ResultSet rs6 = (ResultSet) st6.executeQuery("select * from  MCA_Project" + "_" +pyear + " as a where a.ProjectId in(Select b.ProjectId from MCA_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "'  ) and a.Organization='uoh'");

                String table = "MCA" + "_" + pyear;
               
                // @@@@@@@@@@@@@@@@@@@@@@  Student Name Fetching
                ResultSet rs3 = (ResultSet) st3.executeQuery("select StudentName from " + table + " where StudentId='" + StudId + "'");
                String Name = "";
                while (rs3.next()) {
                    System.out.println(rs3.getString(1));
                    Name = rs3.getString(1);
                }

                //@@@@@@@@@@@@@@@@@@@@@@@

                if (rs5.next()) {%>
    <script type="text/javascript" language="javascript">

        check1('<%=StudId%>');

    </script>   

    <%} else if (rs6.next() != true) {%>
    <script type="text/javascript" language="javascript">
        //alert("hiiii");
        check2('<%=StudId%>');

    </script>

    <%}
        //rs2.beforeFirst();



    %>

    <form  id="form" method="POST" onsubmit="return validate1()" action="projectStaffNewInternshipMCA1.jsp">
        <table align="center">
            <tr bgcolor="#c2000d">
                <td align="center" class="style12"> <font size="6"> Modify Project </font> </td>
            </tr> 
        </table>     

        <br>
        <table align="center" >
            <tr>

                <th>Student ID </th> 
                <th>Student Name</th>
                <th>Organization</th>
                <th>Project Title</th>
                <th>Internal Supervisor</th>
                <th>Organization Supervisor</th>
            <br>   
            </tr>
            <tr>

                <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=StudId%>" readonly size="8" maxlength="8"></td>
                <td>&nbsp;<input type="text" id="sid1" name="sname" value="<%=Name%>" readonly size="25"></td>

                <td>&nbsp;<input type="text" id="orgname" name="orgname"  size="20"></td>
                <td>&nbsp;<input type="text" id="projtitle" name="projtitle"  size="20"></td> 

                <td>&nbsp;<select id="sel3" name="sel3"> 
                        <option value="none">none</option>
                        <% while (rs.next()) {%>

                        <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                        <%}%>
                    </select></td>  

                <td>&nbsp;<input type="text" id="sid" name="orgsup" value=""  size="15" ></td>  
            </tr>        
            <tr><td>          </td></tr>
            <tr><td>          </td></tr>
            <tr><td>          </td></tr>
            <tr><td>          </td></tr>
            <tr>
                <td  colspan="8" align="center"><input type="submit" value="submit"/></td>

            </tr>
        </table>
              <%  
                st1.close();
                st2.close();
                st3.close();
                st4.close();
                st5.close();
                st6.close();
                rs.close();
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