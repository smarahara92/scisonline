<%-- 
    Document   : studentinfo
    Created on : 18 May, 2014, 5:06:49 PM
    Author     : srinu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser.jsp"%> 
<%@include file="status_array.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}

            #div1
            {

                width:100%;
            }
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            td,table
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
            }
            .td1{
                text-align: center;
                color: blue;
            }
            .table1{


                border: 1px solid black;
                border-collapse: collapse;


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

        </style>
        <script>
            function validateEmail(prow) { 
                //var prow="mail"+row;
           //     alert(prow);
                var email=document.getElementById(prow).value.trim();
                //alert(email+"hhh");
                var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (!filter.test(email)) {
                    document.getElementById(prow).style.color='red';
                    document.getElementById(prow).focus();
                    document.getElementById("xx").disabled = true;
                    alert('Please provide a valid email address');
                    return false;
                }
                else
                {
                    document.getElementById(prow).style.color='black';
                    document.getElementById("xx").disabled =false; 
                }
            }
        
        
            function validateCell(prow)  
            {   
          //      alert(prow);
                //var prow="cell"+row;
                var cellno=document.getElementById(prow).value.trim();
                var filter = /^\d{10}$/;  
                if (!filter.test(cellno)) {
                   
                    document.getElementById(prow).style.color='red';
                    document.getElementById(prow).focus();
                    document.getElementById("xx").disabled = true;
                    alert('Please provide a valid Phone number.\n Note : Must contains 10 digits ');
                    return false;
                }
                else
                {
                    document.getElementById(prow).style.color='black';  
                    document.getElementById("xx").disabled =false; 
                }
            }
              

        </script>
    </head>
    <body>
        <%
            /**
             * ****************************************************************************
             * Get year , and retrive that batch information from the
             * PhD_Student_info_year
             *
             ******************************************************************************
             */
            String selected_year = request.getParameter("year");
            
            Statement st1 = (Statement) con2.createStatement();
            Statement st2 = (Statement) con2.createStatement();
            Statement st3 = (Statement) con2.createStatement();
            Statement st4 = (Statement) con2.createStatement();
            
            try {
                
                ResultSet rs1 = st1.executeQuery("select * from PhD_Student_info_" + selected_year);
                
                
        %>

        <form id="form1" name="form1" action="studentinfo2.jsp" target="addstd" method="POST">     
            <br>

            <div id="div1">
                <table class="table1" align="center" border="1">

                    <th class="heading"  style="width:10%">StudentId</th>
                    <th class="heading" style="width:18%">Name</th>
                    <th class="heading" style="width:19%">Current Address</th>
                    <th class="heading" style="width:19%">Permanent Address</th>
                    <th class="heading"  style="width:13%">Email</th>
                    <th class="heading"  style="width:10%">Cell</th>
                    <th class="heading"  style="width:10%">Landline</th>
                    <th  class="heading" >Gender</th>

                    <%                        
                        int j = 0;
                        while (rs1.next()) {
                            j++;
                    %>
                    <tr>

                        <td><input name ="id" type="text" readonly="readonly" align="left"style="width: 100px;" value="<%=rs1.getString(1)%>">

                        </td>
                        <td><input name ="name"type="text" readonly="readonly" align="left" style="width: 250px;"value="<%=rs1.getString(2)%>">
                        </td>
                        <td>
                            <% if (rs1.getString(3) != null) {%>
                            <input name ="ca" type="text" style="width: 200px;" align="left" value="<%=rs1.getString(3)%>">
                            <%} else {
                                
                            %><input name ="ca" type="text" style="width: 200px;" align="left" value=" ">
                            <% }%>                 

                        </td>
                        <td>
                            <% if (rs1.getString(4) != null) {%>
                            <input name="pa" type="text" style="width: 200px;" align="left" value="<%=rs1.getString(4)%>">
                            <%} else {
                                
                            %>
                            <input name="pa" type="text" style="width: 200px;" align="left" value=" ">
                            <% }%>    
                        </td>
                        <td>
                            <% if (rs1.getString(5) != null) {%>
                            <input name="mail" id="mail<%=j%>" type="text" style="width: 120px;" align="left" value="<%=rs1.getString(5)%>" onchange=" return validateEmail(this.id);">
                            <%} else {
                                
                            %>
                            <input name="mail" id="mail<%=j%>" type="text" style="width: 120px;" align="left" value=" " onchange=" return validateEmail(this.id);">
                            <% }%>  
                        </td>
                        <td>
                            <% if (rs1.getString(6) != null) {%>
                            <input name="cell" id="cell<%=j%>" type="text" style="width: 100px;" align="left" value="<%=rs1.getString(6)%>" onchange="return validateCell(this.id);">
                            <%} else {
                                
                            %>
                            <input name="cell" id="cell<%=j%>" type="text" style="width: 100px;" align="left" value=" " onchange="return validateCell(this.id);">
                            <% }%>  
                        </td>
                        <td>
                            <% if (rs1.getString(7) != null) {%>
                            <input name="landline" id="land<%=j%>" type="text" style="width: 100px;" align="left" value="<%=rs1.getString(7)%>" >
                            <%} else {
                                
                            %>
                            <input name="landline" id="land<%=j%>" type="text" style="width: 100px;" align="left" value=" " >
                            <% }%>  
                        </td>
                        <td>
                            <select name="gender" >
                                <% if (rs1.getString(8) != null) {
                                        if (rs1.getString(8).equalsIgnoreCase("Male")) {
                                %> 
                                <option value="Male" selected="selected">
                                    Male
                                </option>
                                <option value="Female">
                                    Female
                                </option>
                                <%} else if (rs1.getString(8).equalsIgnoreCase("Female")) {
                                    
                                %>  
                                <option value="Female" selected="selected">
                                    Female
                                </option>
                                <option value="Male">
                                    Male
                                </option>

                                <%} else  {
                                    
                                %>  
                                <option value=" ">Select</option>
                                <option value="Female">
                                    Female
                                </option>
                                <option value="Male"">
                                    Male
                                </option>

                                <%                                }
                                } else {
                                %>  
                                <option value=" ">Select</option>
                                <option value="Female">
                                    Female
                                </option>
                                <option value="Male"">
                                    Male
                                </option>
                                <%}
                                %> 
                            </select>        </td>

                    </tr>

                    <%}
                    %>                    

                    
                </table>
            </div> 
           <table width="100%">
                <tr>

                    <td align="center"  class="border"><input type="submit" id="xx" name="submit" value="SUBMIT" ></td>

                </tr>
            </table>
          
            <input type="hidden" name="selected_year" value="<%=selected_year%>">
        </form>
        <% //if
            }// try
            catch (Exception ex) {
                //out.println(ex);
                out.println("<center>Student details are not found</center> ");
            }
            st1.close();
            st2.close();
            st3.close();
            st4.close();
            
            con2.close();
        %> 
    </body>
</html>
