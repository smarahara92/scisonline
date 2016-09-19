<%-- 
   Document   : readmin
   Created on : Mar 14, 2012, 9:58:10 AM
   Author     : admin
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@include file ="connectionBean.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@ include file="id_parser.jsp" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
        <script>

            function check()
            {
                var cnt = document.getElementById("nosub").value;
                               var i = 0, j = 0;
                for (i = 1; i <= cnt; i++)
                {
                    var k = document.getElementById("check" + i).checked;
                    if (k === false)
                        j++;
                    
                }
                if (j == cnt)
                {
                    alert("select atleast one subject");
                    return false;
                }
            }

        </script>
    </head>
    <form name="frm" action="sup_registration1.jsp" method="post" onsubmit="return check();">

        <%
            Connection con = conn.getConnectionObj();
            try{
            HashMap hm = new HashMap();
            HashMap hm1 = new HashMap();
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);

            String semester = "";
            int year2 = cyear;
            int year1 = year2;
            int studentsem1 = 0;

            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            String studentId = request.getParameter("studentid");
            String studentName = request.getParameter("stuname");
            String count1 = request.getParameter("count");
            int count2 = Integer.parseInt(count1);
            int BATCH_YEAR = Integer.parseInt("20" + (studentId.substring(SYEAR_PREFIX, EYEAR_PREFIX)));
            String programmecode = studentId.substring(4, 6);

            System.out.println(programmecode);
            if (month <= 6) {
                semester = "Monsoon";
                year2 = cyear - 1;
                studentsem1 = 1;
            } else {
                semester = "Winter";
                year2 = cyear - 1;
                studentsem1 = 2;
            }


            int curriculumYear = 0;
            int latestYear = 0;
            int batchYear = 0;
            int countt = 0;
            String selectstream = null;
            String stream = null;
            ResultSet rs = null;
            ResultSet rs11 = null;
            ResultSet rs111 = null;
            ResultSet rs13 = null;
        %> 
        <center><h2>Supplementary Registration</h2></caption></center>
        <center align="center">


            <input type="text" readonly="yes" name="studentid" value="<%=studentId%>" style=" font-weight: bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" readonly="yes" name="studentname" value="<%=studentName%>" style="  font-weight: bold">

        </center> <br> 


        <table border="1"  align="center" width="46%">
            <%
                int j = 0;
                int studentsem = 0;

                System.out.println("In supply");
                        int start = cyear;
                rs = st1.executeQuery("select Programme_name, Programme_group from programme_table where (Programme_code='" + programmecode + "' and Programme_status='1' and not Programme_name ='PhD')");

                while (rs.next()) {
                    year1 = year2;
                    selectstream = rs.getString(1).replace('-', '_');
                    stream = rs.getString(2).replace('-', '_');
                     int flag10 = 1;
                    //curriculum for programme.
                    System.out.println("SUP..."+ selectstream);
                    ResultSet rs12 = (ResultSet) st2.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                    while (rs12.next()) {
                        curriculumYear = rs12.getInt(1);
                        if (curriculumYear <= BATCH_YEAR && flag10!=0  ) {

                            latestYear = curriculumYear;
                            flag10 = 0;
                            start = curriculumYear;
                            break;
                        }
                    }

                    //getting batch year for project student
                    rs13 = (ResultSet) st3.executeQuery("select count(*) from " + selectstream + "_" + latestYear + "_currrefer");
                    rs13.next();
                    int rowsCount = rs13.getInt(1);
                    rowsCount = rowsCount / 2;// programme duration


                    int rowsCount1 = rowsCount - 1;
                    batchYear = cyear - rowsCount1;//batch year

                    //*************************************************************
                    j = 0;
                    int semcount = 0, l = 0;
                    
            
                    while (j < rowsCount && start <= year1 ) {
                        ResultSet rs1 = null;
                        try{
                        rs1 = st4.executeQuery("select * from " + selectstream + "_" + year1 + "");
                        }
                        catch( Exception e)
                        {
                            
                        }

                        if (l > 0) {
                            if (semester.equals("Moonson")) {

                                studentsem = studentsem + 2;



                            } else {

                                studentsem = studentsem + 2;



                            }

                        }

                        while (rs1.next()) {
                            ResultSetMetaData rsmd = rs1.getMetaData();
                            int noOfColumns = rsmd.getColumnCount();
                            int temp = (noOfColumns - 2) / 2;
                            int i = 0;
                            int count = 0;


                            while (temp > 0) {
                                int m = i + 3;
                                String F = "F";
                                if (F.equals(rs1.getString(m + 1))) {
                                    rs11 = st5.executeQuery("select Alias from " + selectstream + "_" + latestYear + "_curriculum where SubCode='" + rs1.getString(m) + "'");
                                    String subjectname = rs1.getString(m);
                                    while (rs11.next()) {
                                        if (rs11.getString(1) != null) {
                                            subjectname = rs11.getString(1);
                                        }
                                    }

                                    if (hm.containsKey(rs1.getString(1)) == true) {
                                        String x = (String) hm1.get(rs1.getString(1));
                                        x = x + " ," + subjectname + "";

                                        hm1.put(rs1.getString(1), x);
                                    } else {

                                        hm.put(rs1.getString(1), rs1.getString(2));
                                        hm1.put(rs1.getString(1), subjectname);
                                    }

                                }
                                i = i + 2;
                                temp--;
                            }

                        }

                        j++;
                        year1--;
                    }
                }




                //*************************************************************************************************************




                //*************************************************************************************************************

                st6.executeUpdate("create table if not exists supp_" + semester + "_" + cyear + "(studentId varchar(20),coursename1 varchar(20),Marks1 varchar(20),Grade1 varchar(20),"
                        + "                          coursename2 varchar(20),Marks2 varchar(20),Grade2 varchar(20)"
                        + "                          ,coursename3 varchar(20),Marks3 varchar(20),Grade3 varchar(20)"
                        + "                          ,coursename4 varchar(20),Marks4 varchar(20),Grade4 varchar(20)"
                        + "                          ,coursename5 varchar(20),Marks5 varchar(20),Grade5 varchar(20)"
                        + "                          ,coursename6 varchar(20),Marks6 varchar(20),Grade6 varchar(20)"
                        + "                          ,coursename7 varchar(20),Marks7 varchar(20),Grade7 varchar(20)"
                        + "                        ,primary key(studentId))");


                //***********************************************************************************************************
                Set set = hm.entrySet();
                // Get an iterator
                Iterator i = set.iterator();
                // Display elements
