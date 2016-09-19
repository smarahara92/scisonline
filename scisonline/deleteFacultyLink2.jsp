<%-- 
    Document   : deleteFacultyLink2
    Created on : 22 Nov, 2012, 1:23:15 AM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>

<!DOCTYPE html>
<html>
    <head>

        <script type="text/javascript">

            function check1()
            {
                alert("Please enter the details")
                history.back();
            }

        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body><%        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH) + 1;
        String semester = "";
        if (month <= 6) {
            semester = "Winter";
        } else {
            semester = "Monsoon";
        }
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st7 = con.createStatement();
        Statement st8 = con.createStatement();
        Statement st9 = con.createStatement();
        Statement st10 = con.createStatement();

        String oldfaculty = (String) session.getAttribute("oldfaculty");
        
        HashMap<String, String> hmap = (HashMap) session.getAttribute("hashmap");
        ArrayList b = (ArrayList) session.getAttribute("arraylist");
        int hash_Size = hmap.size();

        int j, csel_None_Count = 0, esel_None_Count = 0;

        String check = "None";

        for (j = 0; j < hmap.size(); j++) {

            String p1 = "csel" + j;
            String check1 = request.getParameter(p1);

            String p2 = "esel" + j;
            String check2 = request.getParameter(p2);

            if (check.equals(check1)) {
                csel_None_Count++;
            }

            if (check.equals(check2)) {
                esel_None_Count++;
            }

        }

        int k = csel_None_Count + esel_None_Count;

        int i;

        st10.executeUpdate("drop table if exists Temp_Reassign_Subject_" + year + " ");

        if (k != hash_Size) {
            for (i = 0; i < hmap.size(); i++) {

                String query1 = "Select type,Subject_Name from subjecttable where Code='" + b.get(i) + "'";
                ResultSet rs2 = st1.executeQuery(query1);

                while (rs2.next()) {

                    // ----------------Core Logic Check begins.. ---------------				
                    if (rs2.getString(1).equals("C")) {

                        String p = "csel" + i;

                        String newfac = request.getParameter(p);
                        System.out.println("newwwwwwwwwwwwwwwwwwwwwwwww"+newfac);

                        //---------- Modified ---------------------------
                        //		st8.executeUpdate("create table if not exists Temp_Reassign_Subject_"+year+" (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFacId varchar(20), Core varchar(10),Elective varchar(10),Reassign varchar(10),Drop varchar(10), primary key(SubjectId))");
                        //    st9.executeUpdate("insert into  Temp_Reassign_Subject_"+year+" (SubjectId,OldFacId,NewFacId,Core,Elective,Reassign,Drop) values('"+b.get(i)+"', '"+oldfacultyid+"', '"+newfac+"','yes','no','yes','no')");
                        //
                        st8.executeUpdate("create table if not exists Temp_Reassign_Subject_" + year + " (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFac varchar(20),Core varchar(10),Reassign varchar(10),primary key(SubjectId))");
                        st9.executeUpdate("insert into  Temp_Reassign_Subject_" + year + " (SubjectId,OldFacId,NewFac,Core,Reassign) values('" + b.get(i) + "', '" + oldfaculty + "', '" + newfac + "','yes','yes')");

                        //------------ End ------------------------------
                        try {
                           
                                String find = "";
                                ResultSet rs5 = st5.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid1='" + oldfaculty + "' and subjectid='" + b.get(i) + "'");
                                while (rs5.next()) {
                                    find = "facultyid1";
                                }
                                ResultSet rs6 = st6.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid2='" + oldfaculty + "' and subjectid='" + b.get(i) + "'");
                                while (rs6.next()) {
                                    find = "facultyid2";
                                }
                                //
                                //String query2="update "+semester+"_subjectfaculty set "+find+"='"+rs3.getString(1)+"' where subjectid='"+b.get(i)+"'";
                                // st3.executeUpdate(query2);         //raises exception

                           
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    } // ----------------Core Logic Check ends.. ---------------        
                    // ----------------Elective Logic Check begins.. ---------------
                    else if (rs2.getString(1).equals("E")) {

                        String reassignSub = request.getParameter("sel11" + i);
                        String newfac1 = request.getParameter("esel" + i);
                        
                        if (reassignSub != null) {
                            try {
                                if (reassignSub.equals("Reassign")) {

                                    //---------- Modified ---------------------------
                                    //			  st8.executeUpdate("create table if not exists Temp_Reassign_Subject_"+year+" (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFacId varchar(20), Core varchar(10),Elective varchar(10),Reassign varchar(10),Drop varchar(10),primary key(SubjectId))");
                                    //   st9.executeUpdate("insert into  Temp_Reassign_Subject_"+year+" (SubjectId,OldFacId,NewFacId,Core,Elective,Reassign,Drop) values('"+b.get(i)+"', '"+oldfacultyid+"', '"+newfac1+"','no','yes','yes','no')");
                                    //
                                    st8.executeUpdate("create table if not exists Temp_Reassign_Subject_" + year + " (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFac varchar(20),Core varchar(10),Reassign varchar(10),primary key(SubjectId))");
                                    st9.executeUpdate("insert into  Temp_Reassign_Subject_" + year + " (SubjectId,OldFacId,NewFac,Core,Reassign) values('" + b.get(i) + "', '" + oldfaculty + "', '" + newfac1 + "','no','yes')");

                                    //------------ End ------------------------------

                                        String find = "";
                                        ResultSet rs5 = st5.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid1='" + oldfaculty + "' and subjectid='" + b.get(i) + "'");
                                        while (rs5.next()) {
                                            find = "facultyid1";
                                        }
                                        ResultSet rs6 = st6.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid2='" + oldfaculty + "' and subjectid='" + b.get(i) + "'");
                                        while (rs6.next()) {
                                            find = "facultyid2";
                                        }

                                       

                                } else if (reassignSub.equals("Drop")) // In Drop Subject, we are setting the faculty id to null and not removing
                                {
                                    //---------- Modified ---------------------------
                                    String newfac2 = null;

                                    //	  st8.executeUpdate("create table if not exists Temp_Reassign_Subject_"+year+" (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFacId varchar(20), Core varchar(10),Elective varchar(10),Reassign varchar(10),droop varchar(10),primary key(SubjectId))");
                                    //    st9.executeUpdate("insert into  Temp_Reassign_Subject_"+year+" (SubjectId,OldFacId,NewFacId,Core,Elective,Reassign,Drop) values('"+b.get(i)+"', '"+oldfacultyid+"',"+newfac2+",'no','yes','no','yes')");
                                    //
                                    st8.executeUpdate("create table if not exists Temp_Reassign_Subject_" + year + " (SubjectId varchar(20)NOT NULL, OldFacId varchar(20), NewFac varchar(20),Core varchar(10),Reassign varchar(10),primary key(SubjectId))");
                                    st9.executeUpdate("insert into  Temp_Reassign_Subject_" + year + " (SubjectId,OldFacId,NewFac,Core,Reassign) values('" + b.get(i) + "', '" + oldfaculty + "'," + newfac2 + ",'no','no')");

                                    //------------ End ------------------------------  
                                    // the subject from the subject-faculty list coz a different faculty can also be teaching the same subject.
                                    int noFac1 = 0, noFac2 = 0;                // To check if a subject is taught by multiple faculties or not.
                                    String find = "";
                                    ResultSet rs5 = st5.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid1='" + oldfaculty + "' and subjectid='" + b.get(i) + "'");
                                    while (rs5.next()) {
                                        noFac1 = 1;
                                        find = "facultyid1";
                                    }

                                    ResultSet rs6 = st6.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid2='" + oldfaculty + "' and subjectid='" + b.get(i) + "'");
                                    while (rs6.next()) {
                                        noFac2 = 1;
                                        find = "facultyid2";
                                    }

                                    //	 
                                    // String query2="update "+semester+"_subjectfaculty set "+find+"=null where subjectid='"+b.get(i)+"'";
                                    // st4.executeUpdate(query2);         //raises exception
                                    //--------------------							  
                                    if ((noFac1 == 0 && noFac2 == 1) || (noFac1 == 1 && noFac2 == 0)) {

                                        System.out.println(b.get(i) + " Taught by only 1 faculty");
                                        //-- st8.executeUpdate("delete from "+semester+"_subjectfaculty where subjectid='"+b.get(i)+"'");

                                    }
                                    //---------------------   

                                }
                            } //try close  
                            catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        } else {
                            System.out.println("reassignSub is null--->true");
                        }
                    }

                    // ----------------Elective Logic Check ends.. ---------------					                                                        
                }   //while close
            }              // for close
            response.sendRedirect("deleteFacultyMtechMcaProject.jsp");
            // <h1>Faculty successfully deleted/reassigned.</h1>
        }//    if close       
        else {
            System.out.println("llll");
        %>
        <script type="text/javascript" language="javascript">
            check1();

        </script>   
        <%
            }


        %> 
        
    </body>
</html>   
