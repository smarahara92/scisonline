<%-- 
    Document   : sub-faconline
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("user");
    if(username == null) {
        response.sendRedirect("http://localhost:8084/scisonline/");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading {
                color: white;
                background-color: #c2000d;
            }
            .border {
                background-color: #c2000d;
            }
            .pos_fixed {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            function chechthis(select, temp) {
                var selectlist = ["select1","select2","select3", "select4", "select5", "select6"];
                var selected = parseInt(document.getElementById(select+temp).options.selectedIndex);
                //alert("selected"+selected);
               // alert(temp);
              //alert(select+"    "+selected + " " + selectlist.length);
               for(x = 0; x < selectlist.length; x++) {
                   /*try {
                       alert(parseInt(document.getElementById(selectlist[x] + temp).options.selectedIndex) + " " + x);
                   } catch(err) {
                       alert(err.toString());
                   }*/
                   //   alert(parseInt(document.getElementById(selectlist[x]+temp).options.selectedIndex === selected +"   "+x);
                    if(selectlist[x] === select) {
                        continue;
                    } else if(parseInt(document.getElementById(selectlist[x]+temp).options.selectedIndex) === selected) {
                        document.getElementById(select+temp).options.selectedIndex=(0);
                        break;
                    } else {}
                }
            }
            
            function dothis(temp) {
                var x=parseInt(document.getElementById("select1"+temp).options.selectedIndex);
                var y=parseInt(document.getElementById("select2"+temp).options.selectedIndex);
                var z=parseInt(document.getElementById("select3"+temp).options.selectedIndex);
                var m=x+y+z;
                //alert("selection is wrong"+m);
             
                if(y === x)
                    document.getElementById("select2"+temp).options.selectedIndex=(0);
            
                if(z === x || z === y)
                    document.getElementById("select3"+temp).options.selectedIndex=(0);
            }
            function display(select, s, c, temp) {
                 //alert("hiiiiiiii");
                var x = document.getElementById(select + temp).selectedIndex;
                if(document.getElementById(select+temp).options[x].selected)
                    document.getElementById(s+temp).options.selectedIndex=(x);
                var e=document.getElementById(s+temp);
                var str=e.options[e.selectedIndex].text;
                if(str==="E" ||str==="O") {
                    // document.getElementById("check1"+temp).style.background ='#dedede';
                    document.getElementById(c+temp).disabled=true;
                }
                else
                    document.getElementById(c+temp).disabled=false;
                           
                chechthis(select, temp);
            }
            function display1(temp) {
                var x=document.getElementById("select1"+temp).selectedIndex;
                if(document.getElementById("select1"+temp).options[x].selected)
                    document.getElementById("s1"+temp).options.selectedIndex=(x);
                var e=document.getElementById("s1"+temp);
                var str=e.options[e.selectedIndex].text;
                if(str==="E" ||str==="O") {
                    // document.getElementById("check1"+temp).style.background ='#dedede';
                    document.getElementById("check1"+temp).disabled=true;
                }
                else
                    document.getElementById("check1"+temp).disabled=false;
                           
                dothis(temp);
            }
            function display2(temp) {
                var x=document.getElementById("select2"+temp).selectedIndex;
                if(document.getElementById("select2"+temp).options[x].selected)
                    document.getElementById("s2"+temp).options.selectedIndex=(x);
                var e=document.getElementById("s2"+temp);
                var str=e.options[e.selectedIndex].text;
                //alert("The course type is:"+str);
                if(str==="E" || str==="O") {
                    document.getElementById("check2"+temp).disabled=true;
                }
                else
                    document.getElementById("check2"+temp).disabled=false;
                dothis(temp); 
            }
            function display3(temp) {
                var x=document.getElementById("select3"+temp).selectedIndex;
                if(document.getElementById("select3"+temp).options[x].selected)
                    document.getElementById("s3"+temp).options.selectedIndex=(x);
                var e=document.getElementById("s3"+temp);
                var str=e.options[e.selectedIndex].text;
                //alert("The course type is:"+str);
                if(str==="E" || str==="O") {
                    document.getElementById("check3"+temp).disabled=true;
                }
                else
                    document.getElementById("check3"+temp).disabled=false;
                           
                dothis(temp);
            }
        </script>
    </head>
    <body bgcolor="#CCFFFF" >
<%
        Connection con = conn.getConnectionObj();

        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");

        Statement st1 = (Statement) con.createStatement();
        Statement st2 = (Statement) con.createStatement();
        Statement st3 = (Statement) con.createStatement();
        Statement st4 = (Statement) con.createStatement();
        Statement st5 = (Statement) con.createStatement();
        Statement st15 = (Statement) con.createStatement();
        ResultSet rs = (ResultSet) st1.executeQuery("select * from faculty_data order by Faculty_Name");
        ResultSet rs1 = (ResultSet) st2.executeQuery("select * from subjecttable order by Subject_Name");
%>
        <table width="100%">
            <tr>
                <th colspan="5" class="style30" align="center"><font size="6">New Allocation : <%=given_session%>-<%=given_year%></font></th>
            </tr>
        </table>
        <form action="subjectFaculty_new.jsp" method="post">
            <h4 align="center">Please click on the check box if the subject is also offered as an elective.</h4>
            <div id="div">    
                <table align="center" border="1">
                    <tr>
                        <th class="heading" align="center">S.no</th>
                        <th class="heading" align="center">Faculty Name</th>
                        <th class="heading" align="center">Subject 1</th>
                        <th class="heading" align="center">Subject 2</th>
                        <th class="heading" align="center">Subject 3</th>
                        <th class="heading" align="center">Subject 4</th>
                        <th class="heading" align="center">Subject 5</th>
                        <th class="heading" align="center">Subject 6</th>
                    </tr>
<%
                    int i = 1;
                    // get the each faculty, provide all subjects in drop list for each faculty. given some checkbox to indicate it as elective or core.
                    
                /*    //$$$$$$$$$$$$$$ elective table creation $$$$$$$$$$$$$$$$$$$$
                    DatabaseMetaData md = con.getMetaData();
                    ResultSet rs_2 = (ResultSet)md.getTables(null, null,""+given_year+"_"+given_session+"_elective", null);

                    // ResultSet rs_ele_d2 = md.getTables(null, null, " + given_year + "_" + given_session + "_elective, null);
                    if (!(rs_2.next())) {
                        // table not found
                        Statement st20_ele_dyn = (Statement) con.createStatement();
                        Statement st20_ele_dyn2 = (Statement) con.createStatement();
                        st20_ele_dyn.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective(course_name varchar(50),primary key(course_name))");
                        ResultSet rs_ele_dyn = (ResultSet) st20_ele_dyn2.executeQuery("select * from " + given_session + "_stream where electives='yes'");

                        while (rs_ele_dyn.next()) {
                            st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD " + rs_ele_dyn.getString(1).replace('-','_') + " INT(11)");
                        }
                        //rs_ele_dyn.last();
                        st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_1 varchar(45)");
                        st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_grade1 varchar(2) ");
                        st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_2 varchar(45)");
                        st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_grade2 varchar(2)");
                        
                        try {
                            rs_ele_dyn.close();
                        } catch(Exception e) {
                            System.out.println(e);
                        }
                        st20_ele_dyn2.close();
                        st20_ele_dyn.close();
                    }  */
                                
                    //  $$$ elective table over here
                    while (rs.next()) {
%>
                        <tr>
                            <td class="style30"><b><%=i%></b></td>
                            <td><b><input type="text" name="faculty" value="<%=rs.getString(2)%>" readonly="readonly"></b></td>
                            <td>
                                <select name="select1<%=Integer.toString(i)%>" id="select1<%=Integer.toString(i)%>" onchange="display('select1', 's1', 'check1', <%=Integer.toString(i)%>);" style="width:200px;">
                                    <option value="none">none</option>
<%
                                        while (rs1.next()) {
%> 
                                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
                                        }
%>
                                </select>
<%
                                rs1.beforeFirst();
%>
                                <select name="s1<%=Integer.toString(i)%>" id="s1<%=Integer.toString(i)%>"   style="width:100px;display:none;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%>
                                        <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option>
<%
                                    }
%>
                                </select>
                                <input type="checkbox" name="check1<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC">
                            </td>
<%
                            rs1.beforeFirst();
%>
                            <td>
                                <select name="select2<%=Integer.toString(i)%>" id="select2<%=Integer.toString(i)%>" onchange="display('select2', 's2', 'check2', <%=Integer.toString(i)%>);" style="width:200px;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%> 
                                        <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
                                    }
%>
                                </select>
<%
                                rs1.beforeFirst();
%>
                                <select name="s2<%=Integer.toString(i)%>" id="s2<%=Integer.toString(i)%>"  style="width:100px;display:none;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%> 
                                        <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option>
<%
                                    }
