<%-- 
    Document   : table1
    Created on : 19 Jan, 2012, 7:56:50 PM
    Author     : khushali
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="table_css1.css" rel="stylesheet" type="text/css">
        <script  type="text/javascript">
           
           function disableEnterKey(e){
               var key ;
               if(window.event){
                   key= window.event.keycode;
               }
               else 
                   key = e.which;
               return(key != 13);
           }
            function textcheck()
            {
                var elems = document.getElementsByTagName('input');
                for (var i = 0; i < elems.length; i++)
                {
                    if (elems[i].value == "")
                    {
                        elems[i].focus();
                        alert("Missing value at " + (i + 1));
                        return false;
                    }
                }

                return true;

            }


            function ValidateValues(temp)
            {
                var Marks = document.getElementById(temp).value;

                Marks = Marks.replace(/^\s+|\s+$/g, '');

                if (Marks.length == 2)
                {
                    var cap = Marks.toUpperCase();
                    if (cap == "AB")
                    {
                        document.getElementById(temp).value = cap;
                        document.getElementById(temp).style.color = 'black';
                        document.getElementById("xx").disabled = false;
                        return;
                    }
                }

                if (Marks.length == 0)
                {
                    document.getElementById(temp).value = 0;
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById("xx").disabled = false;
                    return;
                }
                var i = 0, j = 0;
                for (i = 0; i < Marks.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (Marks.charCodeAt(i) < 48 || Marks.charCodeAt(i) > 57)
                    {

                        if (Marks.charCodeAt(i) != 46)
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
                if (Marks > 20 || Marks < 0)
                {
                    alert("Please enter a value less than or equal to 20");
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

            function ValidateValues1(temp)
            {
              
                var Marks = document.getElementById(temp).value;
               
                //Marks = Marks.replace(/^\s+|\s+$/g, '');
               
                if (Marks.length == 2)
                {
                    var cap = Marks.toUpperCase();
                    if (cap == "AB")
                    {
                        document.getElementById(temp).value = cap;
                        document.getElementById(temp).style.color = 'black';
                        document.getElementById("xx").disabled = false;
                        return;
                    }
                }
                if (Marks.length == 0)
                {


                    document.getElementById(temp).value = 0;
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById("xx").disabled = false;
                    return;
                }
                var i = 0, j = 0;
                for (i = 0; i < Marks.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (Marks.charCodeAt(i) < 48 || Marks.charCodeAt(i) > 57) //unicode for 0 to 9.
                    {
                        if (Marks.charCodeAt(i) != 46)
                        {

                            // alert(Marks[i]);
                            alert("invalid input");

                            document.getElementById(temp).style.color = 'red';
                            document.getElementById(temp).focus();
                            document.getElementById("xx").disabled = true;

                            return;
                        }
                    }
                }
                document.getElementById(temp).value = Marks;
                if (Marks > 60 || Marks < 0)
                {
                    alert("Please enter a value less than or equal to 60");
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
            
            
            function ValidateValues2(temp)
            {
                
                var Marks = document.getElementById(temp).value;

                Marks = Marks.replace(/^\s+|\s+$/g, '');
               
                
                if (Marks.length == 2)
                {
                    var cap = Marks.toUpperCase();
                    if (cap == "AB")
                    {
                        document.getElementById(temp).value = cap;
                        document.getElementById(temp).style.color = 'black';
                        document.getElementById("xx").disabled = false;
                        return;
                    }
                }
                if (Marks.length == 0)
                {


                    document.getElementById(temp).value = 0;
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById("xx").disabled = false;
                    return;
                }
                var i = 0, j = 0;
                for (i = 0; i < Marks.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (Marks.charCodeAt(i) < 48 || Marks.charCodeAt(i) > 57)
                    {
                        if (Marks.charCodeAt(i) != 46)
                        {

                            // alert(Marks[i]);
                            alert("invalid input");

                            document.getElementById(temp).style.color = 'red';
                            document.getElementById(temp).focus();
                            document.getElementById("xx").disabled = true;

                            return;
                        }
                    }
                }
                document.getElementById(temp).value = Marks;
                if (Marks > 60 || Marks < 0)
                {
                    alert("Please enter a value less than or equal to 60");
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
            function makeblank(temp, count)
            {
                var i = 0;
                document.getElementById(temp).value = "";
                while (i < count)
                {
                    var k = document.getElementById(i).value;

                    if (k == "" && i != temp)
                    {
                        //alert("lll");
                        document.getElementById(i).value = '0';
                        document.getElementById(i).style.color = 'black';
                        document.getElementById("xx").disabled = false;
                    }
                    i++;
                }
            }
        </script>
    </head>
    <body>

        <%   Connection con1 = conn1.getConnectionObj();         
                Connection con = conn.getConnectionObj();         
            PreparedStatement pst = null;
             String MARKS ="";
            try {
                Calendar now = Calendar.getInstance();
                
                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);
                Statement stmt_subType = con.createStatement();
                
                String sem = "";
                if (month >= 7) {
                    sem = "Monsoon";
                } else if (month >= 1 && month <= 6) {
                    sem = "Winter";
                }

                String subjectid = (String) session.getAttribute("subjid");
                String subType ="";
                ResultSet result =stmt_subType.executeQuery("select type from subjecttable where Code ='"+subjectid+"'");
                result.next();
                subType = result.getString(1);
                System.out.println("*********subject type = "+subType+"*****************");
                 MARKS = request.getParameter("selectmarks");
                System.out.println(MARKS);

        %>

        <%            String sname = request.getParameter("subjname");
            subjectid = request.getParameter("subjid");
            pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + year);

            ResultSet rs = pst.executeQuery();

        %>
        <form action="GetParameterMethod.jsp" name="frm" method="post"  onsubmit="return textcheck();"> 
            <input type="hidden" name="selectmarks"  value="<%=MARKS%>" size="10" readonly="readonly"/>
            <table align="center" border="0"> 
                <tr>                             
                    <th>Subject<br/><input type="text" name="subjname" id="subjname" style="width:300px" value="<%=sname%>" size="25" readonly="readonly" onKeyPress ="return disableEnterKey(event)"/>  

                    </th><th>Code<br/><input type="text" name="subjid" id="subjid" value="<%=subjectid%>" size="10" readonly="readonly" onKeyPress ="return disableEnterKey(event)"/>    

                    </th>
            </table>  
            &nbsp;&nbsp;
            <table  border="1" align="center" class="table">
                <%
                    int count = 0;
                    while (rs.next()) {
                        count++;
                    }

                    if (MARKS.equals("Minor_1")) {%>

                <tr>
                    <th class="th">Student ID</th>
                    <th class="th">Name</th>
                    <th class="th">Minor1</th>

                </tr>
                <tr></tr>


                <%int i = 0, j = 20;

                    rs.beforeFirst();
                    while (rs.next()) {%>
                <TR>
                    <TD class="td"><%=rs.getString(1)%></TD>
                    <TD class="td"><%=rs.getString(2)%></TD>
                        <%
                            if (rs.getString(3) != null) {
                        %>
                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="<%=rs.getString(3)%>" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                        } else {
                        %>

                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="0" onKeyPress ="return disableEnterKey(event)"onchange="ValidateValues(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                            }
                        %>

                </tr>

                <% i++;
                    }
                } else if (MARKS.equals("Minor_2")) {%>
                <tr>
                    <th class="th">Student Id</th>
                    <th class="th">Name</th>
                     <th class="th">Minor1</th>
                    <th class="th">Minor2</th>
                </tr>
                <% int i = 0;
                    rs.beforeFirst();
                    while (rs.next()) {%>
                <TR>
                    <%if (rs.getString(1) == null) {%>
                    <td class="td"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(1)%></TD>
                        <%}%>
                        <%if (rs.getString(2) == null) {%>
                    <td class="td"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(2)%></TD>
                        <%}%> <%if (rs.getString(3) == null) {%>
                    <td class="td" style=" background-color:  #F3F781"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(3)%></TD>
                        <%}%>
                       
                    <%
                        if (rs.getString(4) != null) {
                    %>
                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="<%=rs.getString(4)%>" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues(<%=Integer.toString(i)%> );"  ></TD>
                        <%
                        } else {
                        %>
                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="0" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues(<%=Integer.toString(i)%>) ;"  ></TD>
                        <%
                            }
                        %>
                </tr>
                <% i++;
                    }
                } else if (MARKS.equals("Minor_3")) {%>
                <tr>
                    <th class="th">Student Id</th>
                    <th class="th">Name</th>
                    <th class="th">Minor1</th>
                    <th class="th">Minor2</th>
                    <th class="th">Minor3</th>
                </tr>
                <% int i = 0;
                    rs.beforeFirst();
                    while (rs.next()) {%>
                <TR>
                    <%if (rs.getString(1) == null) {%>
                    <td class="td"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(1)%></TD>
                        <%}%>
                        <%if (rs.getString(2) == null) {%>
                    <td class="td"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(2)%></TD>
                        <%}%>
                     <%if (rs.getString(3) == null) {%>
                    <td class="td" style=" background-color:  #F3F781"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(3)%></TD>
                        <%}%>
                        <%if (rs.getString(4) == null) {%>
                    <td class="td" style=" background-color:  #F3F781"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(4)%></TD>
                        <%}%>
                        
                        <%
                            if (rs.getString(5) != null) {
                        %>
                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="<%=rs.getString(5)%>" onchange="ValidateValues(<%=Integer.toString(i)%>) onKeyPress ="return disableEnterKey(event);></TD>
                        <%
                        } else {
                        %>

                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="0" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                            }
                        %>
                </tr>
                <% i++;
                    }
                } else if (MARKS.equals("Major")) {%>
                <tr>
                    <th class="th">Student Id</th>
                    <th class="th">Name</th>
                     <th class="th">Internal(40 marks)</th>
                    <th class="th">Major</th>
                </tr>
                <% int i = 0;
                    rs.beforeFirst();
                    while (rs.next()) {%>
                <TR>
                    <TD class="td"><%=rs.getString(1)%></TD>
                    <TD class="td"><%=rs.getString(2)%></TD>
                        <%if (rs.getString(8) == null) {%>
                    <td class="td" style=" background-color:  #F3F781"></td>
                    <%} else {%>
                    <TD class="td"><%=rs.getString(8)%></TD>
                        <%}
                        
                            if (rs.getString(6) != null) {
                        %>
                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="<%=rs.getString(6)%>" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues1(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                        } else {
                        %>

                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="0" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues1(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                            }
                        %>
                </tr>
                <% i++;
                            }
                        }
                    else if (MARKS.equals("Internal_Major Marks")) {%>
                <tr>
                    <th class="th">Student Id</th>
                    <th class="th">Name</th>
                    <th class="th">Internal(40 marks)</th>
                    <th class="th">Major</th>
                </tr>
                <% int i = 0;
                    rs.beforeFirst();
                    while (rs.next()) {%>
                <TR>
                    <TD class="td"><%=rs.getString(1)%></TD>
                    <TD class="td"><%=rs.getString(2)%></TD>
                        <%if (rs.getString(8) == null) {%>
                    <td class="td"> <input type="text" name="marks1" id="<%=Integer.toString(i)%>" value="0" onKeyPress ="return disableEnterKey(event)"  onchange="ValidateValues1(<%=Integer.toString(i)%>);"  ></td>
                    <%i++;} else {%>
                    <TD class="td"> <input type="text" name="marks1" id="<%=Integer.toString(i)%>" value="<%=rs.getString(8)%>" onKeyPress ="return disableEnterKey(event)" onchange="ValidateValues1(<%=Integer.toString(i)%>);"  ></TD>
                        
                        <%i++;
                        System.out.println("i:"+i);}
                            if (rs.getString(6) != null) {
                        %>
                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="<%=rs.getString(6)%>" onKeyPress ="return disableEnterKey(event)"  onchange="ValidateValues1(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                        } else {
                        %>

                    <TD class="td"><input type="text" name="marks" id="<%=Integer.toString(i)%>" value="0" onKeyPress ="return disableEnterKey(event)"  onchange="ValidateValues1(<%=Integer.toString(i)%>);"  ></TD>
                        <%
                            }
                        %>
                </tr>
                <% i++;
                            }
                        }

                    } catch (Exception e) {
                        System.out.println(e);
                    } finally {
                        if(con1!=null && pst !=null)
                        {
                            pst.close();
                            conn1.closeConnection();
                            con1 = null ;
                        }
                    }
                %>
            </table>
            </br></br>
            <center>  
                <% if(MARKS.equalsIgnoreCase("null")){
                    
                }else{
            %>
                <input type="submit" id="xx" align="center" value="Submit"  > </center>      
            <!--<input type="button" align="center" value="Save" onclick="document.forms.frm.submit();">-->
        <% }%>
        </form>
    </body>
</html>
