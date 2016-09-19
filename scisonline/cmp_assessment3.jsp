<%-- 
    Document   : cmp_assessment3
    Created on : April 25, 2014, 1:49:21 PM
    Author     : srinu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>  
<%@include file="university-school-info.jsp"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            if (month >= 1 && month <= 6) {
                cyear = cyear - 1;
            }

            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st6 = con2.createStatement();
            Statement st20 = con2.createStatement();
            Statement st21 = con2.createStatement();
            Statement st22 = con2.createStatement();

            String studentid[] = request.getParameterValues("stuid");
            String stuname[] = request.getParameterValues("stuname");
            String marks[] = request.getParameterValues("marks");
            String subid = request.getParameter("subid");
            String subname = request.getParameter("subname");
        %>   

    <center><b><%=UNIVERSITY_NAME%></b></center>
    <center><b><%=SCHOOL_NAME%></b></center>
    <center><b><%=subname%> Assessment</b></center>
    </br></br>
    <table border="5" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">

        <tr>
            <th>StudentId</th>
            <th>StudentName</th>
            <th>Marks</th>
            <th>Pass/Fail</th>
        </tr>
        <%
            /*
             *code for taking latest curriculum
             */

            int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
            Statement st10_cur = (Statement) con2.createStatement();

            ResultSet rs10_cur = st10_cur.executeQuery("select * from  PhD_curriculumversions order by Year desc");
            while (rs10_cur.next()) {
                curriculumYear = rs10_cur.getInt(1);

                if (curriculumYear <= cyear) {

                    latestYear = curriculumYear;
                    System.out.println(latestYear);
                    break;
                }
            }
            // done   code for taking latest curriculum


            // get the new curriculum.
            ResultSet rs3 = st3.executeQuery("select * from PhD_" + latestYear + "_currrefer ");
            // ResultSet rs3=st3.executeQuery("select * from PhD_curriculum offset limit 1");
            rs3.next();
            int noofelectives = Integer.parseInt(rs3.getString(2));
            int noofcores = Integer.parseInt(rs3.getString(1));


            int i = 0;
            for (i = 0; i < studentid.length; i++) {
                String grade = "P";
                // marks are hard coded here.
                if (Float.parseFloat(marks[i]) < 50) {
                    grade = "F";
                }
        %>
        <tr>
            <td align="center"><%=studentid[i]%></td>
            <td align="center"><%=stuname[i]%></td>
            <td align="center"><%=marks[i]%></td>
            <td align="center"><%=grade%></td>
        </tr>

        <%
                ResultSet rs20 = st20.executeQuery("select * from comprehensive_" + cyear + " where StudentId='" + studentid[i] + "'");
                rs20.next();

                int j = 1;
                int corecount = 0;
                int elecount = 0;
                while (j <= noofcores) {
                    if (rs20.getString("core" + j) != null && rs20.getString("core" + j).equals(subid)) {
                        st6.executeUpdate("update comprehensive_" + cyear + " set c" + j + "marks='" + marks[i] + "' where StudentId='" + rs20.getString(1) + "'");
                        st6.executeUpdate("update comprehensive_" + cyear + " set c" + j + "grade='" + grade + "' where StudentId='" + rs20.getString(1) + "'");
                        break;
                    }

                    j++;
                }


                j = 1;
                while (j <= noofelectives) {
                    if (rs20.getString("ele" + j) != null && rs20.getString("ele" + j).equals(subid)) {
                        st6.executeUpdate("update comprehensive_" + cyear + " set e" + j + "marks='" + marks[i] + "' where StudentId='" + rs20.getString(1) + "'");
                        st6.executeUpdate("update comprehensive_" + cyear + " set e" + j + "grade='" + grade + "' where StudentId='" + rs20.getString(1) + "'");
                        break;
                    }
                    j++;

                }

// to get to know how many comprehensives passed.
                
                ResultSet rs21 = st21.executeQuery("select * from PhD_" + cyear + " where StudentId='" + studentid[i] + "'");
                ResultSet rs_comp = st22.executeQuery("select * from comprehensive_" + cyear + " where StudentId='" + studentid[i] + "'");
                
                j = 1;
                if (rs_comp.next() && rs21.next()) {
                    while (j <= noofcores) {
                        // check core grades and flag, it can be used to check all comprehensive are passed or not.
                        if (rs_comp.getString("c" + j + "grade").equalsIgnoreCase("P")) {
                            corecount++;
                        }
                        j++;

                    }


                    j = 1;
                    while (j <= noofelectives) {
                        //  check ele grades and flag, it can be used to check all comprehensive are passed or not.
                        if (rs_comp.getString("e" + j + "grade").equalsIgnoreCase("P")) {
                            elecount++;
                        }
                        j++;
                    }


                    /* *******************************************************************************************
                     1)we can test all the comprehensives are  passed by this student or not here. if all are passed change the status to R .
                     2)else check if one year is over then make the status as C.
                     ************************************************************************************ */
                    if (elecount == noofelectives && corecount == noofcores) {

                        st6.executeUpdate("update PhD_" + cyear + " set status='R' where StudentId='" + rs20.getString(1) + "'");
                    } else {
                        // suppose if the comprehensives mistake and corrected it again, student got failed so we have to change the status from R to A.
                        if(rs21.getString("status").equalsIgnoreCase("R"))
                        st6.executeUpdate("update PhD_" + cyear + " set status='A' where StudentId='" + rs20.getString(1) + "'");
                        if(month<=6){
                         st6.executeUpdate("update PhD_" + cyear + " set status='C' where StudentId='" + rs20.getString(1) + "'");
                     
                        }
                        
                    }
                    // we have to write some more logic here for else part, since if the student wont pass all comprehensives by 1 yr after 
                    // after joining we may consider him/her status as C (cancel).
                    System.out.println(studentid[i] + " ele :" + elecount + " and core:" + corecount);
                }
                rs21.close();
                rs_comp.close();
            }
            try{
                st1.close();
                st2.close();
                st3.close();
                st6.close();
                st20.close();
                st21.close();
                st22.close();
                st10_cur.close();
                rs10_cur.close();
                rs3.close();
                
            }
            catch(Exception e){
                System.out.println(e);
            }
            finally{
                con.close();
                con2.close();
            }
        %>

    </table>    

</body>
</html>
