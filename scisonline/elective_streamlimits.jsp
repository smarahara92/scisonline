<%-- 
    Document   : elective_streamlimits
--%>

<%@include file="checkValidity.jsp"%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="connectionBean.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
        </style>
        <script>
            function disableEnterKey(e) {
                var key;
                if(window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox
                if(key === 13)
                    return false;
                else
                    return true;
            }
            function dothis(j,i)
            { 
                //alert(j+"and"+i);
                //var temp="input"+j+integer.toString(i);
                var cmp1=document.getElementById("input"+j+i).value;
                ;
                cmp1=cmp1.replace(/^\s+|\s+$/g,'');
                if(cmp1.length==0)
                {
                    document.getElementById("input"+j+i).value='0';
                    document.getElementById("input"+j+i).style.color='black';
                        
                    //document.getElementById("xx").disabled =false;
                    return;
                }
                var p=0,q=0;
                for(p=0; p<cmp1.length;p++)
                {	
                    //alert(cmp1.charCodeAt(i));		
                    if (cmp1.charCodeAt(p) <48 ||cmp1.charCodeAt(p) >57)
                    {			
                        alert("invalid input");
                        //document.getElementById("input"+j+i).value='0';
                        document.getElementById("input"+j+i).style.color='red';
                        //document.getElementById("input"+j+i).style.color='red';
                        document.getElementById("input"+j+i).focus();
                        //  document.getElementById("xx").disabled = true;
                        break;       
                        //return 1;                        
                    }
                }
            
               
                
            }
        </script>
    </head>
    <body>
<%
        Connection con = conn.getConnectionObj();
%>
        <table width="100%">
            <tr>
                <td align="center" class="style30"><h1>Assign Electives to Streams</h1></td>
            </tr>
            <%
                try {
                    String given_session = request.getParameter("current_session");
                    String given_year = request.getParameter("year2");

                    int given_year_i = Integer.parseInt(given_year);

                    Calendar cal = Calendar.getInstance();
                    // int year = cal.get(Calendar.YEAR);
                    //int month = cal.get(Calendar.MONTH);
                    //month=month+1;
                    Statement st4 = (Statement) con.createStatement();
                    Statement st5 = (Statement) con.createStatement();
                    Statement st6 = (Statement) con.createStatement();
                    String query1 = "select Subject_name from " + given_year + "_" + given_session + "_elective as t1, subjecttable as t2 where t1.course_name = t2.Code";
                    ResultSet rs1 = (ResultSet) st4.executeQuery(query1);
                    ResultSet rs2 = (ResultSet) st5.executeQuery("select * from subjecttable");
                    ResultSet rs3 = (ResultSet) st6.executeQuery("select * from " + given_year + "_" + given_session + "_elective");


                    Statement st20_ele_dyn = (Statement) con.createStatement();
                    ResultSet rs_ele_dyn = (ResultSet) st20_ele_dyn.executeQuery("select * from " + given_session + "_stream where electives='yes'");
                    int count_courses = 0;
                    String courses[] = new String[50];


            %>
            <tr>
                <td>
                    <form action="streamRegister.jsp" method="post" >
                        <table align="center" border="1">
                            <tr bgcolor="#c2000d">
                                <th align="center" class="style31">S.No</th>
                                <th align="center" class="style31">Course Name</th>
                                <%
                                    while (rs_ele_dyn.next()) {
                                        // st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD " + rs_ele_dyn.getString(1).replace('-','_') + " INT(11)");
                                        courses[count_courses] = rs_ele_dyn.getString(1).replace('-', '_');
                                        count_courses++;
                                %>
                                <th align="center" class="style31"><%=rs_ele_dyn.getString(1).replace('-', ' ')%></th>
                                <%

                                    }
                                %>
                                <th align="center" class="style31">Pre Req 1</th>
                                <th align="center" class="style31">Grade 1</th>
                                <th align="center" class="style31">Pre Req 2</th>
                                <th align="center" class="style31">Grade 2</th>

                            </tr>

                            <%
                                int i = 1; // rows
                                int j = 0; // columns
                                while (rs1.next() && rs3.next()) {
                            %>
                            <tr>
                                <td align="center" ><%=i%></td>
                                <td align="center" ><%=rs1.getString(1)%></td>

                                <%


                                    for (j = 0; j < count_courses; j++) {
                                        String col = courses[j];

                                        int find = 0;
                                        //$$$$$$$$$$$$$$$$$$$// see this subject is core for any programe,if yes diable that limit.
                                        Statement st6_prgm = (Statement) con.createStatement();
                                        Statement st7_prgm = (Statement) con.createStatement();

                                        ResultSet rs6_prgm = (ResultSet) st6_prgm.executeQuery("select * from programme_table where Programme_status=1");
                                        while (rs6_prgm.next()) {
                                            String prgm = rs6_prgm.getString(1);
                                            // both elective table and the data from the prgm_table should be equal,so conver - to _.
                                            prgm = prgm.replace("-", "_");
                                            System.out.println("progrmas" + prgm);

                                            if (col.contains(prgm)) {

                                                /*
                                                 *code for taking latest curriculum
                                                 */

                                                int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
                                                Statement st10_cur = (Statement) con.createStatement();

                                                ResultSet rs10_cur = st10_cur.executeQuery("select * from " + prgm + "_curriculumversions order by Year desc");
                                                while (rs10_cur.next()) {
                                                    curriculumYear = rs10_cur.getInt(1);
                                                    if (curriculumYear <= given_year_i) {

                                                        latestYear = curriculumYear;
                                                        System.out.println(latestYear + prgm);
                                                        break;
                                                    }
                                                }

                                                /*
                                                 *code for taking latest curriculum over here
                                                 */


                                                //            
                                                String prgm_curr = prgm + "_" + latestYear + "_curriculum";
                                                ResultSet rs7_prgm = (ResultSet) st7_prgm.executeQuery("select * from " + prgm_curr + " where subcode='" + rs3.getString(1) + "'");
                                                if (rs7_prgm.next()) {
                                                    find = 1;

                                                }
                                                rs6_prgm.last();
                                            }


                                        }
                                        if (find == 1) {
                                %>

                                <td align="center"><input type="text" size="4" name="input<%=j%><%=Integer.toString(i)%>" id="input<%=j%><%=Integer.toString(i)%>0" value="<%=rs3.getInt(col)%>" tabindex="<%=i + 1%>"  disabled="disabled" ></td>
                                    <%

                                    } else {


                                    %>

                                <td align="center"><input type="text" size="4" name="input<%=j%><%=Integer.toString(i)%>"  id="input<%=j%><%=Integer.toString(i)%>"  value="<%=rs3.getInt(col)%>" onKeyPress="return disableEnterKey(event)" onchange="dothis(<%=j%>, <%=Integer.toString(i)%>);" ></td>
                                    <%
                                            }
                                        }
                                        //System.out.println("th.srinivas1");
                                        j = j * 100; // for increase the input number

                                    %>

                                <td>
                                    <select name="input<%=j%><%=Integer.toString(i)%>" style="width:200px" id="select1<%=Integer.toString(i)%>" style="width:100px;">
                                        <option>none</option>
                                        <%

                                            while (rs2.next()) {
                                                if (rs3.getString("pre_req_1") != null && rs3.getString("pre_req_1").equals(rs2.getString(1))) {

                                        %> <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option><%
                                        } else {
                                        %>

                                        <option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>
                                        <%}
                                            }
                                            rs2.beforeFirst();
                                        %>
                                    </select>
                                </td>
                                <td>
                                    <%
                                        j = j + 1;
                                    %>
                                    <select name="input<%=j%><%=Integer.toString(i)%>" id="select1<%=Integer.toString(i)%>" style="width:70px;">

                                        <option value="">none</option>
                                        <% //System.out.println("LLLLLLLLLLLLL"+rs3.getString(21));      
                                            if (rs3.getString("pre_req_grade1") != null && rs3.getString("pre_req_grade1").equals("B") == true) {
                                        %> <option value="B" selected>B</option><%                                                       } else {
                                        %> <option value="B">B</option><%                                                            }
                                            if (rs3.getString("pre_req_grade1") != null && rs3.getString("pre_req_grade1").equals("B+") == true) {

                                        %> <option value="B+" selected>B+</option><%                                                          } else {
                                        %> <option value="B+">B+</option><%                                                            }
                                            if (rs3.getString("pre_req_grade1") != null && rs3.getString("pre_req_grade1").equals("A") == true) {
                                        %> <option value="A" selected>A</option><%                                                       } else {
                                        %> <option value="A">A</option><%                                                            }
                                            if (rs3.getString("pre_req_grade1") != null && rs3.getString("pre_req_grade1").equals("A+") == true) {
                                        %> <option value="A+" selected>A+</option><%                                                       } else {
                                        %> <option value="A+">A+</option><%                                                            }%>                                                                                                   
                                    </select>
                                </td>
                                <td>
                                    <%
                                        j = j + 1;
                                    %>
                                    <select name="input<%=j%><%=Integer.toString(i)%>" style="width:200px" id="select1<%=Integer.toString(i)%>" style="width:100px;">
                                        <option>none</option>
                                        <%
                                            while (rs2.next()) {
                                                if (rs3.getString("pre_req_2") != null && rs3.getString("pre_req_2").equals(rs2.getString(1))) {
                                        %> <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option><%
                                        } else {%>
                                        <option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>
                                        <%}
                                            }
                                            rs2.beforeFirst();
                                        %>
                                    </select>
                                </td>
                                <td>
                                    <%
                                        j = j + 1;
                                    %>
                                    <select name="input<%=j%><%=Integer.toString(i)%>" id="select1<%=Integer.toString(i)%>" style="width:70px;">
                                        <option value="">none</option>
                                        <% //System.out.println("LLLLLLLLLLLLL"+rs3.getString(21));      
                                            if (rs3.getString("pre_req_grade2") != null && rs3.getString("pre_req_grade2").equals("B") == true) {
                                        %> <option value="B" selected>B</option><%                                                       } else {
                                        %> <option value="B">B</option><%                                                            }
                                            if (rs3.getString("pre_req_grade2") != null && rs3.getString("pre_req_grade2").equals("B+") == true) {

                                        %> <option value="B+" selected>B+</option><%                                                          } else {
                                        %> <option value="B+">B+</option><%                                                            }
                                            if (rs3.getString("pre_req_grade2") != null && rs3.getString("pre_req_grade2").equals("A") == true) {
                                        %> <option value="A" selected>A</option><%                                                       } else {
                                        %> <option value="A">A</option><%                                                            }
                                            if (rs3.getString("pre_req_grade2") != null && rs3.getString("pre_req_grade2").equals("A+") == true) {
                                        %> <option value="A+" selected>A+</option><%                                                       } else {
                                        %> <option value="A+">A+</option><%                                                            }%>                            
                                    </select>
                                </td>
                            </tr>
                            <%
                                    i++;
                                }

                            %>
                        </table>
                        &nbsp;
                        <table width="100%" class="pos_fixed">
                            <tr>
                                <td align="center" class="border"><input type="submit" name="submit" value="SUBMIT" ></td>
                            </tr>
                        </table> 
                        <input type="hidden" name="given_session" value="<%=given_session%>">
                        <input type="hidden" name="given_year" value="<%=given_year%>">
                        <input type="hidden" name="count_courses" value="<%=count_courses%>">
                        <%
                            session.setAttribute("courses", courses);
                        %>

                    </form>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
<%
                rs1.close();
                rs2.close();
                rs3.close();
                rs_ele_dyn.close();

            } catch (Exception ex) {
                System.out.println("eerrorr here");
                System.out.println(ex);
            }
        conn.closeConnection();
        con = null;
%>
    </body>
</html>