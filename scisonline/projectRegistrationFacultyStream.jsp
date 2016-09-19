<%-- 
    Document   : projectRegistrationFacultyStream
    Created on : Dec 20, 2013, 12:12:49 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@include file="programmeRetrieveBeans.jsp"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%--@include file="dbconnection.jsp"--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}
            .input {
                line-height: 3em;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }

        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            var flag = 0, flag1 = 0;
            //=====================================================ajax code======
            function validate(pid1)
            {

                var pid = pid1;


                var k = document.getElementById(pid).value;


                var urls = "projectTitleCheck_ajax.jsp?streamProject=" + k;

                var xmlhttp;

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
                        var confirm1 = xmlhttp.responseText;
                        //document.getElementsByTagName("input").readOnly = false;
                        if (confirm1 > 0)
                        {
                            //check3++;

                            alert(k + " poject title already exists.");


                        }

                    }
                }
                ;
                xmlhttp.open("GET", urls, true);
                xmlhttp.send();
            }

//======================================================================



            function check()
            {
                var co = document.getElementById("counter1").value;
                k = co;
                var j;
                for (j = 1; j <= k; j++) {
                    var projectName = document.getElementById("pid1" + j).value;
                    if (projectName !== "") {
                        return true;
                    } else if (j == k) {

                        alert("Please enter the details of atleast one Project.");
                        return false;
                    }
                }

            }


            function fun1(h) {

                var res = h.substr(4);

                var user = document.getElementById("hid").value;


                var pgname = document.getElementById("pid1" + res).value;


                var sup2 = document.getElementById("sid1" + res).value;
                var sup3 = document.getElementById("sid2" + res).value;

                if (pgname === "" && sup2 !== "none") {

                    document.getElementById("pid1" + res).focus();
                    document.getElementById("sid1" + res).value = "none"
                    alert("Project Title is Empty .");
                    return;

                }

                if (pgname === "" && sup3 !== "none") {

                    document.getElementById("pid1" + res).focus();
                    document.getElementById("sid2" + res).value = "none";
                    alert("Project Title is Empty .");
                    return;

                }

                if (sup2 === "none" && sup3 !== "none") {

                    document.getElementById("sid2" + res).value = "none";
                    alert(" Please select supervisor2. ");
                    return;

                }
                if (sup2 === sup3) {

                    alert("2 Supervisors cannot have the same name.");
                    document.getElementById("sid2" + res).value = "none";
                    document.getElementById("sid1" + res).focus();
                    return false;

                }
                if (document.getElementById("sid1" + .res).value === user || document.getElementById("sid2" + res).value === user) {

                    alert("Your name cannot give as supervisor2 or supervisor3");
                    if (document.getElementById("sid1" + res).value === user) {
                        document.getElementById("sid1" + res).value = "none";


                    }
                    if (document.getElementById("sid2" + res).value === user) {
                        document.getElementById("sid2" + res).value = "none";


                    }


                }

            }



            var counter = 6;

            function AddRows()
            {


                var ele = document.getElementById('form');
                var tab = document.getElementById('table1');
                var row1 = document.createElement('tr');
                row1.setAttribute('id', "tr1");


                var tdata = document.createElement('td');
                tdata.setAttribute('class', "td");
                var name = document.createElement("input");
                name.setAttribute('type', "text");
                name.setAttribute('name', "prname");
                name.setAttribute('id', "pid1" + counter);
                name.setAttribute('onchange', 'fun1("pid1' + counter + '")');
                name.setAttribute('size', "50");
                //...................
            <%

                int i = 1;
                String user = (String) session.getAttribute("user");
                String projectStream = request.getParameter("stream");
                System.out.println(projectStream);
                session.setAttribute("ProjectRegStream", projectStream);
                String streamBatch = request.getParameter("batch"); //year of join
                session.setAttribute("StreamBatch", streamBatch);
/*                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();*/
                ResultSet rs =scis.facultyList();
              

            %>

                var tdata2 = document.createElement('td');
                tdata2.setAttribute('class', "td");
                var name3 = document.createElement('select');
                name3.setAttribute('name', "sup2");

                name3.setAttribute('id', "sid1" + counter);

                var opt = document.createElement("option");
                name3.setAttribute('onchange', 'fun1("sid1' + counter + '")');
                opt.text = "none";
                name3.options.add(opt);
            <%
                while (rs.next()) {
            %>

                var opt = document.createElement("option");
                opt.value = '<%=rs.getString(1)%>';
                opt.text = '<%=rs.getString(2)%>';
                name3.options.add(opt);

            <%}
                rs.beforeFirst();
            %>


                var tdata3 = document.createElement('td');
                tdata3.setAttribute('class', "td");
                var name2 = document.createElement('select');
                name2.setAttribute('name', "sup3");
                name2.setAttribute('id', "sid2" + counter);
                name2.setAttribute('onchange', 'fun1("sid2' + counter + '")');
                var opt1 = document.createElement("option");
                opt1.text = "none";
                name2.options.add(opt1);
            <%
                while (rs.next()) {
            %>

                var opt1 = document.createElement("option");
                opt1.value = '<%=rs.getString(1)%>';
                opt1.text = '<%=rs.getString(2)%>';
                name2.options.add(opt1);

            <%}
                rs.beforeFirst();
            %>


                tdata.appendChild(name);

                tdata2.appendChild(name3);

                tdata3.appendChild(name2);
                row1.appendChild(tdata);


                row1.appendChild(tdata2);

                row1.appendChild(tdata3);
                tab.appendChild(row1);
                ele.appendChild(tab);
                document.getElementById("counter1").value = counter;
                counter++;

            }
            
            function disableEnterKey(e)
            {
                var key;
	 
                if(window.event)
	          key = window.event.keyCode;     //IE
                else
                  key = e.which;     //firefox
	 	
		//alert("helloi");
                if(key === 13)
	          return false;
                else
	          return true;
            }
            

        </script>

        <link rel="stylesheet" type="text/css" href="table_css1.css" media="screen" />    </head>

    <body bgcolor="#CCFFFF">

        <form  id="form" method="POST" onsubmit="return check();" action="projectRegistrationFacultyStreamlink.jsp">
            &nbsp;
            <table align="center" id="table1"  class="table">
                <caption><h2>Projects List</h2> </caption>
                <tr>
                    <th class="th">Project Title </th> 
                    <th class="th">Supervisor 2</th>
                    <th class="th">Supervisor 3</th>
                </tr>
                <%

                    while (i < 6) {%>
                <tr>
                    <td class="td"><input type="text" id=pid1<%=Integer.toString(i)%>  name="prname"  size="50"   onchange="validate(this.id);"  onKeyPress="return disableEnterKey(event)"></td>

                    <td class="td"><select id=sid1<%=Integer.toString(i)%> name="sup2" onchange="fun1(this.id);"> 
                            <option value="none">none</option>
                            <% while (rs.next()) {%>

                            <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                            <%}
                                rs.beforeFirst();%>
                        </select></td>
                    <td class="td"><select id=sid2<%=Integer.toString(i)%> name="sup3" onchange="fun1(this.id);"> 
                            <option value="none">none</option>
                            <% while (rs.next()) {%>
                            <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                            <%}
                                rs.beforeFirst();%>
                        </select></td>
                </tr>
                <%
                        i++;
                    }
                    rs.close();
                %> 

            </table>

            &nbsp;
            <table align="center" width="100%" class="pos_fixed">

                <td align="center"><input type="button" value="Add row" onclick="AddRows();" class="Button"/>&nbsp;&nbsp;
                    <input type="submit" value="Submit" class="Button"/></td>

            </table>
            <input type="hidden" id="counter1" value="5">
            <input type="hidden" id="hid" value="<%=user%>">
        </form>

    </body>
</html>

