<%-- 
    Document   : slink3
    Created on : Dec 16, 2013, 11:26:14 AM
    Author     : veeru
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
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

            //ajax code for retrieving programme duration dynamicallyy
            function loadXMLDoc()
            {
                document.getElementById('errfn1').innerHTML = "";
                if (document.getElementById('mySelect1').value === "Select Programme") {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById('errfn1').innerHTML = "*Select Programme";
                    document.getElementById("mySelect1").focus();
                }
                else if (document.getElementById('mySelect2').value === "Select Year") {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById('errfn1').innerHTML = "*Select Year";
                    document.getElementById("mySelect2").focus();
                }
                var xmlhttp;
                var k = document.getElementById("mySelect1").value;


                var urls = "aslink1_ajax.jsp?pname=" + k;

                if (window.XMLHttpRequest)
                {
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function()
                {
                    if (xmlhttp.readyState === 4)
                    {
                        var Pduration = xmlhttp.responseText;

                        var i = 2, j = 1;

                        var select2 = document.getElementById("mySelect2");

                        for (var k = 1; k < select2.options.length + 2; k++)
                        {
                            var k1 = 1;
                            select2.options[k1] = null;


                        }
                        select2.options[k] = null;
                        d = new Date();
                        curr_year = d.getFullYear();
                        curr_month = d.getUTCMonth();
                        curr_month += 1;

                        if (curr_month === 7 || curr_month === 8 || curr_month === 9 || curr_month === 10 || curr_month === 11 || curr_month === 12) {

                            curr_year = curr_year;

                        } else {

                            curr_year = curr_year - 1;
                        }


                        while (Pduration > 0)
                        {
                            document.getElementById('mySelect2').options[j] = new Option((curr_year), (curr_year));
                            curr_year--;
                            Pduration--;
                            j++;

                        }
                        action2();

                    }
                }
                ;
                xmlhttp.open("GET", urls, true);
                xmlhttp.send();
            }

            function action1()
            {
                if (document.getElementById('mySelect2').value === "Select Year") {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById('errfn1').innerHTML = "*Please select year";
                    document.getElementById("mySelect2").focus();
                } else {
                    document.getElementById('errfn1').innerHTML = "";
                    document.form1.submit();
                }

            }
            function fun1() {
                document.getElementById("mySelect1").focus();
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
            Connection con = conn.getConnectionObj();
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
        <form name="form1" id="form1" action="Q_allF3_15.jsp" target="staffaction" method="POST">
            <input type="hidden" name="year" value="<%=year%>"/>
            <table>
                <tr>
                    <td>
                        <select align="left" valign="bottom" name="pname" id="mySelect1" onchange="loadXMLDoc();"> 
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
                <tr>
                    <td>
                        <select align="left" valign="bottom" name="pyear" id="mySelect2" onchange="action1();"> 
                            <option>Select Year</option>
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
