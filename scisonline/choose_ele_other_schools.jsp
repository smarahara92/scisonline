<%-- 
    Document   : choose_ele_other_schools
--%>

<%@page import = "java.sql.Statement"%>
<%@page import = "java.sql.ResultSet"%>
<%@page import = "java.sql.Connection"%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="connectionBean.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos
            {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos
            {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos
            {
                top:300px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {   
                background-color: #c2000d;
                color: white;
            }
        </style>
        <script>
            function check()
            {
                var i=1;
                var c=10;
                while(i<=10)
                {
                    if(document.getElementById("s"+i).value==""||document.getElementById("s"+i).value=="--Enter Student Id--")
                        c--;
                    i++;
                }
                if(c==0)
                {
                    alert("Atleast one Student Id is not given");
                        
                    return false;
                }
                else return true;
                
            }
            function make_blank(sid)
            {
                var stu = "s"+sid;
           
                if(document.getElementById(stu).value != "--Enter Student Id--") 
                {
                    
                } 
                else 
                { 
                    document.getElementById(stu).value =""; 
                }
                var i=0;
                for(i=1; i<=10; i++)
                {
                    var stu1 = "s"+i;
                    if(i == sid)
                        ;
                    else 
                    {
                        if(document.getElementById(stu1).value =="")
                        {
                            document.getElementById(stu1).value ="--Enter Student Id--";
                        }
                    }
                }
           
            
            }
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <%
            Connection con = conn.getConnectionObj();
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            Statement st1 = (Statement) con.createStatement();

        %>

        <table width="100%" align="center">
            <tr>
                <td align="center"><h2><u><font color="#c2000d">Elective Registration For Other Schools</font></u></h2></td>
            </tr>
        </table>

        <form action="choose_ele_other_schools_stored.jsp" name="ele_form" id="ele_form" onsubmit="return finaltest();">
            <table width="100%" align="center">
                <tr>
                    <td>&nbsp;</td>
                </tr>

            </table>
            <table align="center" border="1">

                <tr class="fix">

                    <td class="style31" align="center"><b>Student ID</b></td>
                    <td class="style31" align="center"><b>Name</b></td>
                    <td class="style31" align="center"><b>Course 1</b></td>
                    <td class="style31" align="center"><b>Course 2</b></td>
                    <td class="style31" align="center"><b>Course 3</b></td>
                    <td class="style31" align="center"><b>Course 4</b></td>
                    <td class="style31" align="center"><b>Grade Formula</b></td>

                </tr>
                <%
                    Statement st1_con = con.createStatement();
                    Statement st2_con = con.createStatement();
                    Statement st3_con = con.createStatement();
                    String qry10 = "create table if not exists Other_schools(Name varchar(20),primary key(Name))";
                    st1_con.executeUpdate(qry10);
                    for (int j = 1; j <= 10; j++) {

                        ResultSet rs1_con = null;
                        ResultSet rs2_con = null;
                        rs1_con = st2_con.executeQuery("select Distinct(Programme_group) from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                        rs2_con = st3_con.executeQuery("select * from Other_schools");

                %>
                <tr>

                    <td><input type="text" id="s<%=j%>" name="sid<%=j%>" value="--Enter Student Id--"  onclick="make_blank(<%=j%>);" onchange="validId(<%=j%>);" style="width:150px;">
                    </td>
                    <td><input type="text" id="sn<%=j%>" name="sname<%=j%>" style="width:150px;"></td>


                    <%

                        ResultSet rs2 = (ResultSet) st1.executeQuery("select * from subjecttable order by Subject_Name");

                        for (int i = 1; i <= 4; i++) {
                    %>
                    <td>
                        <select name="select<%=Integer.toString(j)%><%=Integer.toString(i)%>" id="select<%=Integer.toString(j)%><%=Integer.toString(i)%>" onchange="dothis(<%=Integer.toString(j)%>,<%=Integer.toString(i)%>);" style="width:150px;" >
                            <option value="none">none</option>
                            <%
                                while (rs2.next()) {
                            %>

                            <option value="<%=rs2.getString(1)%>" >   <%=rs2.getString(2)%></option>


                            <% }
                                rs2.beforeFirst();
                            %>
                    </td>    
                    <%
                        }
                    %>

                    <td>
                        <select name="select<%=Integer.toString(j)%>" id="select<%=Integer.toString(j)%>" style="width:150px;">

                            <option value="none" >--choose--</option>
                           
                            <%while (rs1_con.next()) {

                            %>

                            <option ><%=rs1_con.getString(1)%></option>

                            <%
                                }


                                while (rs2_con.next()) {
                            %>

                            <option ><%=rs2_con.getString(1)%></option>

                            <%

                                }



                            %>
                        </select>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>


            <table width="100%" class="pos_fixed">
                <tr>

                    <td align="center" class="border"><input type="submit" name="submit" value="SUBMIT"  ></td>

                </tr>
            </table>

            &nbsp;
            &nbsp;
            &nbsp;
            &nbsp;

            &nbsp;
            &nbsp;
            &nbsp;
            &nbsp;

            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>"> 
        </form>
        <script>
            function finaltest()
            {
                //alert("srinu");
                for(var k=1;k<10;k++){
                    var student_id=document.getElementById("s"+k).value ;
                    //alert("s"+k);
                    if(student_id!=="--Enter Student Id--" && student_id!=="") {
                        {   
                            var grade_f=document.getElementById("select"+k).value ; 
                            //alert("select"+k);
                            if(grade_f=="none"){
                                alert("Choose grade");
                                document.getElementById("select"+k).focus(); 
                                document.getElementById("select"+k).style.color="red";
                                
                                return false;
                            }
                        }
                    }
                        
                }
                return true;
            }
            
            
            function dothis(row,col){
                var stu = "s"+row;
                var select="select"+row+col;
                var student_id=document.getElementById(stu).value ;
                //alert("a"+student_id+"D");
                if(student_id== "--Enter Student Id--" ||student_id=="" ||student_id==null) 
                {
                    alert("Enter student id");
                    document.getElementById(select).value="none";
                    return true;
                } 
                 
                //alert(row+" ad"+col);
                var sub_code=document.getElementById(select).value;
                for(var i=1;i<=4;i++){
                 
                    if(col==i) continue;
                    var select2="select"+row+i;
                    var get_sub_code=document.getElementById(select2).value;
                    if(sub_code==get_sub_code){
                        document.getElementById(select).value="none";
                    }
                
                }
                    
            }
        </script>
<%
    conn.closeConnection();
    con = null;
%>
    </body>
</html>
