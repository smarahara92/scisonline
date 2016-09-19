<%-- 
    Document   : GradeFormula
    Created on : 12 Apr, 2012, 11:07:45 AM
    Author     : khushali
--%>
<%@page import = "javax.sql.*" %>
<%@page import =  "java.sql.*" %>
<%@ include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">

        <title>JSP Page</title>
        <script>
            function ValidateValues(temp)
            {
                var Marks = document.getElementById(temp).value;
                Marks = Marks.replace(/^\s+|\s+$/g, '');
                if (Marks.length === 0)
                {
                    document.getElementById(temp).value = 0;
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById("xx").disabled = false;
                    return;
                }

                for (i = 0; i < Marks.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (Marks.charCodeAt(i) < 48 || Marks.charCodeAt(i) > 57)
                    {

                        if (Marks.charCodeAt(i) !== 46)
                        {

                            alert("invalid input");

                            document.getElementById(temp).style.color = 'red';
                            document.getElementById(temp).focus();
                            document.getElementById("xx").disabled = true;

                            return;
                        }
                    }
                }
                document.getElementById(temp).value = Marks;

                if (Marks > 100 || Marks < 0)
                {
                    alert("Please enter a value less than or equal to 100");
                    document.getElementById(temp).style.color = 'red';
                    document.getElementById(temp).focus();
                    document.getElementById("xx").disabled = true;
                }
                else
                {
                    document.getElementById(temp).style.color = 'black';

                    document.getElementById("xx").disabled = false;
                }
            }


            function validate()
            {
                var i = 0;
                for (i = 0; i <= 5; i++)
                {
                    var f = document.getElementById("0").value;
                    if (f === "0" || f === "")
                    {
                        alert("entre details correctly");
                        return false;
                    }

                }
                var f1 = document.getElementById("0").value;
                var f2 = document.getElementById("1").value;
                var f3 = document.getElementById("2").value;
                var f4 = document.getElementById("3").value;
                var f5 = document.getElementById("4").value;
                var f6 = document.getElementById("5").value;

                if (f1 > f2 && f2 > f3 && f3 > f4 && f4 > f5 && f5 > f6)
                {
                    return true;
                }
                else
                {
                    alert("enter details correctly");
                    return false;
                }

            }
        </script>
    </head>
    <body>
        <%
            String stream = request.getParameter("streamname");
            stream=stream.replace('-', '_');
            System.out.println("stream name is:" + stream);
            session.setAttribute("stream1", stream);
            Statement st1 = con1.createStatement();
            
            
            String qry10 = "create table if not exists " + stream + "_grade_table(Grade varchar(20),Marks Int(10),primary key(Grade))";
            st1.executeUpdate(qry10);
            String qry9 = "select * from " + stream + "_grade_table ";
            Statement st9 = con1.createStatement();
            //Statement st1=ConnectionDemo3.getStatementObj().createStatement();
            
            
            // insert the new program into other_schools table.
            
            
  
            
            ResultSet rs9 = st9.executeQuery(qry9);
            int count = 0;
            while (rs9.next()) {
                count++;
            }
            rs9.beforeFirst();
            int value = 0;
            int i = 0;
        %>
        <form action="GradeFormula1.jsp" name="frm"  onsubmit="return validate();"> 
            <center><b>University of Hyderabad</b></center>
            <center><b>School of Computer and Information Sciences</b></center>
            <center><font style=" color: blue"><%=stream%> : </font><b>Grade Formula Table</b></center>
            <input type="hidden" name="streamName1" value="<%=stream%>">
            <br>
            <table  border="2" cellspacing="5" cellpadding="5" align="center" style="color:blue;background-color:#CCFFFF;">
                <tr>
                    <th>Grade</<input type="hidden" name="grade" value="A+"></th>
                    <th>Marks</th> 
                </tr>
                <tr>
                    <td>A+</td>
                <input type="hidden" name="grade" value="A+">
                <%

                    if (count == 0) {%>
                <td><input type="text" id="<%=i%>" name="m1"  onchange="ValidateValues(<%=i%>);"></td>
                    <%
                    } else {

                        while (rs9.next()) {
                            if (rs9.getString(1).equals("A+")) {
                                value = rs9.getInt(2);
                            }
                        }
                    %><td><input type="text" id="<%=i%>" name="m1"  value="<%=value%>" onchange="ValidateValues(<%=i%>);"></td><%
                        }%>
                </tr>
                <%i++;%>
                <tr>
                    <td>A</td>
                <input type="hidden" name="grade" value="A">
                <%
                    rs9.next();
                    if (count == 0) {%>
                <td><input type="text" id="<%=i%>" name="m2"  onchange="ValidateValues(<%=i%>);"></td>
                    <%} else {
                        rs9.beforeFirst();
                        while (rs9.next()) {
                            if (rs9.getString(1).equals("A")) {
                                value = rs9.getInt(2);
                            }
                        }
                    %><td><input type="text" id="<%=i%>" name="m2"  value="<%=value%>" onchange="ValidateValues(<%=i%>);"></td><%
                        }%>
                </tr>
                <%i++;%>
                <tr>
                    <td>B+</td>
                <input type="hidden" name="grade" value="B+">
                <%
                    rs9.next();
                    if (count == 0) {%>
                <td><input type="text" id="<%=i%>" name="m3"  onchange="ValidateValues(<%=i%>);"></td>
                    <%} else {
                        rs9.beforeFirst();
                        while (rs9.next()) {
                            if (rs9.getString(1).equals("B+")) {
                                value = rs9.getInt(2);
                            }
                        }

                    %><td><input type="text" id="<%=i%>" name="m3"  value="<%=value%>" onchange="ValidateValues(<%=i%>);"></td><%
                        }%>
                </tr>
                <%i++;%>
                <tr>
                    <td>B</td>
                <input type="hidden" name="grade" value="B">
                <%
                    rs9.next();
                    if (count == 0) {%>
                <td><input type="text" id="<%=i%>" name="m4"  onchange="ValidateValues(<%=i%>);"></td>
                    <%} else {
                        rs9.beforeFirst();
                        while (rs9.next()) {
                            if (rs9.getString(1).equals("B")) {
                                value = rs9.getInt(2);
                            }
                        }

                    %><td><input type="text" id="<%=i%>" name="m4"  value="<%=value%>" onchange="ValidateValues(<%=i%>);"></td><%
                        }%>
                </tr>
                <%i++;%>
                <tr>
                    <td>C</td>
                <input type="hidden" name="grade" value="C">
                <%
                    rs9.next();
                    if (count == 0) {%>
                <td><input type="text" id="<%=i%>" name="m5"  onchange="ValidateValues(<%=i%>);"></td>
                    <%} else {
                        rs9.beforeFirst();
                        while (rs9.next()) {
                            if (rs9.getString(1).equals("C")) {
                                value = rs9.getInt(2);
                            }
                        }
                    %><td><input type="text" id="<%=i%>" name="m5"  value="<%=value%>" onchange="ValidateValues(<%=i%>);"></td><%
                        }%>
                </tr>
                <%i++;%>
                <tr>
                    <td>D</td>
                <input type="hidden" name="grade" value="D">
                <%
                    rs9.next();
                    if (count == 0) {%>
                <td><input type="text" id="<%=i%>" name="m6"  onchange="ValidateValues(<%=i%>);"></td>
                    <%} else {
                        rs9.beforeFirst();
                        while (rs9.next()) {
                            if (rs9.getString(1).equals("D")) {
                                value = rs9.getInt(2);
                            }
                        }
                    %><td><input type="text" id="<%=i%>" name="m6"  value="<%=value%>" onchange="ValidateValues(<%=i%>);"></td><%
                        }%>
                </tr>
                <%i++;%>

            </table>
            </br></br><center>
                <input type="submit" id="xx" value="submit"  name="submit" /></center>
        </form>
    </body>
</html>
