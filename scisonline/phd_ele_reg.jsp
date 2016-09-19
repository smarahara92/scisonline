<%-- 
    Document   : phd_ele_reg
    Created on : Jun 6, 2013, 12:27:05 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
        <script type="text/javascript">  
        
            var countarray=new Array(10000);
            var elearray=new Array(10000);
            for(var i=0;i<10000;i++)
            {
                countarray[i]=0;
                elearray[i]=0;
            }
            function find(a,b,c,d,e)
            {
                if(c==0)
                {
                    alert("maximum subjects compleated");
                    return false;
                }
                var id=b.substring(0,2)+b.substring(6,8);
                //alert(countarray[id]+c);
                if(a==true)
                {
                    if(countarray[id]>=c)
                    {
                        alert("you cannot select more than "+c+" subjects");
                        return false;
                    }
                
                    else
                    {
                        countarray[id]=countarray[id]+1;
                        if(e=="e")
                        {
                            elearray[id]=elearray[id]+1;
                            if(elearray[id]>d)
                            {
                                //alert(d);
                                elearray[id]=elearray[id]-1;
                                countarray[id]=countarray[id]-1;
                                alert("you cannot select more than "+d+" electives");
                                return false;
                            }
                        }
                    }
                }
                else
                {
                    if(e=="e")
                    {
                        elearray[id]=elearray[id]-1;
                    }
                    countarray[id]=countarray[id]-1;   
                }
            }
         
            function find1(a,b,c,d,e)
            {
                var id=b.substring(0,2)+b.substring(6,8);
                if(e=="e")
                {
                    elearray[id]=elearray[id]+1;
                    if(elearray[id]>d)
                    {
                        //alert(d);
                        elearray[id]=elearray[id]-1;
                        //countarray[id]=countarray[id]-1;
                        alert("you cannot select more than "+d+" electives");
                        return false;
                    }
                }
            }
        </script>
    </head>
    <body>
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
                <td align="center" class="style31"><font size="6">Comprehensive Registration</font></td>
            </tr>
        </table>
        </br>
        </br>
        <table>
            <tr><td>Note</td>
                <td>: Students without DRC Registration, wont be listed here.</td>
            </tr>
            <tr>
                <th align="center" bgcolor="yellow" width="2%"><input type="checkbox"   disabled="disabled"> </th>

                <td>: Assessment done for this subject, so we can not modify it.</td></tr>

        </table>   
        <br>
        <form name="frm" action="phd_ele_reg1.jsp"  method="POST" onsubmit="">
            <%
                Calendar now = Calendar.getInstance();
                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);
                int studentsfoundflag = 0;
                if (month >= 1 && month <= 6) {
                    cyear = cyear - 1;
                }
                //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
                // srinivas comments
                // curriculum version code has to be added, 
                // currefer table has to be used for getting the # of ele, cores.
                // note that here, we are givin ele reg for the current starting batch eg : 2013 june / july joined batch, we are giving reg in 2013 july / aug. 
                // if you want to do ele reg in jan, the decrease cyear by 1, since cyear will be 2014 for 2013 batch in the jan 2014.
                //*****************************************************
                try {
            %> 


            <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center"><%
                Statement st1 = con2.createStatement();
                Statement st_comp = con2.createStatement();
                Statement st2 = con2.createStatement();
                Statement st3 = con2.createStatement();
                Statement st_snam = con2.createStatement();

                ResultSet rs1 = st1.executeQuery("select * from PhD_" + cyear + " where status ='A' OR status ='C'");

                
                
                ResultSet rs2 = st2.executeQuery("select * from PhD_electives");
               
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
                rs3.next();
                int noofelectives = Integer.parseInt(rs3.getString(2));
                int noofcores = Integer.parseInt(rs3.getString(1));
                int totalsubjects = noofelectives + noofcores;
                System.out.println(totalsubjects);
                //*********************************************************************
                Statement st7 = con2.createStatement();
                ResultSet rs7 = (ResultSet) st7.executeQuery("select * from PhD_" + latestYear + "_curriculum");

                //***********************************************************************
                %>


                <th>Student Id</th>
                <th>Student Name</th>
                <%
                    // printing cores 
                    while (rs7.next()) {
                %><th><%=rs7.getString(1)%></th><%
                    }
                    //printing the elective shortcuts
                    while (rs2.next()) {
                %>
                <th><%=rs2.getString("shortcut")%></th>
                <%
                    }

                    // students id, name , electives in each row.
                    while (rs1.next()) {
                        ResultSet rs_sname = st_snam.executeQuery("select * from  PhD_Student_info_" + cyear + " where StudentId='" + rs1.getString(1) + "'");
                        rs_sname.next();
                        ResultSet rs_comp = st_comp.executeQuery("select * from comprehensive_" + cyear + " where StudentId='" + rs1.getString(1) + "'");
                        rs_comp.next();%><tr>
                    <td><%=rs1.getString(1)%></td>
                    <td><%=rs_sname.getString(2)%></td>
                    <%
                        rs2.beforeFirst();
                        rs7.beforeFirst();
                        int j = 0;
                        while (rs2.next()) {
                            int i = 1;
                            while (i <= noofelectives) {
                                if (rs_comp.getString("ele" + i) != null && rs_comp.getString("ele" + i).equals(rs2.getString(1)) && rs_comp.getString("e" + i + "grade").equals("R") != true) {
                                    j++;
                                }
                                i++;
                            }
                        }
                        while (rs7.next()) {
                            int i = 1;
                            while (i <= noofcores) {
                                if (rs_comp.getString("core" + i) != null && rs_comp.getString("core" + i).equals(rs7.getString(1)) && rs_comp.getString("c" + i + "grade").equals("R") != true) {
                                    j++;
                                }
                                i++;
                            }
                        }
                        //************************************************************************************
                        rs7.beforeFirst();
                        while (rs7.next()) {

                            int i = 1;
                            int k = 0;
                            while (i <= noofcores) {
                                if (rs_comp.getString("core" + i) != null && rs_comp.getString("core" + i).equals(rs7.getString(1)) && rs_comp.getString("c" + i + "grade").equals("R")) {
                    %><td align="center"><input type="checkbox" name="<%=rs1.getString(1)%>" value="c<%=rs7.getString(1)%>" checked="true" onclick="return find(this.checked,this.name,'<%=totalsubjects - j%>','<%=noofcores%>','c')"></td>
                <script type="text/javascript" language="JavaScript">
                    find(true,'<%=rs1.getString(1)%>','<%=totalsubjects - j%>','<%=noofcores%>','c');                                            
                </script>
                <%
                    k = 1;
                    break;
                } else if (rs_comp.getString("core" + i) != null && rs_comp.getString("core" + i).equals(rs7.getString(1)) && rs_comp.getString("c" + i + "grade").equals("R") != true) {
                %><td align="center" bgcolor="yellow"><input type="checkbox" name="<%=rs1.getString(1)%>" value="c<%=rs7.getString(1)%>" disabled="disabled"></td>

                <%
                            k = 1;
                            break;
                        }
                        i++;
                    }
                    if (j != 0 && k == 0) {
                %><td align="center"><input type="checkbox" name="<%=rs1.getString(1)%>" value="c<%=rs7.getString(1)%>" onclick="return find(this.checked,this.name,'<%=totalsubjects - j%>','<%=noofcores%>','c')"></td><%
                } else if (i > noofcores) {
                    %><td align="center"><input type="checkbox" name="<%=rs1.getString(1)%>" value="c<%=rs7.getString(1)%>" onclick="return find(this.checked,this.name,'<%=totalsubjects%>','<%=noofcores%>','c')"></td><%
                            }
                        }



                        //************************************************************************************
                        rs2.beforeFirst();
                        while (rs2.next()) {
                            //System.out.println("llll");                 
                            int i = 1;
                            int k = 0;
                            while (i <= noofelectives) {
                                if (rs_comp.getString("ele" + i) != null && rs_comp.getString("ele" + i).equals(rs2.getString(1)) && rs_comp.getString("e" + i + "grade").equals("R")) {
                    %><td align="center"><input type="checkbox" name="<%=rs1.getString(1)%>" value="e<%=rs2.getString(1)%>" checked="true" onclick="return find(this.checked,this.name,'<%=totalsubjects - j%>','<%=noofelectives%>','e')"></td>
                <script type="text/javascript" language="JavaScript">
                    find(true,'<%=rs1.getString(1)%>','<%=totalsubjects - j%>','<%=noofelectives%>','e');                                            
                </script>
                <%
                    k = 1;
                    break;
                } else if (rs_comp.getString("ele" + i) != null && rs_comp.getString("ele" + i).equals(rs2.getString(1)) && rs_comp.getString("e" + i + "grade").equals("R") != true) {
                %><td align="center" bgcolor="yellow"><input type="checkbox" name="e<%=rs1.getString(1)%>" value="<%=rs2.getString(1)%>" disabled="disabled"></td>
                <script type="text/javascript" language="JavaScript">
                    find1(true,'<%=rs1.getString(1)%>','<%=totalsubjects - j%>','<%=noofelectives%>','e');                                            
                </script>
                <%
                            k = 1;
                            break;
                        }
                        i++;
                    }
                    System.out.println(i);
                    if (j != 0 && k == 0) {
                %><td align="center"><input type="checkbox" name="<%=rs1.getString(1)%>" value="e<%=rs2.getString(1)%>" onclick="return find(this.checked,this.name,'<%=totalsubjects - j%>','<%=noofelectives%>','e')"></td><%
                } else if (i > noofelectives) {
                    %><td align="center"><input type="checkbox" name="<%=rs1.getString(1)%>" value="e<%=rs2.getString(1)%>" onclick="return find(this.checked,this.name,'<%=totalsubjects%>','<%=noofelectives%>','e')"></td><%
                            }
                        }
                    %>                              
                </tr>
                <%
                        studentsfoundflag = 1;
                    }

                %></table>

            </br>

            <center> <input type="submit" name="submit" value="submit"></center>
            </br>
            <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                <tr>    <th>Subject Name</th>
                    <th>Code</th></tr>
                    <%

                        rs2.beforeFirst();
                        rs7.beforeFirst();
                        while (rs7.next()) {
                    %><tr>
                    <td><%=rs7.getString(2)%></td>   
                    <td><%=rs7.getString(1)%></td>   
                </tr>
                <%
                    }
                    while (rs2.next()) {
                %><tr>
                    <td><%=rs2.getString(2)%></td>   
                    <td><%=rs2.getString(3)%></td>   
                </tr>
                <%
                        rs7.close();
                    }
                %></table><%
                        st1.close();
                        st2.close();
                        st_snam.close();
                        st3.close();
                        st_comp.close();
                        rs1.close();
                        rs2.close();
                        rs10_cur.close();
                        st10_cur.close();
                        rs3.close();
                        st7.close();
                    } catch (Exception e) {
                        System.out.println(e);
                        if (studentsfoundflag == 0) {
                            out.println("Note :" + cyear + " students list not available in the database.");
                        }
                    }

                %>

        </form>
        <%
                try{
                    con.close();
                    con2.close();
                }
                catch(Exception e){
                    System.out.println(e);
                }
                finally{
                    con.close();
                    con2.close();
                }
        %>

    </body>
</html>
