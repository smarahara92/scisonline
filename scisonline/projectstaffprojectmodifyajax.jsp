<%-- 
    Document   : projectstaffprojectmodifyajax
    Created on : May 19, 2014, 2:25:08 PM
    Author     : veeru
--%>

<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%            
            System.out.println("&&&&&&&&&&&&&&&&&&&&");
            String cBox = request.getParameter("selectedOption");         // 1. Change Sup // 2. New Internship // 3. Return from Internship
            String streamName = (String)session.getAttribute("projectStreamName");
            streamName = streamName.replace('-', '_');
                        System.out.println(streamName);
                        System.out.println(cBox);

            String StudId = request.getParameter("studentId");
            String programmeName = scis.studentProgramme(StudId);
            programmeName = programmeName.replace('-', '_');

            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1;
            int pyear = year;
            String semester = null;
            if (streamName.equalsIgnoreCase("MCA") == true) {
                if (month <= 6) {
                    semester = "Winter";
                    pyear = year;
                } else {
                    semester = "Monsoon";
                    pyear = year - 1;
                }
            } else {
                if (month > 3) {
                    pyear = year;
                } else {
                    pyear = year - 1;
                }
            }
            Connection con = conn.getConnectionObj();
            
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();

            String table1 = "";
            String table2 = "";

            int streamYear = 0;

            ResultSet rs2 = null;

            table1 = streamName + "_project_" + pyear;
            table2 = programmeName + "_Project_Student_" + pyear;

            try {

                rs2 = (ResultSet) st1.executeQuery("select * from " + table1 + " as a where a.ProjectId in(Select b.ProjectId from " + table2 + " as b where b.StudentId='" + StudId + "')");    // Indicates some project is allocated to this studentId.

            } catch (Exception ex) {%>
        `		   1
        <%
                ex.printStackTrace();
                return;
            }



            ResultSet rs5 = (ResultSet) st7.executeQuery("select * from  " + table1 + " as a where a.ProjectId in(Select b.ProjectId from " + table2 + " as b where b.StudentId='" + StudId + "') and a.Organization='uoh'");  // Student doing project in Univ.

            // Checking if a student is doing project in university for Return from Internship case.         
            if (rs5.next() == true && "rtuoh".equals(cBox)) {%>
        2
        <%return;
            }

            // Checking if a Student is not allocated any project for both change sup and return from internship.                                                   
            if ("rtuoh".equals(cBox) || "cs".equals(cBox)) {              // Using same form for Change Supervisor and Return from Internship
                if (rs2.next() != true) {%>
        3
        <%return;
                }
            }

            rs2.beforeFirst();

            ResultSet rs6 = (ResultSet) st2.executeQuery("select * from   " + table1 + " as a where a.Allocated='no' and a.Organization='uoh'");  // List of Unallocated Projects

            while (rs2.next()) {


                // Checking for an internship doing student for Change Supervisor         
                if (!rs2.getString(6).equals("uoh") && "cs".equals(cBox)) {

        %>
        4
        <%  return;
                } //**************************Logic for Change Supervisor***********************************
        else if ("cs".equals(cBox)) {


        %>

        <%                //----------New Modification---------
            if (!rs6.next() == true) {%>
        5

        <%                 return;       }

        } //*************************** Logic for Return from University******************************
        else if (!rs2.getString(6).equals("uoh") && "rtuoh".equals(cBox)) {
            if ("rtuoh".equals(cBox)) {
                ResultSet rs4 = (ResultSet) st8.executeQuery("select * from " + table1 + " as a where a.ProjectId in(Select b.ProjectId from " + table2 + " as b where b.StudentId='" + StudId + "' ) and a.Organization<>'uoh'"); // Student doing Internship.

                if (rs4.next() == true) {


        %>



        <% if (!rs6.next() == true) {%>
        5
        
        <% return;                   
        }

                        }
                        rs4.close();
                        
                    }

                }
            }
            st1.close();
            st2.close();
            st7.close();
            st8.close();
            rs5.close();
            rs2.close();
            rs6.close();
            conn.closeConnection();
            con = null;
        %>
    