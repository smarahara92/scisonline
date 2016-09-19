<%-- 
    Document   : programme_mang_viewlink1
--%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Hashtable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .caption{
                font-weight: bold;
            }

            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .heading1
            {
                color: white;
                background-color:#003399;
            }
            .td1
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;

            }

            .td2
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
                color: #003399;
            }
            .td3
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: blue;
                padding: 4px;
            }


        </style>
    </head>
    <body> <%
        Connection con = conn.getConnectionObj();
        try {
            int v = 0, count = 0, colTypeCount = 0, k = 0, l = 0;
            String typePname = "";

            //year and pname parameter retrieving from programme_mang_view.jsp page.
            String year = request.getParameter("year");
            String pname = request.getParameter("pname");

            Statement st1 = null;
            Statement st2 = null;
            Statement st3 = null;
            Statement st4 = null;
            Statement st6 = null;

            try {// Statements creation with checking of dabase connection.
                st1 = con.createStatement();
                st2 = con.createStatement();
                st3 = con.createStatement();
                st4 = con.createStatement();
                st6 = con.createStatement();
            } catch (Exception ex) {//Internal database connection error. Error number:8
                System.out.println(ex); %>
                <script>
                    window.open("Project_exceptions.jsp?check=8", "subdatabase");//here check =6 means error number (if condition number.)
                </script> <%
                return;
            }
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs3 = null;
            ResultSet rs10 = null;
            ResultSet rs6 = null;
            ResultSet rs7 = null;
            ResultSet rs = null;

            pname = pname.replace('-', '_');
            String stream3 = pname.replace('_', '-');
            String ProjectStartSemester = "";
            int curriculumYear = 0, latestYear = 0;
                
            /*
             * view by yearwise
             */
                
            if (!year.equals("All")) {
                try {
                    int year1 = Integer.parseInt(year);
                    try {
                        rs10 = st4.executeQuery("select * from " + pname + "_curriculumversions order by Year desc");
                    } catch (Exception ex) {//curriculum version not exits.  %>
                        <script>
                            window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
                        </script> <%
                        System.out.println(ex);
                        return;
                    }

                    while (rs10.next()) {//retrieving latest curriculum.
                        curriculumYear = rs10.getInt(1);
                        if (curriculumYear <= year1) {
                            latestYear = curriculumYear;
                            System.out.println(latestYear);
                            break;
                        }
                    }
                
                    try {
                        rs1 = st1.executeQuery("select * from " + pname + "_" + latestYear + "_curriculum");
                    } catch (Exception ex) {//curriculum not exists..   %>
                        <script>
                            window.open("Project_exceptions.jsp?check=9", "subdatabase");//here check =6 means error number (if condition number.)
                        </script> <%
                        System.out.println(ex);
                        return;
                    }
                
                    //Dynamic creation of table column names.
                    rs2 = st2.executeQuery("SELECT COUNT(*) FROM " + pname + "_" + latestYear + "_curriculum");

                    rs2.next();
                    count = rs2.getInt(1);

                    ResultSetMetaData metadata = rs1.getMetaData();
                    int columnCount = metadata.getColumnCount(); %>
                    <table border="0">
                        <caption><font size="4"><b><%=stream3%>-<%=latestYear%>-curriculum</b></font></caption>
                        <tr>
                            <td>
                                <table border="1" class="td1"> <%
                                    for (v = 1; v <= columnCount; v++) {
                                        if (rs1.getMetaData().getColumnName(v).equalsIgnoreCase("type")) {
                                            colTypeCount = v;
                                            System.out.println(v);
                                        }

                                        if (rs1.getMetaData().getColumnName(v).equalsIgnoreCase("SubCode")) {%>
                                            <th class="heading">Course Code</th> <%
                                        } else if (rs1.getMetaData().getColumnName(v).equalsIgnoreCase("SubName")) {%>
                                            <th class="heading">Course Name</th> <%
                                        } else {%>
                                            <th class="heading"> <%=rs1.getMetaData().getColumnName(v)%> </th> <%
                                        }
                                    }
                                    int i = 0;
                                    while (rs1.next()) {
                                        if (count > i) { %>
                                            <tr> <%
                                            String pgname = "";
                                            for (v = 1; v <= columnCount; v++) {
                                                if (colTypeCount != v) {
                                                    if (rs1.getString(v) == null) { %>
                                                        <td class="td1"><%=pgname%></td><%
                                                    } else {%>
                                                        <td class="td1"><%=rs1.getString(v)%></td> <%
                                                    }
                                                } else { 
                                                    if (rs1.getString(v) == null) { %>
                                                        <td class="td1"><%=pgname%></td> <%
                                                    } else { 
                                                        if (rs1.getString(v).equalsIgnoreCase("C")) {
                                                            typePname = "Core";
                                                        } else if (rs1.getString(v).equalsIgnoreCase("E")) {
                                                            typePname = "Elective";
                                                        } else if (rs1.getString(v).equalsIgnoreCase("L")) {
                                                            typePname = "Lab";
                                                        } else if (rs1.getString(v).equalsIgnoreCase("P")) { 
                                                            typePname = "Project";
                                                        } %>
                                                        <td class="td1"><%=typePname%></td> <%
                                                    }
                                                }
                                            } %>
                                            </tr> <%
                                            i++;
                                        }
                                    }%> 
                                </table> 
                            </td>
                            <td>
                                <!-- curriculum reference -->
                                </br></br></br>
                                <table align="center">
                                    <tr>
                                        <td> <%
                                            Hashtable hsSem = new Hashtable();
                                            Hashtable hsCore = new Hashtable();
                                            Hashtable hsOCore = new Hashtable();
                                            Hashtable hsLab = new Hashtable();
                                            Hashtable hsElective = new Hashtable();
                                            Hashtable hsProject = new Hashtable();

                                            ResultSet rs0 = scis.executeQuery("select * from " + pname.replace('-', '_') + "_" + latestYear + "_currrefer");
                                            if (rs0 == null) {
                                                out.println("Some internal error occurred. Please contact to system administrator.");
                                                return;
                                            }
                                            while (rs0.next()) {
                                                String sem = rs0.getString("Semester");
                                                int key = scis.roman2num(sem);
                                                hsSem.put(key, sem);
                                                hsCore.put(key, rs0.getString("Cores"));
                                                hsOCore.put(key, rs0.getString("OptionalCore"));
                                                hsLab.put(key, rs0.getString("Labs"));
                                                hsElective.put(key, rs0.getString("Electives"));
                                                hsProject.put(key, rs0.getString("Projects"));
                                            }%>
                                            <table border="1" class="td1">
                                                <th class="heading1">Semester</th>
                                                <th class="heading1">#Cores</th>
                                                <th class="heading1">#Optional Cores</th>
                                                <th class="heading1">#Labs</th>
                                                <th class="heading1">#Electives</th>
                                                <th class="heading1">#Projects</th> <%
                                                String val = null;
                                                for(int z = 1, j = 1; z <= hsSem.size(); z++) {%>
                                                    <tr><%
                                                        val = (String) hsSem.get(z);%>
                                                        <td class="cellpad"><%=val%></td><%
                                                        val = (String) hsCore.get(z); %>
                                                        <td class="cellpad"><%=val%></td><%
                                                        val = (String) hsOCore.get(z); %>
                                                        <td class="cellpad"><%=val%></td><%
                                                        val = (String) hsLab.get(z); %>
                                                        <td class="cellpad"><%=val%></td> <%
                                                        val = (String) hsElective.get(z); %>
                                                        <td class="cellpad"><%=val%></td> <%
                                                        if(z == j) {
                                                            val = (String) hsProject.get(j);
                                                            if (val.equals("0")) {
                                                                ++j;%>
                                                                <td class="cellpad">0</td><%
                                                            } else if(val.equals("1")){
                                                                int pCount = 0;
                                                                do {
                                                                    ++pCount;
                                                                    ++j;
                                                                    val = (String) hsProject.get(j);
                                                                } while(val!= null && val.equals("1"));%>
                                                                <td rowspan="<%=pCount%>" class="cellpad">1</td><%
                                                            }
                                                        }%>
                                                    </tr><%
                                                }
                                                hsSem.clear();
                                                hsCore.clear();
                                                hsOCore.clear();
                                                hsLab.clear();
                                                hsElective.clear();
                                                hsProject.clear();%>                    
                                            </table>
                                        </td></tr>
                                    <tr>
                                        <td> <%
                                            int MaxSemester;
                                            rs = st2.executeQuery("SELECT COUNT(*),SUM(Cores), SUM(Electives),SUM(Labs),SUM(OptionalCore), BIT_OR(Projects) FROM " + pname + "_" + latestYear + "_currrefer");
                                            rs.next();
                                            MaxSemester = Integer.parseInt(rs.getString(1)) + 2; %>
                                            <table border="1" class="td1">
                                                <tr><td class="td2" width="60%">Minimum number of Semesters</td><td width="13%"><%=rs.getString(1)%></td></tr> 
                                                <tr><td class="td2">Maximum number of Semesters</td><td><%=MaxSemester%></td></tr>
                                                <tr><td class="td2">Total Core Subjects </td><td><%=Integer.parseInt(rs.getString(2))%></td></tr>
                                                <tr><td class="td2">Total Elective Subjects</td><td><%=Integer.parseInt(rs.getString(3))%></td></tr>
                                                <tr><td class="td2">Total Labs</td><td><%=Integer.parseInt(rs.getString(4))%></td></tr>
                                                <tr><td class="td2">Total Optional Cores</td><td><%=Integer.parseInt(rs.getString(5))%></td></tr>
                                                <tr><td class="td2">Total Projects</td><td><%=Integer.parseInt(rs.getString(6))%></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table> <%
                } catch (Exception e) {
                    System.out.println(e);
                    return;
                } 
            }
            /*
             *view all 
             */
            if (year.equals("All")) {
                try {
                    try {
                        rs3 = st3.executeQuery("select * from " + pname + "_curriculumversions");//retrieving curriculum names from curriculum versions table

                    } catch (Exception ex) {//curricululm version table is not exists.
                        System.out.println(ex); %>
                        <script>
                            window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
                        </script> <%
                        return;
                    }
                    while (rs3.next()) { //while loop for all curriculums in curriculum versions table
                        String pgrm = rs3.getString(2);
                        pgrm = pgrm.replace('-', '_');
                        String pyear = rs3.getString(1);
                        try {
                            rs1 = st1.executeQuery("select * from " + pname + "_" + pyear + "_curriculum");

                        } catch (Exception ex) {//curricululm table is not exists.
                            System.out.println(ex); %>
                            <script>
                                window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
                            </script> <%
                            return; 
                        }

                        rs2 = st2.executeQuery("SELECT COUNT(*) FROM " + pname + "_" + pyear + "_curriculum");
                        rs2.next();
                        count = rs2.getInt(1);

                        ResultSetMetaData metadata = rs1.getMetaData();
                        int columnCount = metadata.getColumnCount(); %>
                        <table border="0">
                            <caption><font size="4"><b><%=stream3%>-<%=pyear%>-curriculum</b></font></caption>
                            <tr>
                                <td>
                                    <table border="1" class="td1"> <%
                                        for (v = 1; v <= columnCount; v++) {
                                            if (rs1.getMetaData().getColumnName(v).equalsIgnoreCase("type")) {
                                                colTypeCount = v;
                                                System.out.println(v);
                                            }
                                            if (rs1.getMetaData().getColumnName(v).equalsIgnoreCase("SubCode")) {%>
                                                <th class="heading">Course Code</th> <%
                                            } else if (rs1.getMetaData().getColumnName(v).equalsIgnoreCase("SubName")) {%>
                                                <th class="heading">Course Name</th> <%
                                            } else {%>
                                                <th class="heading"> <%=rs1.getMetaData().getColumnName(v)%> </th> <%
                                            }
                                        }%> <%
                                        int i = 0;
                                        while (rs1.next()) {
                                            if (count > i) { %>
                                                <tr> <%
                                                String pgname = "";
                                                    for (v = 1; v <= columnCount; v++) {
                                                        if (colTypeCount != v) {
                                                            if (rs1.getString(v) == null) { %>
                                                                <td class="td1"><%=pgname%></td> <%
                                                            } else { %>
                                                                <td class="td1"><%=rs1.getString(v)%></td> <%
                                                            }
                                                        } else {
                                                            if (rs1.getString(v) == null) { %>
                                                                <td class="td1"><%=pgname%></td> <%
                                                            } else { 
                                                                if (rs1.getString(v).equalsIgnoreCase("C")) {
                                                                    typePname = "Core";
                                                                } else if (rs1.getString(v).equalsIgnoreCase("E")) {
                                                                    typePname = "Elective";
                                                                } else if (rs1.getString(v).equalsIgnoreCase("L")) {
                                                                    typePname = "Lab";
                                                                } else if (rs1.getString(v).equalsIgnoreCase("P")) {
                                                                    typePname = "Project";
                                                                } %>
                                                                <td class="td1"><%=typePname%></td> <%
                                                            }
                                                        }
                                                    } %>
                                                </tr> <%
                                                i++;
                                            }
                                        } %> 
                                    </table> 
                                </td>
                                <td>
                                    <br/><br/><br/>
                                    <table align="center">
                                        <tr>
                                            <td> <%
                                                Hashtable hsSem = new Hashtable();
                                                Hashtable hsCore = new Hashtable();
                                                Hashtable hsOCore = new Hashtable();
                                                Hashtable hsLab = new Hashtable();
                                                Hashtable hsElective = new Hashtable();
                                                Hashtable hsProject = new Hashtable();

                                                ResultSet rs0 = scis.executeQuery("select * from " + pname.replace('-', '_') + "_" + pyear + "_currrefer");
                                                if (rs0 == null) {
                                                    out.println("Some internal error occurred. Please contact to system administrator.");
                                                    return;
                                                }
                                                while (rs0.next()) {
                                                    String sem = rs0.getString("Semester");
                                                    int key = scis.roman2num(sem);
                                                    hsSem.put(key, sem);
                                                    hsCore.put(key, rs0.getString("Cores"));
                                                    hsOCore.put(key, rs0.getString("OptionalCore"));
                                                    hsLab.put(key, rs0.getString("Labs"));
                                                    hsElective.put(key, rs0.getString("Electives"));
                                                    hsProject.put(key, rs0.getString("Projects"));
                                                }%>
                                                <table border="1" class="td1">
                                                    <th class="heading1">Semester</th>
                                                    <th class="heading1">#Cores</th>
                                                    <th class="heading1">#Optional Cores</th>
                                                    <th class="heading1">#Labs</th>
                                                    <th class="heading1">#Electives</th>
                                                    <th class="heading1">#Projects</th> <%
                                                    String val = null;
                                                    for(int z = 1, j = 1; z <= hsSem.size(); z++) {%>
                                                        <tr><%
                                                            val = (String) hsSem.get(z);%>
                                                            <td class="cellpad"><%=val%></td><%
                                                            val = (String) hsCore.get(z); %>
                                                            <td class="cellpad"><%=val%></td><%
                                                            val = (String) hsOCore.get(z); %>
                                                            <td class="cellpad"><%=val%></td><%
                                                            val = (String) hsLab.get(z); %>
                                                            <td class="cellpad"><%=val%></td> <%
                                                            val = (String) hsElective.get(z); %>
                                                            <td class="cellpad"><%=val%></td> <%
                                                            if(z == j) {
                                                                val = (String) hsProject.get(j);
                                                                if (val.equals("0")) {
                                                                    ++j;%>
                                                                    <td class="cellpad">0</td><%
                                                                } else if(val.equals("1")){
                                                                    int pCount = 0;
                                                                    do {
                                                                        ++pCount;
                                                                        ++j;
                                                                        val = (String) hsProject.get(j);
                                                                    } while(val!= null && val.equals("1"));%>
                                                                    <td rowspan="<%=pCount%>" class="cellpad">1</td><%
                                                                }
                                                            }%>
                                                        </tr><%
                                                    }
                                                    hsSem.clear();
                                                    hsCore.clear();
                                                    hsOCore.clear();
                                                    hsLab.clear();
                                                    hsElective.clear();
                                                    hsProject.clear();%>                    
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td> <%
                                                int MaxSemester;
                                                rs = st2.executeQuery("SELECT COUNT(*),SUM(Cores), SUM(Electives),SUM(Labs),SUM(OptionalCore), BIT_OR(Projects) FROM " + pname + "_" + pyear + "_currrefer");
                                                rs.next();
                                                MaxSemester = Integer.parseInt(rs.getString(1)) + 2; %>
                                                <table border="1" class="td1">
                                                    <tr><td class="td2" width="60%">Minimum number of Semesters</td><td width="13%"><%=rs.getString(1)%></td></tr> 
                                                    <tr><td class="td2">Maximum number of Semesters</td><td><%=MaxSemester%></td></tr>
                                                    <tr><td class="td2">Total Core subjects </td><td><%=Integer.parseInt(rs.getString(2))%></td></tr>
                                                    <tr><td class="td2">Optional Core</td><td><%=Integer.parseInt(rs.getString(5))%></td></tr>
                                                    <tr><td class="td2">Total Elective Subjects</td><td><%=Integer.parseInt(rs.getString(3))%></td></tr>
                                                    <tr><td class="td2">Total Labs</td><td><%=Integer.parseInt(rs.getString(4))%></td></tr>
                                                    <tr><td class="td2">Total Projects</td><td><%=Integer.parseInt(rs.getString(6))%></td></tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table> <%
                    }
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
            rs1.close();
            rs2.close();
            rs3.close();
            rs10.close();
            rs6.close();
            rs7.close();
            rs.close();
            st1.close();
            st2.close();
            st3.close();
            st4.close();
            st6.close();
        } catch (Exception ex) {
            System.out.println(ex);
        } 
        conn.closeConnection();
        con = null; %>            
    </body>
</html>