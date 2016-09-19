<%-- 
   Document   : sup-assessment3
   Created on : Jul 5, 2013, 6:30:39 PM
   Author     : root
--%>

<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@ include file="id_parser.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body>
        <%
            //**************************************************************
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            String semester = "";
            String supptable = "";
            if (month <= 6) {
               
                   semester = "Monsoon";
                   cyear = cyear -1;
            } else {
              semester = "Winter";

            }
            int curriculumYear = 0, latestYear = 0;


            //**************************************************************
            Connection con = conn.getConnectionObj();
            System.out.println("Before error");
            Connection con1 = conn1.getConnectionObj();
            String subid = request.getParameter("subjid");
            String subname = request.getParameter("subjname");
            String stuid[] = request.getParameterValues("sid");
            String subjid = subid;
            System.out.println(  subjid +"Heloooooo");
            String sname[] = request.getParameterValues("sname");
            String internal[] = request.getParameterValues("internal");
            String major[] = request.getParameterValues("supp");
            String regular[] = request.getParameterValues("regular");
            String supporimprove[] = request.getParameterValues("supporimprove");

        %>
        <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="80%"> 
            <tr>                             
                <th>Subject<br/><input type="text" name="subjname" id="subjname" class="style30" value="<%=subname%>" size="25" readonly="readonly" />  

                </th><th>Code<br/><input type="text" name="subjid" id="subjid" value="<%=subjid%>" size="10" readonly="readonly" />    

                </th>

            </tr>
        </table>
        </br></br>
        <table border="1" cellspacing="" cellpadding="" style="color:blue;background-color:#CCFFFF;" align="center">
            <tr>


                <th>Student ID</th>
                <th>Student Name</th>
                <th>Internal</th>
                <th>Supplementary/Improvement</th>
                <th>Total</th>
                <th>Grade</th>
            </tr>
            <%