%>

            <%
                int count3 = 0;
                while (i.hasNext()) {
                    Map.Entry me = (Map.Entry) i.next();
                    String stid = (String) me.getKey();
                    if (studentId.equalsIgnoreCase(stid)) {

            %> <tr>
               
                <%
                    System.out.println("rs111"+rs111);
                    Statement st11 = con.createStatement();
                    rs111 = st11.executeQuery("select * from supp_" + semester + "_" + cyear + " where studentId='" + studentId + "'");
                    ResultSetMetaData rsmd = rs111.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    noOfColumns = noOfColumns - 1;

                    String str = (String) hm1.get(me.getKey());
                    StringTokenizer stt = new StringTokenizer(str, ",");
                    countt = 0;
                    while (stt.hasMoreElements()) {
                        countt++;
                        String small = (String) stt.nextElement();
                        small = small.trim();
                        String old = "";
                        if (semester.equals("Monsoon")) {
                            old = "subject_faculty_Monsoon_" + (cyear-1) + "";
                        } else {
                            old = "subject_faculty_Winter_" + cyear + "";
                        }
                        String qry8 = "select * from " + old + "";
                        ResultSet rs8 = st7.executeQuery(qry8);
                        int flag = 0;
                        while (rs8.next()) {
                            if (rs8.getString(1).equals(small)) {
                                flag = 1;
                                break;
                            }
                        }
                        String qry7 = "select Subject_Name from subjecttable where Code='" + small + "'";

                        ResultSet rs7 = st8.executeQuery(qry7);
                        rs7.next();
                        String subjectname = rs7.getString(1);
                        int len = subjectname.length();
                        System.out.println("rs1111 "+rs111);
                        len = len + 300;
                        if (flag == 1) {
                            int flag1 = 0;
                            while (rs111.next()) {
                                int columns = 2;
                                while (columns < noOfColumns) {
                                    System.out.println(rs111.getString(columns));
                                    if (small.equals(rs111.getString(columns))) {
                                        flag1 = 1;
                                        break;
                                    }
                                    columns = columns + 3;

                                }
                            }
                            rs111.beforeFirst();
                            if (flag1 == 1) {

                %>
                <td><input name="supp" id="check<%=countt%>" value="<%=small%>" type="checkbox" checked></td>
                    <%
                    } else {
                    %>
                <td><input name="supp" value="<%=small%>" id="check<%=countt%>" type="checkbox"></td>
                    <%
                        }
                    %>
                <td><input type="text"  value="<%=subjectname%>" readonly style=" width: 99%"></td>
                    <%
                    } else {
                    %>
                <td><input name="supp" id="check<%=countt%>" type="checkbox" disabled></td>
                <td><input type="text" value="<%=subjectname%>" readonly style=" width: 99%"></td>
                    <%
                        }%>
               
            </tr>

            <%
                        
                        }
                   //     System.out.print(rs111);
                        break;
                    }


                }
            %>

        </table>
            <input type="hidden" name="countt" id="nosub" value="<%=countt%>">
        </br>
        <div align="center">
            <input type="submit" value="submit"/>
        </div>

        <%
            }catch (Exception e) {
                out.println(e.getMessage());
                e.printStackTrace();
            } finally{
              conn.closeConnection();
              con = null;
        }
  
        %>

    </body>
</form>
</html>
