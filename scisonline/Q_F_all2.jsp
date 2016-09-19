<%-- 
    Document   : Q_F_all2
    Created on : Mar 2, 2015, 8:57:14 PM
    Author     : richa
--%>

<%@page import="java.util.Calendar"%>
<%@page import ="java.sql.*" %>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold{
                font-weight: bold;
            }
        </style>
        <script>
           
            function fun1() {

                document.getElementById("mySelect1").focus();
            }
            //ajax code for retrieving programme duration dynamicallyy
            
            function action1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;
                var subname = document.getElementsByTagName("option")[x].value;
              


                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Select Subject";
                } else {
                    document.getElementById("errfn").innerHTML = "";
                    parent.staffaction.location = "./Q_Patfinal_15.jsp?pname=" + subname;
                }


            }

        </script>

    </head>
    <body onload="fun1();">
        <%
            Calendar now = Calendar.getInstance();
            
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);

            System.out.println("Current Month:" + month);
            System.out.println("Current Year:" + year);
             Connection  con = conn.getConnectionObj();
           try{
               Statement st1 = con.createStatement();
           
            ResultSet rs1 = null;

            rs1 = st1.executeQuery("select * from programme_table where not Programme_group='PhD' and Programme_status='1'");

            if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
                year = now.get(Calendar.YEAR);
            } else {
                year = now.get(Calendar.YEAR) - 1;
            }
        %>  
        <form name="form1" id="form1" action="Q_Patfinal_15.jsp" target="staffaction" method="POST">
            <input type="hidden" name="year" value="<%=year%>"/>
            <table>
                <tr>
                    <td>
                        <select align="left" valign="bottom" name="pname" id="mySelect1" onchange="action1();"> 
                            <option>Select Month</option>
                            <%if(month <= 6){%>

                            <option value="1">January</option>
                            <option value="2">February</option>
                            <option value="3">March</option>
                            <option value="4">April</option>

                            <%}
                            else {%>
                                <option>July</option>
                            <option>August</option>
                            <option>September</option>
                            <option>October</option>
                            <%}
                            }catch(Exception e){
                               e.printStackTrace();
                            }finally{
                                    conn.closeConnection();
                                    con = null;                                                                                                   
                               }
                            %>
                        </select>
                    </td>
                </tr>
                
            </table>

                        &nbsp;</br></br>
            <table align="center">
                <tr>
                    <td><div class="style30" id="errfn"></div></td>
                </tr>
            </table>&nbsp;
            <table align="center">
                <tr>
                    <td><div class="style30" id="errfn1"></div></td>
                </tr>
            </table>&nbsp;

        </form>

    </body>
</html>
