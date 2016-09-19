<%-- 
    Document   : projectRegistrationInterns
--%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="table_css1.css">
        <link rel="stylesheet" type="text/css" href="button.css">

        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .blink_me {
                -webkit-animation-name: blinker;
                -webkit-animation-duration: 1s;
                -webkit-animation-timing-function: linear;
                -webkit-animation-iteration-count: infinite;

                -moz-animation-name: blinker;
                -moz-animation-duration: 1s;
                -moz-animation-timing-function: linear;
                -moz-animation-iteration-count: infinite;

                animation-name: blinker;
                animation-duration: 3s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
            }

            @-moz-keyframes blinker {  
                0% { opacity: 1.0; }
            50% { opacity: 0.0; }
            100% { opacity: 3.0; }
            }

            @-webkit-keyframes blinker {  
                0% { opacity: 1.0; }
            50% { opacity: 0.0; }
            100% { opacity: 3.0; }
            }

            @keyframes blinker {  
                0% { opacity: 1.0; }
            50% { opacity: 0.0; }
            100% { opacity: 3.0; }
            }

        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $(".pname").change(function() {
                    var id = this.id;
                    var target_id = 'year'+id;
                    var programme = this.value;
                    if (programme !== "none"){
                        //Make AJAX request, using the selected value as the GET
                        $.ajax({url: 'active_batch_programme_project.jsp?programme='+programme, success: function(output) {
                            $('#'+target_id).html(output);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            System.out.println(xhr.status + " "+ thrownError);
                            System.out.println(ajaxOptions);
                        }});
                    }
                });
                
                $(".year").change(function() {
                    
                    var id = this.id;
                    id = id.replace('year','');
                    
                    var prg = $('#'+id).val();
                    var yr = $('#year'+id).val();

                    var target_id = 'sid'+id;
                    
                    if (prg !== "none" && yr !== "none"){
                        var programmeName = $('#'+id+ ' option:selected').text();
                        var batch = $('#year'+id+ ' option:selected').text();
                        //Make AJAX request, using the selected value as the GET
                        $.ajax({url: 'projectRegistrationInterns_ajax.jsp?programmeName='+programmeName+'&batch='+batch, success: function(output) {
                            $('#'+target_id).html(output);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            System.out.println(xhr.status + " "+ thrownError);
                            System.out.println(ajaxOptions);
                        }}); 
                    }
                });
            });
        </script>
        <script type="text/javascript">
            function check()
            {
                var i = 0;
                var c = 6;
                while (i < 6)
                {
                    //if(document.getElementById("pid1"+i).value=="" || document.getElementById("sid"+i).value=="none" || document.getElementById("sid2"+i).value=="none" )
                    if (document.getElementById("pid1" + i).value === "")
                    {
                        c--;
                        continue;
                    }

                    //alert("Project Title is Empty .");
                    if (document.getElementById("pid1" + i).value === "" && document.getElementById("sid" + i).value !== "" && document.getElementById("cid1" + i).value !== "" && document.getElementById("isid1" + i).value !== "none" && document.getElementById("exsid1" + i).value !== "")
                    {
                        alert("Project Title is Empty .");
                        document.getElementById("pid1" + i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value !== "" && document.getElementById("sid" + i).value === "" && document.getElementById("cid1" + i).value !== "" && document.getElementById("isid1" + i).value !== "none" && document.getElementById("exsid1" + i).value !== "")
                    {
                        alert("Please enter a Student ID.");
                        document.getElementById("sid" + i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value != "" && document.getElementById("sid" + i).value != "" && document.getElementById("cid1" + i).value == "" && document.getElementById("isid1" + i).value != "none" && document.getElementById("exsid1" + i).value != "")
                    {
                        alert("Please enter a Company Name.");
                        document.getElementById("cid1" + i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value != "" && document.getElementById("sid" + i).value != "" && document.getElementById("cid1" + i).value != "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value != "")
                    {
                        alert("Please enter an Internal Supervisor.");
                        document.getElementById("isid1" + i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value != "" && document.getElementById("sid" + i).value != "" && document.getElementById("cid1" + i).value != "" && document.getElementById("isid1" + i).value != "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please enter an External Supervisor.");
                        document.getElementById("exsid1" + i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value != "" && document.getElementById("sid" + i).value != "" && document.getElementById("cid1" + i).value == "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please recheck the fields-1.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value != "" && document.getElementById("sid" + i).value == "" && document.getElementById("cid1" + i).value == "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please recheck the fields0.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value == "" && document.getElementById("sid" + i).value != "" && document.getElementById("cid1" + i).value == "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please recheck the fields1.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value == "" && document.getElementById("sid" + i).value == "" && document.getElementById("cid1" + i).value != "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please recheck the fields2.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value == "" && document.getElementById("sid" + i).value == "" && document.getElementById("cid1" + i).value == "" && document.getElementById("isid1" + i).value != "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please recheck the fields3.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }

                    if (document.getElementById("pid1" + i).value == "" && document.getElementById("sid" + i).value == "" && document.getElementById("cid1" + i).value == "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value != "")
                    {
                        alert("Please recheck the fields4.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }


                    if (document.getElementById("pid1" + i).value != "" && document.getElementById("sid" + i).value != "" && document.getElementById("cid1" + i).value != "" && document.getElementById("isid1" + i).value == "none" && document.getElementById("exsid1" + i).value == "")
                    {
                        alert("Please recheck the fields5.");
                        //document.getElementById("pid1"+i).focus();
                        return false;
                    }
                    i++;

                }
                if (c == 0)
                {
                    alert("Please enter the details of atleast one Student.");

                    return false;
                }

                return true;

            }
            
            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            function fun3(value, id) {
                if (value === "Select Student Id") {
                    if (document.getElementById(id).value === "Select Programme") {
                        document.getElementById(id).focus();

                        document.getElementById(id).style.color = "red";
                        document.getElementById("sid" + id).style.color = 'red';
                        document.getElementById("errfn").innerHTML = "";
                    }
                }
            }
            var j = 7;
            function AddRows()
            {
                j++;
                var ele = document.getElementById('form');
                var tab = document.getElementById('table1');
                var row1 = document.createElement('tr');
                row1.setAttribute('id', "tr1");


                var tdata = document.createElement('td');
                tdata.setAttribute('class', "td");
                var name = document.createElement("input");
                name.setAttribute('type', "text");
                name.setAttribute('name', "pid");
                name.setAttribute('id', "pn");
                name.setAttribute('size', "30");
                //...................
            <%  
                ResultSet rs = scis.facultyList();
                ResultSet rs1 =scis.getProgramme(1, "PhD");

           %>
                var tdata2 = document.createElement('td');
                tdata2.setAttribute('class', "td");
                var name3 = document.createElement('select');
                name3.setAttribute('name', "pgname");
                name3.setAttribute('id', j);
                name3.onchange = function() {
                    loadXMLDoc2(this.id);
                };

                var opt = document.createElement("option");
                opt.text = "Select Programme";
                name3.options.add(opt);
            <%
                while (rs1.next()) {
            %>
                var opt = document.createElement("option");
                opt.value = '<%=rs1.getString(1)%>';
                opt.text = '<%=rs1.getString(1)%>';
                name3.options.add(opt);

            <%}
                rs1.beforeFirst();
            %>
                var tdataYear = document.createElement('td');
//                tdataYear.setAttribute('id', "std1" + j);
                tdataYear.setAttribute('class', "td");
                var nameYear = document.createElement("select");
                nameYear.setAttribute('name', "year");
                nameYear.setAttribute('id', "year" + j);
                nameYear.setAttribute('class', "year");
                var optYear = document.createElement("option");
                optYear.text = "Select Year";
                nameYear.options.add(Year);

                var tdata4 = document.createElement('td');
                tdata4.setAttribute('id', "std1" + j);
                tdata4.setAttribute('class', "td");
                var name4 = document.createElement("select");
                name4.setAttribute('name', "sid");
                name4.setAttribute('id', "sid" + j);
                var opt = document.createElement("option");
                opt.text = "Select Student Id";
                name4.options.add(opt);
                name4.onchange = function() {
                    fun3(this.value, j);
                };

                var tdata5 = document.createElement('td');
                tdata5.setAttribute('class', "td");
                var name5 = document.createElement("input");
                name5.setAttribute('type', "text");
                name5.setAttribute('name', "cid");
                name5.setAttribute('id', "cid");
                name5.setAttribute('size', "15");

                var tdata3 = document.createElement('td');
                tdata3.setAttribute('class', "td");
                var name2 = document.createElement('select');
                name2.setAttribute('name', "isid");
                name2.setAttribute('id', "isid");
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
                var tdata6 = document.createElement('td');
                tdata6.setAttribute('class', "td");
                var name6 = document.createElement("input");
                name6.setAttribute('type', "text");
                name6.setAttribute('name', "exsid");
                name6.setAttribute('id', "exsid");
                name6.setAttribute('size', "14");

                tdata.appendChild(name);
                tdata2.appendChild(name3);
                tdata4.appendChild(name4);
                tdata5.appendChild(name5);
                tdata3.appendChild(name2);
                tdata6.appendChild(name6);
                
                row1.appendChild(tdata);
                row1.appendChild(tdata2);
                row1.appendChild(tdataYear);
                row1.appendChild(tdata4);
                row1.appendChild(tdata5);
                row1.appendChild(tdata3);
                row1.appendChild(tdata6);
                tab.appendChild(row1);
                ele.appendChild(tab);
            }
                
            function disableEnterKey(e) {
                var key;
	 
                if(window.event)
	          key = window.event.keyCode;     //IE
                else
                  key = e.which;     
                if(key === 13)
	          return false;
                else
	          return true;
            }
        </script>
    </head>
    <body bgcolor="#CCFFFF">


        <form  id="form" method="POST"  action="projectRegistrationInterns1.jsp">
            &nbsp;
            <table align="center" id="table1" class="table" >
                <caption><h3>Projects List</h3></caption>
                <th class="th">Project Title</th> 
                <th class="th">Programme Name</th> 
                <th class="th">Year of Joining </th> 
                <th class="th">Student ID </th>
                <th class="th">Company Name</th>
                <th class="th">Internal Supervisor </th>
                <th class="th">External Supervisor</th>
                    <%
                        int i = 0;
                        while (i < 6) {%>
                <tr>


                    <td class="td">
                        <input type="text" id="pid1<%=Integer.toString(i)%>" name="pid" size="30"  onKeyPress="return disableEnterKey(event)">
                    </td>


                    
                    <td class="td">
                        <select class="pname" id="<%=Integer.toString(i)%>" name="pgname">
                            <option>Select Programme</option>
                            <%
                            while (rs1.next()) {%>
                            
                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                            <%}
                                rs1.beforeFirst();
                            %>
                        </select>
                    </td>
                    <td class="td">
                        <select class ="year" id="year<%=Integer.toString(i)%>" name="streamYear">
                            <option value="none">Select Year</option>
                        </select></td>

                    <td class="td">
                        <select id="sid<%=Integer.toString(i)%>" name="sid" onclick="fun3(this.value,<%=Integer.toString(i)%>);">
                            <option>Select Student ID</option>
                        </select>
                    </td>


                    <td class="td">
                        <input type="text" id="cid1<%=Integer.toString(i)%>" name="cid" size="15"  onKeyPress="return disableEnterKey(event)">
                    </td>

                    <td class="td">
                        <select id="isid1<%=Integer.toString(i)%>" name="isid"> 
                            <option value="none">none</option>
                            <% while (rs.next()) {%>

                            <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                            <%}
                                rs.beforeFirst();%>
                        </select>
                    </td>

                    <td class="td">
                        <input type="text" id="exsid1<%=Integer.toString(i)%>" name="exsid" size="14"  onKeyPress="return disableEnterKey(event)">
                    </td>

                </tr>
                <%
                        i++;
                    }%> 

            </table>
            &nbsp;&nbsp;


            <table align="center" class="pos_fixed" width="100%">
                <td align="center"><input type="button" value="Add row" onclick="AddRows();" class="Button"/>&nbsp;&nbsp;
                    <input type="submit" value="submit" class="Button" "/></td><!--onclick="return check();-->
            </table>

            &nbsp;&nbsp;&nbsp;
            <div align="center" id="errfn" style="color: red; font-size: 20px;"><blink></blink></div>
                    <%String user = (String) session.getAttribute("user");%>
            <!--  Welcome <%=user%>-->
            <%
                rs.close();
                rs1.close();
            %>
        </form>

    </body>
</html>