%>
                                </select>
                                <input type="checkbox" name="check2<%=Integer.toString(i)%>" id="check2<%=Integer.toString(i)%>" value="EC">
                            </td>   
<%
                            rs1.beforeFirst();
%>
                            <td>
                                <select name="select3<%=Integer.toString(i)%>" id="select3<%=Integer.toString(i)%>" onchange="display('select3', 's3', 'check3', <%=Integer.toString(i)%>);" style="width:200px;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%> 
                                        <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
                                    }
%>
                                </select>
<%
                                rs1.beforeFirst();
%>
                                <select name="s3<%=Integer.toString(i)%>" id="s3<%=Integer.toString(i)%>" style="width:100px;display:none;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%>
                                            <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option>
<%
                                    }
%>
                                </select>
                                <input type="checkbox" name="check3<%=Integer.toString(i)%>" id="check3<%=Integer.toString(i)%>" value="EC" class="style30">
                            </td>
                            
                           <% rs1.beforeFirst();%>
                           
                            <td>
                                <select name="select4<%=Integer.toString(i)%>" id="select4<%=Integer.toString(i)%>" onchange="display('select4', 's4', 'check4', <%=Integer.toString(i)%>);" style="width:200px;">
                                    <option value="none">none</option>
<%
                                        while (rs1.next()) {
%> 
                                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
                                        }
