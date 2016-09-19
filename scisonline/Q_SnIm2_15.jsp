<%-- 
    Document   : Q_FINAL_READMIN2
    Created on : Mar 3, 2015, 2:41:16 PM
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
                if (document.getElementById('mySelect2').value === "Select Semester") {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById('errfn').innerHTML = "*Please select Sem";
                    document.getElementById("mySelect2").focus();
                } else {
                 //   alert("helllooo");
                   // document.getElementById('errfn').innerHTML = "";
                   // document.form1.submit();
      //             var x= document.getElementById('mySelect2').value;
                     
                    var y=document.getElementById('mySelect1').selectedIndex;
                    var name = document.getElementsByTagName("option")[y].value;
                    //var name = y.options[y.selectedIndex].text;
                    //alert(name);
                    var year = document.getElementById('mySelect2').value;
                  //  alert(year);
                    parent.act_area.location = "./BalankPage2.jsp";
                    
                    parent.bottom.location = "./Q_SnIm3_15.jsp?pyear="+ year +"&pname="+name;
                                        //document.form1.submit();

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
        <form name="form1" id="form1" action="Q_SnIm3_15.jsp" target="staffaction" method="POST">
            <input type="hidden" name="year" value="<%=year%>"/>
            <table>
                <tr>
                    <td>
                        <select align="left" valign="bottom" name="pname" id="mySelect1" > 
                            <option>Select Semester</option>
                             <option>Winter</option>
                             <option>Monsoon</option>
                            
                           <% }catch(Exception e){
                               e.printStackTrace();
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
                            <option>Select year</option>
                            <option >2014</option>
                            <option >2013</option>
                            <option > 2012</option>
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
