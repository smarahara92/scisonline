<%-- 
    Document   : Demo
    Created on : Mar 30, 2015, 11:51:10 AM
    Author     : richa
--%>
<%@include file ="connectionBean.jsp" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%--<%@page import="com.hcu.con"%>--%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link rel="stylesheet" href="./css/query_display_style.css">
        
    </head>
    <body>

<%
            int year = scis.getLatestYear();
            String semester = scis.getLatestSemester();
            int current_year = year;
            String StreamName = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");
            String year2 = request.getParameter("year");
            String stream = request.getParameter("streamname");
            int flag = 0;
            int sno = 1;
            int CurriculumYear = 0, LatestYear = 0;
            String stream1 = StreamName;
            StreamName = StreamName.replace('-', '_');
%>
   
   
<%
        //out.println(year2+"   "+stream);
        Connection con = conn.getConnectionObj();
        try{
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st7 = con.createStatement();
        Statement stmt01 = con.createStatement();
        ResultSet RS = null;
        ResultSet rs1 = st1.executeQuery("select * from " + StreamName + "_" + BatchYear + "");
        ResultSetMetaData rsmd = rs1.getMetaData();
        int noOfColumns = rsmd.getColumnCount();
        int n =1 ;
        int sflag = 0;
        while (rs1.next()) {
                n =1;
                flag = 0;
                int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
                int cummatten = 0;
                int total = 0;
                int i = 0;
                float percentage = 0;
                String subjects = "";
                int noofsubjects = 0;
                //##########################################################################################################

                /*
                 * Taking correct version of curriculum for particular programme
                 */
                ResultSet rs10 = st4.executeQuery("select * from " + StreamName + "_curriculumversions order by Year desc");
                while (rs10.next()) {
                    CurriculumYear = rs10.getInt(1);
                    if (CurriculumYear <= Integer.parseInt(BatchYear)) {

                        LatestYear = CurriculumYear;
                        System.out.println(LatestYear);
                        break;
                    }
                }
                //##########################################################################################################
                while (temp > 0) {

                    int m = i + 3;
                    String R = "R";
                    String R1 = "A+";
                    String R2 = "A";
                    String R3 = "B+";
                    String R4 = "B";
                    String R5 = "C";
                    String R6 = "D";
                    String R7 = "F";
                    if (R.equals(rs1.getString(m + 1)) || R1.equals(rs1.getString(m + 1)) || R2.equals(rs1.getString(m + 1)) || R3.equals(rs1.getString(m + 1))
                            || R4.equals(rs1.getString(m + 1)) || R5.equals(rs1.getString(m + 1)) || R6.equals(rs1.getString(m + 1)) || R7.equals(rs1.getString(m + 1))) {
                        String modified = rs1.getString(m);

                        ResultSet rs11 = st2.executeQuery("select Alias from " + StreamName + "_" + LatestYear + "_curriculum where SubCode='" + modified + "'");
                        while (rs11.next()) {
                            if (rs11.getString(1) != null) {
                                modified = rs11.getString(1);
                            }
                        }
            %>


            <%
                try {
                    String qry3 = "select percentage  from " + modified + "_Attendance_" + semester + "_" + year + " where StudentId='" + rs1.getString(1) + "'";
                    ResultSet rs3 = st3.executeQuery(qry3);
                    RS = stmt01.executeQuery("select Subject_Name from subjecttable where Code='"+modified+"'");
                    RS.next();
                    while (rs3.next()) {
                        percentage = percentage + rs3.getFloat(1);
                        noofsubjects = noofsubjects + 1;
                        if (Math.ceil(rs3.getFloat(1))  < 75.0) {
                             subjects = subjects + "   " + modified + "("+RS.getString(1)+")"+":" + Math.ceil(rs3.getFloat(1)) +"<br /> ";
                             
                            flag =1;
                        }
                    }
                    
                } catch (Exception ex) {
                }%>
            <%}
                    i = i + 2;
                    temp--;
                }
%>
            

            <%
               if(flag==1){
               if(sflag == 0 ){
%>
    <center><h3 style="color:red">List of students who have less than 75% attendance in Stream: <font style="color: blue"><%=stream1%></font>
            and Batch:<font style="color: blue"><%=BatchYear%></font> Batch</h3></center>
    <table  align="center" border="1" class = "maintable">
        <col width="8%">
            <col width="15%">
            <col width="25%">
            <col width="52%">
        <tr>
            <th class="heading" align="center">SNo</th>
            <th class="heading" align="center">Student ID</th>
            <th class="heading" align="center">Student Name</th>
            <th class="heading" align="center">Subjects</th>
        </tr>
<%                   sflag++;
               }
%>
                 <tr>
                                    <td class = "cellpad"><%=sno++%></td>
                                    <td class = "cellpad"><%=rs1.getString(1)%></td>
                                    <td class = "cellpad"><%=rs1.getString(2)%></td>      
                                    <td class = "cellpad"><%=subjects%></td>   
                           <%  }%>
        </tr>
         <%}%>
    </table>
     
    <%} catch (Exception e) {
            out.println("<center><h2>Data not found</h2></center>");
            e.printStackTrace();
        }finally{
            conn.closeConnection();
            con = null;
        }
        if(flag == 0 && sno == 1){%>
        <center><h3 style="color: red">There are no students with less than 75% attendance in  <font style="color: blue"><%= stream1%> <%=BatchYear%></font> Batch </h3></center>
             </script>
       <% }
    %>
    
</body>
</html>
