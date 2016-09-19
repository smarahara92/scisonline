 <%-- 
    Document   : AttendanceDisplay
    Created on : Mar 1, 2015, 4:52:10 PM
    Author     : richa
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>

<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function fun1() {
                document.getElementById("mySelect1").focus();
            }


            function display1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;
                var subname = document.getElementsByTagName("option")[x].value;
              


                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Select Subject";
                } else {
                    document.getElementById("errfn").innerHTML = "";
                    parent.staffaction.location = "./Display.jsp?subjectname=" + subname;
                }

            }
 </script>
    </head>
    <body onload="fun1();">
        <%
           
            Connection con = conn.getConnectionObj();
            try{
                Statement st1 = con.createStatement();
                ResultSet rs1 = null;

                rs1 = st1.executeQuery("select * from programme_table where not Programme_group='PhD' and Programme_status='1'");

           
           
        %>  
         <form name="form1"< id="form1" action="Streamwise2.jsp" target="staffaction" method="POST">
           
            <table>
                <tr>
                    <td>
                        <select align="left" valign="bottom" name="pname" id="mySelect1" onchange="display1()"> 
                            <option>Select Programme</option>
                            <%while (rs1.next()) {%>

                            <option><%=rs1.getString(1)%></option>

                            <%}
                            }catch(Exception e){
     }finally{
         conn.closeConnection();
         con = null;
     }
                            %>
                        </select>
                    </td>
                </tr>
                
            </table>
            <table align="center">
                <tr>
                    <td><div class="style30" id="errfn"></div></td>
                </tr>
            </table>
            </br>
            </br>&nbsp;
            <table>
                <tr>
                    <td>
                        <div class="style30" id="errfn1" align="center"></div>
                    </td>
                </tr>
            </table>


        </form>
     
    </body>
</html>
