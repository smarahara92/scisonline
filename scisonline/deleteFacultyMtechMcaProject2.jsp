<%-- 
    Document   : deleteFacultyMtechMcaProject2
    Created on : 9 Jun, 2013, 5:15:13 PM
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


        </script>		
    </head>

    <body bgcolor="EOFFFF">
        <%            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            String oldfaculty = (String) session.getAttribute("oldfaculty");  // Id of Faculty to be deleted
            Integer oldProjId = (Integer) session.getAttribute("oldProjId");    // Old Project Id of the student
            //out.println(oldfaculty);
            //--------------Old Faculty Id Retrieval ------------------
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();

                      // ----------------------- END -------------------------		   
            String type = request.getParameter("type");  // type indicates whether 1) No Co-Sup 2) Co-Sup 3) Internship
            //out.println(type+" ");

            if (type.equals("1")) // Student with No Co_supervisors
            {
                String studId = request.getParameter("stdid");
                String newSup = request.getParameter("sup1");
                String newProj = request.getParameter("proj");
                String batchYear = request.getParameter("batchYear");
                //---------- Modified ---------------------------

                st2.executeUpdate("create table if not exists Temp_Reassign_Mtech_MCA_Student_" + year + " (StudentId varchar(10)NOT NULL, OldFacId varchar(20), NewFacId varchar(20), OldProjectId varchar(20), NewProjectId varchar(20), Internship varchar(20),batchYear varchar(20),primary key(StudentId) )");

                ResultSet rs1 = (ResultSet) st1.executeQuery("select * from Temp_Reassign_Mtech_MCA_Student_" + year + " where StudentId='" + studId + "'");

                if (rs1.next() == true) {
                    st4.executeUpdate("delete from Temp_Reassign_Mtech_MCA_Student_" + year + " where StudentId='" + studId + "'");
                    st3.executeUpdate("insert into  Temp_Reassign_Mtech_MCA_Student_" + year + " (StudentId,OldFacId,NewFacId,OldProjectId,NewProjectId, Internship,batchYear) values('" + studId + "', '" + oldfaculty + "', '" + newSup + "', '" + oldProjId + "', '" + newProj + "','no','"+batchYear+"')");
                } else {
                    st3.executeUpdate("insert into  Temp_Reassign_Mtech_MCA_Student_" + year + " (StudentId,OldFacId,NewFacId,OldProjectId,NewProjectId, Internship,batchYear) values('" + studId + "', '" + oldfaculty + "', '" + newSup + "', '" + oldProjId + "', '" + newProj + "','no','"+batchYear+"')");
                }
                //------------ End ------------------------------

                out.println("This is type 1" + " " + studId + " " + newSup + " " + newProj + " " + oldProjId);
            } else if (type.equals("2")) // Student with Co_supervisors
            {
                String studId = request.getParameter("stdid");
                String batchYear = request.getParameter("batchYear");
                out.println("This is type 2" + " " + studId + " " + oldProjId);
            } else if (type.equals("3")) // Internship  student  
            {
                String studId = request.getParameter("stdid");
                String internSup = request.getParameter("internsup1");
                String batchYear = request.getParameter("batchYear");

                //---------- Modified ---------------------------
                st2.executeUpdate("create table if not exists Temp_Reassign_Mtech_MCA_Student_" + year + " (StudentId varchar(10)NOT NULL, OldFacId varchar(20), NewFacId varchar(20), OldProjectId varchar(20), NewProjectId varchar(20), Internship varchar(20),batchYear varchar(20),primary key(StudentId) )");

                ResultSet rs1 = (ResultSet) st1.executeQuery("select * from Temp_Reassign_Mtech_MCA_Student_" + year + " where StudentId='" + studId + "'");

                if (rs1.next() == true) {
                    st4.executeUpdate("delete from Temp_Reassign_Mtech_MCA_Student_" + year + " where StudentId='" + studId + "'");
                    st3.executeUpdate("insert into  Temp_Reassign_Mtech_MCA_Student_" + year + " (StudentId,OldFacId,NewFacId,OldProjectId,Internship,batchYear) values('" + studId + "', '" + oldfaculty + "', '" + internSup + "', '" + oldProjId + "','yes','"+batchYear+"')");
                } else {
                    st3.executeUpdate("insert into  Temp_Reassign_Mtech_MCA_Student_" + year + " (StudentId,OldFacId,NewFacId,OldProjectId,Internship,batchYear) values('" + studId + "', '" + oldfaculty + "', '" + internSup + "', '" + oldProjId + "','yes','"+batchYear+"')");
                }
                //------------ End ------------------------------

                out.println("This is type 3" + " " + studId + " " + internSup + " " + oldProjId);
            }


        %>
        <script>
            window.close();
        </script>
    </body>
</html>
