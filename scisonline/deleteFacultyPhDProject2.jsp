<%-- 
    Document   : deleteFacultyPhDProject2
--%>


<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
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


        </script>		
    </head>

    <body bgcolor="EOFFFF">
        <%
            Connection con = conn.getConnectionObj();
            Connection con2 = conn2.getConnectionObj();
            
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
            String oldfaculty = (String) session.getAttribute("oldfaculty");  // Id of Faculty to be deleted

            //--------------Old Faculty Id Retrieval ------------------
            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con2.createStatement();

            String oldFacId = "";
            ResultSet rset = (ResultSet) st4.executeQuery("select ID from  faculty_data where Faculty_Name='" + oldfaculty + "'");
            while (rset.next()) {
                oldFacId = rset.getString(1);      // ID of the deleted faculty.
            }
            rset.beforeFirst();

            // ----------------------- END -------------------------		   
            String newSup = request.getParameter("sup");  // Phd New Supervisor
            String studId = request.getParameter("stdid");

            //st5.executeUpdate("drop table if exists Temp_Reassign_PhD_Student_" + year + " ");
            st2.executeUpdate("create table if not exists Temp_Reassign_PhD_Student_" + year + " (StudentId varchar(10)NOT NULL, OldFacId varchar(20), NewFacId varchar(20),primary key(StudentId) )");

            ResultSet rs1 = (ResultSet) st1.executeQuery("select * from Temp_Reassign_PhD_Student_" + year + " where StudentId='" + studId + "'");

            if (rs1.next() == true) {
                st3.executeUpdate("delete from Temp_Reassign_PhD_Student_" + year + " where StudentId='" + studId + "'");
                st3.executeUpdate("insert into  Temp_Reassign_PhD_Student_" + year + " (StudentId,OldFacId,NewFacId) values('" + studId + "', '" + oldFacId + "', '" + newSup + "')");
            } else {
                st3.executeUpdate("insert into  Temp_Reassign_PhD_Student_" + year + " (StudentId,OldFacId,NewFacId) values('" + studId + "', '" + oldFacId + "', '" + newSup + "')");
            }
            //------------ End ------------------------------

            out.println("Detail " + " " + studId + " " + newSup + " " + oldFacId);


        %>
        <%
          conn.closeConnection();
          con = null;
          conn2.closeConnection();
          con2 = null;
        %>
        <script>
           window.close();
        </script>
        
    </body>
</html>