try{
                int i = 0;
                for (i = 0; i < stuid.length; i++) {
            %><tr>
                <td><%=stuid[i]%></td>
                <td><%=sname[i]%></td>
                <td><%=internal[i]%></td>
                <td><%=major[i]%></td>
                <%
                 try{   
                    if (supporimprove[i].equals("S")) {
                        supptable = "supp_" + semester + "_" + cyear;
                    } else {
                        supptable = "imp_" + semester + "_" + cyear;
                    }
                    String PROGRAMME_NAME = stuid[i].substring(SPRGM_PREFIX, EPRGM_PREFIX);
                    String BATCH_YEAR = stuid[i].substring(SYEAR_PREFIX, EYEAR_PREFIX);
                    System.out.println("Before error"+con);
                    Statement st1 = con.createStatement();
                    System.out.println("after error");
                    ResultSet rs = st1.executeQuery("select Programme_group,Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
                    String qry4 = "";
                    if (rs.next()) {


                        qry4 = "select * from " + rs.getString(1).replace('-', '_') + "_grade_table Order By Marks DESC";
                    }
                    float internalmarks = 0;
                    float majormarks = 0;
                    if (internal[i].equals("AB") != true) {
                        internalmarks = Float.parseFloat(internal[i]);
                    }
                    if (major[i].equals("AB") != true) {
                        majormarks = Float.parseFloat(major[i]);
                    }
                    float total = (float)Math.ceil(internalmarks + majormarks);
                %><td><%=total%></td><%
                    Statement st4 = con1.createStatement();
                    ResultSet rs4 = st4.executeQuery(qry4);
                    String Grade = "";
                    while (rs4.next()) {
                        if (total >= rs4.getInt(2)) {
                            Grade = rs4.getString(1);
                            break;
                        } else {
                            Grade = "F";
                        }
                    }
                %><td><%=Grade%></td><%
                    //*******************************************************************
                    Statement st5 = con.createStatement();
                    ResultSet rs5 = st5.executeQuery("select * from " + supptable + " where studentId='" + stuid[i] + "'");
                    ResultSetMetaData rsmd = rs5.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    noOfColumns = noOfColumns - 1;
                    int columns = 2;
                    String suppmarks = "";
                    String suppgrade = "";
                                        boolean flag = true;

                    if (rs5.next() == true) {
                        System.out.println(subid+"hello");
                        while (columns < noOfColumns) {
                              System.out.println("In loop");
                           //   System.out.println(subid);
                              String courseid =  rs5.getString(columns);
                              System.out.println(subid+" "+courseid+"te");
                            if (subjid.equals(courseid)) {
                                suppmarks = rsmd.getColumnName(columns + 1);
                                System.out.println(suppmarks+"Hii");
                                suppgrade = rsmd.getColumnName(columns + 2);
                                System.out.println(suppgrade+"Hello");
                                break;
                            }
                            if( courseid == null )
                            {
                                System.out.println("IN break");
                                break;
                            }
                            else if( courseid!=null && rs5.getString(columns + 2) == null )
                            {
                                flag = false;
                            }
                            columns = columns + 3;
                        }
                    }
                   
                    String q = "update " + supptable + " set " + suppmarks + "='" + majormarks + "'," + suppgrade + "='" + Grade + "' where studentId='" + stuid[i] + "'";
                     System.out.println(q);
                    st5.executeUpdate(q);




                    //*******************************************************************
                    String circulemtable = "";
                    String streamtable = "";
                    String syear = "20" + BATCH_YEAR;
                    ResultSet rs12 = (ResultSet) st5.executeQuery("select * from " + rs.getString(2).replace('-', '_') + "_curriculumversions order by Year desc");
                    while (rs12.next()) {
                        curriculumYear = rs12.getInt(1);
                        if (curriculumYear <= cyear) {

                            latestYear = curriculumYear;

                            break;
                        }
                    }
                    circulemtable = rs.getString(2).replace('-', '_') + "_" + latestYear + "_curriculum";
                    streamtable = rs.getString(2).replace('-', '_') + "_";


                    Statement st6 = con.createStatement();
                    ResultSet rs6 = st6.executeQuery("select * from " + circulemtable + " where Alias='" + subid + "'");
                    if (rs6.next() == true) {
                        subid = rs6.getString(1);
                    }

                    Statement st7 = con.createStatement();
                    int j = 0;
                    while (j < 2) {
                        String streamtable1 = "";
                        streamtable1 = streamtable + syear;

                        ResultSet rs7 = st7.executeQuery("select * from " + streamtable1 + " where StudentId='" + stuid[i] + "'");
                        ResultSetMetaData rsmd1 = rs7.getMetaData();
                        int noOfColumns1 = rsmd1.getColumnCount();

                        if (rs7.next() == true) {

                            int k = 3;
                            while (k < noOfColumns1) {
                                if (subid.equals(rs7.getString(k))) {
                                    String mastercolumnname = rsmd1.getColumnName(k + 1);
                                    // System.out.println(mastercolumnname+"   "+syear);
                                    if (supporimprove[i].equals("I") && Float.parseFloat(regular[i]) < Float.parseFloat(major[i])) {
                                        st5.executeUpdate("update " + streamtable1 + " set " + mastercolumnname + "='" + Grade + "' where StudentId='" + stuid[i] + "'");
                                    }
                                    if (supporimprove[i].equals("S")) {
                                        st5.executeUpdate("update " + streamtable1 + " set " + mastercolumnname + "='" + Grade + "' where StudentId='" + stuid[i] + "'");
                                    }
                                }
                                k = k + 2;
                            }
                            break;
                        } else {
                            syear = Integer.toString(Integer.parseInt(syear) + 1);
                            System.out.println("  qwe " + syear);
                        }

                        j++;
                    }
                    //*******************************************************************            
                 }catch(Exception e){
                     e.printStackTrace();
                 }
                    // System.out.println(total+"   "+Grade);
                %></tr><%
    }
                }
 catch( Exception e)
                            {
                               System.out.println(e);
                            }
                            finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                con1 = null;
                            }
                %>

            </br>
            </br>
            <table align="center" cellspacing="20"><tr><td><div align="center">
                            <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                        </div>
                    </td>
            </table>        

    </body>
</html>
