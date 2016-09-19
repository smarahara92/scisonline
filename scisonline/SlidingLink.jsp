<%-- 
    Document   : SlidingLink
    Created on : Aug 11, 2012, 12:05:34 PM
    Author     : varun
--%>
<%@page import="java.util.Calendar"%>
<%@include file="id_parser.jsp"%>
<%@include file="dbconnection.jsp"%>
<%@include file="checkValidity.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%            // take current year, so that we can do the sliding for 1st year students only that too in the 1st sem ( monsoon)
            Calendar cal = Calendar.getInstance();
            int month = cal.get(Calendar.MONTH) + 1;
            int curYear = 2012;
            int i, count = 0, count1 = 0;
            int CurriculumYear = 0;
            int latestYear = 0;
            String student = "";
            String student1 = "";
            String programmeName = null;
            String programmeName1 = null;
            String year = null;

            String[] curId = request.getParameterValues("cid");
            String[] fromName = request.getParameterValues("fname");
            String[] toName = request.getParameterValues("tname");
            String[] newId = request.getParameterValues("nid");

            ResultSet rs7 = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs3 = null;
            ResultSet rs4 = null;
            ResultSet rs5 = null;
            ResultSet rs6 = null;
            ResultSet rs11 = null;
            ResultSet rs10 = null;
            ResultSet rs22 = null;
            PreparedStatement pst = null;
            try {
                con.setAutoCommit(false);
                int k = 0;
                loop:
                for (; k < 10; k++) {
                    
                    System.out.println(k+"=====");
                    //System.out.println(curId[i] + newId[i] + "-----------");

                    if (curId[k].equals("") && newId[k].equals("") && fromName[k].equalsIgnoreCase("-Programme-")) {
                        continue;
                    }

                    student = curId[k];
                    student1 = newId[k];
                    student = student.toUpperCase();
                    student1 = student1.toUpperCase();

                    String currentStream = "";
                    String newStream = "";
                    String table = "";
                    String table1 = "";
                    String currentName = null;
                    //parsing student id
                    String PROGRAMME_NAME = student.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                    String BATCH_YEAR = student.substring(SYEAR_PREFIX, EYEAR_PREFIX);
                    String BATCH_YEAR1 = student1.substring(SYEAR_PREFIX, EYEAR_PREFIX);

                    year = "20" + BATCH_YEAR;
                    String year1 = "20" + BATCH_YEAR1;

                    pst = con.prepareStatement("select Programme_name from programme_table where Programme_code=?");
                    pst.setString(1, PROGRAMME_NAME);
                    rs = pst.executeQuery();
                    if (rs.next()) {

                        programmeName1 = rs.getString(1);

                        if (programmeName1.equalsIgnoreCase(fromName[k])) {
                            currentStream = rs.getString(1).replace('-', '_');
                        } else {
        %> 
        <h3>  Invalid stream selection for student <%=student%>.</h3>   
        <% continue loop;
            }

            // To check invalid stream selection for slided student
            String PROGRAMME_NAME1 = student1.substring(SPRGM_PREFIX, EPRGM_PREFIX);
            pst = con.prepareStatement("select Programme_name from programme_table where Programme_code=?");
            pst.setString(1, PROGRAMME_NAME1);
            rs6 = pst.executeQuery();

            if (rs6.next()) {
                if (toName[k].equalsIgnoreCase(rs6.getString(1))) {
                    programmeName = rs6.getString(1).replace('-', '_');
                    newStream = programmeName;
                } else {
        %>
        <h3>Invalid stream selection for student <%=student1%></h3>

        <%
                    continue loop;
                }

            }

            for (int j = 0; j < 2; j++) {

                table = currentStream + "_" + year1;       //current st yr
                table1 = newStream + "_" + year1;
                pst = con.prepareStatement("select StudentName from " + table + " where StudentId=?");
                pst.setString(1, student);
                rs1 = pst.executeQuery();

                if (rs1.next()) {
                    currentName = rs1.getString(1);      //saving slided student name
                    break;
                }
                year1 = Integer.toString(Integer.parseInt(year1) + 1);
            }
            if (currentName == null) {%>
        <h3> Student with id <%=student%> is not present in <%=currentStream%>.<br>
        </h3>
        <% continue loop;
            }

            //Checking for valid new StudentID
            try {
                pst = con.prepareStatement("select StudentName from " + table1 + " where StudentId=?");
                pst.setString(1, student1);
                rs2 = pst.executeQuery();
            } catch (Exception ex) {
                System.out.println(ex);

            }
            if (rs2.next()) {
                String id = rs2.getString(1);
                if (student1.equals(id)) {%>
        <h3> Student with id <%=student1%> is already present in <%=newStream%>.<br>
        </h3>
        <% continue loop;
                        }

                    }

                    pst = con.prepareStatement("insert into " + table1 + "(StudentId,StudentName)values(?,?)");

                    pst.setString(1, student1);
                    pst.setString(2, currentName);
                    pst.execute();

                    ////############################# Table fields populated ####################################////// 
                    pst = con.prepareStatement("select * from " + programmeName + "_curriculumversions order by Year desc");
                    rs10 = pst.executeQuery();
                    while (rs10.next()) {
                        CurriculumYear = rs10.getInt(1);
                        if (CurriculumYear <= curYear) {

                            latestYear = CurriculumYear;

                            break;
                        }
                    }

                    int core = 0, electives = 0, labs = 0, project = 0, total = 0;
                    pst = con.prepareStatement("SELECT SUM(Cores), SUM(Electives),SUM(Labs), BIT_OR(Projects) FROM " + programmeName + "_" + latestYear + "_currrefer");
                    rs11 = pst.executeQuery();
                    if (rs11.next()) {

                        core = Integer.parseInt(rs11.getString(1));
                        electives = Integer.parseInt(rs11.getString(2));
                        labs = Integer.parseInt(rs11.getString(3));
                        project = Integer.parseInt(rs11.getString(4));
                        total = core + labs + electives + project;
                    }
                    pst = con.prepareStatement("select * from " + programmeName + "_" + latestYear + "_curriculum where Type=?");
                    pst.setString(1, "C");
                    rs22 = pst.executeQuery();
                    if (rs22.next()) {
                        i = 1;
                        while (i <= core) {

                            pst = con.prepareStatement("update " + programmeName + "_" + curYear + " set core" + i + "='" + rs22.getString(2) + "',c" + i + "grade='NR' where StudentId=?");
                            pst.setString(1, student1);
                            pst.executeUpdate();
                            rs22.next();
                            i++;
                        }
                    }
                    pst = con.prepareStatement("select * from " + programmeName + "_" + latestYear + "_curriculum where Type=?");
                    pst.setString(1, "L");
                    rs3 = pst.executeQuery();
                    if (rs3.next()) {
                        i = 1;

                        while (i <= labs) {
                            pst = con.prepareStatement("update " + programmeName + "_" + curYear + " set lab" + i + "='" + rs3.getString(2) + "',l" + i + "grade='NR' where StudentId=?");
                            pst.setString(1, student1);
                            pst.executeUpdate();
                            rs3.next();

                            i++;

                        }
                    }
                    pst = con.prepareStatement("select * from " + programmeName + "_" + latestYear + "_curriculum where Type=?");
                    pst.setString(1, "P");
                    rs4 = pst.executeQuery();
                    if (rs4.next()) {
                        i = 1;
                        while (i <= project) {
                            pst = con.prepareStatement("update " + programmeName + "_" + curYear + " set project" + i + "='" + rs4.getString(2) + "',p" + i + "grade='NR' where StudentId=?");
                            pst.setString(1, student1);
                            pst.executeUpdate();
                            rs4.next();

                            i++;

                        }
                    }
                    pst = con.prepareStatement("select * from " + programmeName + "_" + latestYear + "_curriculum where Type=?");
                    pst.setString(1, "E");
                    rs7 = pst.executeQuery();
                    if (rs7.next()) {
                        i = 1;
                        while (i <= electives) {
                            pst = con.prepareStatement("update " + programmeName + "_" + curYear + " set e" + i + "grade='NR' where StudentId=?");
                            pst.setString(1, student1);
                            pst.executeUpdate();
                            rs7.next();

                            i++;
                        }
                    }
                    pst = con.prepareStatement("delete from " + table + " where StudentId=?");
                    pst.setString(1, student);
                    pst.execute();   //deleting slided student info from his old branch
//                        int a=0;
//                        if(a==0)
//                        {
//                            con.rollback();
//                            out.println("Some internal error! please try again.");
//                            return;
//                            
//                        }

                }
                count++;
          }
//                                     int a=0;
//                        if(a==0)
//                        {
//                            con.rollback();
//                            out.println("Some internal error! please try again.");
//                            return;
//                            
//                        }
   
            con.commit();

            if (count != 0) {%>
        <h2>Sliding Successfully Completed</h2>
        <%    }

            } //try block end
            catch (Exception e) {
                con.rollback();
                System.out.println(e);
                System.out.println("Transaction rollback!!!");
                out.println("Some internal error! please try again.");
            } finally {
                if (con != null && pst != null) {
                    con.close();
                    pst.close();
                }
            }

        %>




    </body>
</html>