%>
                                </select>
<%
                                rs1.beforeFirst();
%>
                                <select name="s4<%=Integer.toString(i)%>" id="s4<%=Integer.toString(i)%>"   style="width:100px;display:none;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%>
                                        <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option>
<%
                                    }
%>
                                </select>
                                <input type="checkbox" name="check4<%=Integer.toString(i)%>" id="check4<%=Integer.toString(i)%>" value="EC">
                            </td>
                            
                            
                            <% rs1.beforeFirst();%>
                           
                            <td>
                                <select name="select5<%=Integer.toString(i)%>" id="select5<%=Integer.toString(i)%>" onchange="display('select5', 's5', 'check5', <%=Integer.toString(i)%>);" style="width:200px;">
                                    <option value="none">none</option>
<%
                                        while (rs1.next()) {
%> 
                                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
                                        }
%>
                                </select>
<%
                                rs1.beforeFirst();
%>
                                <select name="s5<%=Integer.toString(i)%>" id="s5<%=Integer.toString(i)%>"   style="width:100px;display:none;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%>
                                        <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option>
<%
                                    }
%>
                                </select>
                                <input type="checkbox" name="check5<%=Integer.toString(i)%>" id="check5<%=Integer.toString(i)%>" value="EC">
                            </td>
                            
                            <% rs1.beforeFirst();%>
                           
                            <td>
                                <select name="select6<%=Integer.toString(i)%>" id="select6<%=Integer.toString(i)%>" onchange="display('select6', 's6', 'check6', <%=Integer.toString(i)%>);" style="width:200px;">
                                    <option value="none">none</option>
<%
                                        while (rs1.next()) {
%> 
                                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
                                        }
%>
                                </select>
<%
                                rs1.beforeFirst();
%>
                                <select name="s6<%=Integer.toString(i)%>" id="s6<%=Integer.toString(i)%>"   style="width:100px;display:none;">
                                    <option value="none">none</option>
<%
                                    while (rs1.next()) {
%>
                                        <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option>
<%
                                    }
%>
                                </select>
                                <input type="checkbox" name="check6<%=Integer.toString(i)%>" id="check6<%=Integer.toString(i)%>" value="EC">
                            </td>
                            
                            
                        </tr>
<%
                        rs1.beforeFirst();
%>
<%
                        i++;
                    }
//                    rs_2.close();
%>
                </table>
            </div>
            <table>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <table width="100%" class="pos_fixed">
                <tr>
                    <td align="center" class="border"><input type="submit" name="submit" value="SUBMIT" ></td>
                </tr>
            </table>
            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>">
        </form>
<%
        rs.close();
        rs1.close();
        st1.close();
        st2.close();
        st3.close();
        st4.close();
        st5.close();
        st15.close();
        conn.closeConnection();
        con = null;
%>        
    </body>
</html>