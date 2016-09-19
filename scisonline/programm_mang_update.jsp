<%-- 
    Document   : programm_mang_update
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                text-align: left;
            }
            .pos_fixed
            {   
                position:fixed;
                bottom:5px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold{
                font-weight: bold;
            }

            .Button {

                -moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
                -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
                box-shadow:inset 0px 1px 0px 0px #ffffff;

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #f6f6f6));
                background:-moz-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-webkit-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-o-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-ms-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:linear-gradient(bottom, #ffffff 5%, #f6f6f6 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0);

                background-color:#ffffff;

                -moz-border-radius:2px;
                -webkit-border-radius:2px;
                border-radius:6px;

                border:1px solid #dcdcdc;

                display:inline-block;
                color:black;
                font-family:arial;
                font-size:15px;
                font-weight:bold;
                padding:0px 17px;
                text-decoration:none;

                text-shadow:0px 0px 0px #ffffff;
                border-color: darkgray;

            }
            .Button:hover {

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f6f6f6), color-stop(1, #ffffff));
                background:-moz-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-webkit-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-o-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-ms-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:linear-gradient(bottom, #f6f6f6 5%, #ffffff 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f6f6f6', endColorstr='#ffffff',GradientType=0);

                background-color:#f6f6f6;
            }
            .Button:active {
                position:relative;
                top:1px;
            }

            .Button1 {

                -moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
                -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
                box-shadow:inset 0px 1px 0px 0px #ffffff;

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #f6f6f6));
                background:-moz-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-webkit-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-o-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-ms-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:linear-gradient(bottom, #ffffff 5%, #f6f6f6 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0);

                background-color:#ffffff;

                -moz-border-radius:2px;
                -webkit-border-radius:2px;
                border-radius:6px;

                border:1px solid #dcdcdc;

                display:inline-block;
                color:black;
                font-family:arial;
                font-size:15px;
                font-weight:bold;
                padding:4px 17px;
                text-decoration:none;

                text-shadow:0px 0px 0px #ffffff;
                border-color: darkgray;

            }
            .Button1:hover {

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f6f6f6), color-stop(1, #ffffff));
                background:-moz-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-webkit-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-o-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-ms-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:linear-gradient(bottom, #f6f6f6 5%, #ffffff 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f6f6f6', endColorstr='#ffffff',GradientType=0);

                background-color:#f6f6f6;
            }
            .Button1:active {
                position:relative;
                top:1px;
            }
        </style>

        <script type="text/javascript">
            function disableEnterKey(e) {
                var key;
                if(window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox
	 	if(key === 13)
                    return false;
                else
                    return true;
            }

            stopEvent = function(ffevent)
            {
                var current_window = window;
                if (current_window.event) //window.event is IE, ffevent is FF
                {
                    //IE
                    current_window.event.cancelBubble = true; //this stops event propagation
                    current_window.event.returnValue = false; //this prevents default (usually is what we want)
                }
                else
                {
                    //Firefox
                    ffevent.stopPropagation();
                    ffevent.preventDefault();
                }

            };

            function validateAll(ffevent)
            {
                var var1 = 0, var2 = 0, var3 = 0;
                var inputs = document.getElementsByTagName('input');
                for (var i = 0; i < inputs.length; ++i)
                    if (inputs[i].type === 'text')
                        //@Satish, maybe below you wrote by mistake if(inputs[i].value = '') thus all input elements values get cleared out.
                        if (inputs[i].value === '')
                        {
                            // var1++;
                        }


                var ddlTextBox = document.getElementsByTagName("select");
                for (j = 0; j < ddlTextBox.length; j++) {
                    if (ddlTextBox[j].value === "Select Year") {
                        // var2++;
                    }

                }

                var fup = document.getElementById('cf');
                var fileName = fup.value;
                var ext = fileName.substring(fileName.lastIndexOf('.') + 1);
                if (fup === "" && ext !== ".csv") {
                    var3++;
                    document.getElementById("cf").focus();
                }
                if (var1 > 0) {
                    alert("Form could not be sent one input text field is empty");
                    stopEvent(ffevent);
                } else if (var1 === 0 && var2 > 0) {

                    alert("Form could not be sen one Year button  not selected.");
                    stopEvent(ffevent);
                } else if (var1 === 0 && var2 === 0 && var3 > 0) {

                    alert("Please browse .csv file.");
                    stopEvent(ffevent);
                }

            }


            history.backward();
            /*
             * 
             * creating element dynamically...............
             */
            // var count = 6;


            function AddRows()
            {
                var value = parseInt(document.getElementById('number').value);
                value = isNaN(value) ? 5 : value;
               
                value++;
                document.getElementById('number').value = value;
                var value1=value-1;
                document.getElementById('number1').value = value1;


                p = 2007;
                var date = new Date(), dateArray = new Array(), i;
                curYear = date.getFullYear();
                curYear = curYear + 3;
                var ele = document.getElementById('form3');
                var tab = document.getElementById('table1');
                var row1 = document.createElement('tr');
                row1.setAttribute('id', "tr1");
                var tdata = document.createElement('td');
                var name = document.createElement("input");
                name.setAttribute('type', "text");
                name.setAttribute('name', "text1");
                name.setAttribute('id', "pn" + value1);
                name.setAttribute('size', "12");
                //...................
                var tdata1 = document.createElement('td');
                var name1 = document.createElement("input");
                name1.setAttribute('type', "text");
                name1.setAttribute('name', "text2");
                name1.setAttribute('id', "pc" + value1);
                name1.setAttribute('size', "12");
                //........................................
                var tdata4 = document.createElement('td');
                var name4 = document.createElement("input");
                name4.setAttribute('type', "text");
                name4.setAttribute('name', "text3");
                name4.setAttribute('id', "pg" + value1);
                name4.setAttribute('size', "12");
                //..................................
                var tdata2 = document.createElement('td');
                var name3 = document.createElement('select');
                name3.setAttribute('name', "year");
                name3.setAttribute('id', "yr" + value1);
                var opt = document.createElement("option");
                opt.text = "Select Year";
                name3.options.add(opt);
                while (curYear >= p) {
                    var opt = document.createElement("option");
                    opt.value = curYear;
                    opt.text = curYear;
                    name3.options.add(opt);
                    curYear--;
                }
                var tdata3 = document.createElement("td");
                var name2 = document.createElement("input");
                name2.setAttribute('type', "file");
                name2.className = "Button";
                name2.setAttribute('name', "file1");
                name2.setAttribute('id', "cf" + value1);
                tdata.appendChild(name);
                tdata1.appendChild(name1);
                tdata2.appendChild(name3);
                tdata4.appendChild(name4);
                tdata3.appendChild(name2);
                row1.appendChild(tdata);
                row1.appendChild(tdata1);
                row1.appendChild(tdata4);
                row1.appendChild(tdata2);

                row1.appendChild(tdata3);
                tab.appendChild(row1);
                ele.appendChild(tab);
            }
            //********************************************
            /*
             * 
             * validations
             */
            function RemoveRows() {
                var value = parseInt(document.getElementById('number').value);
                value = isNaN(value) ? 6 : value;
                if (value !== 1) {
                    value--;
                    document.getElementById('number').value = value;
                }
                var tbl = document.getElementById('table1');
                var lastRow = tbl.rows.length;
                if (lastRow > 2)
                    tbl.deleteRow(lastRow - 1);

            }
            function check1() {
                
                var totRows = document.getElementById('number').value;
               
                var flag=0;
              
                for (var i = 0; i < totRows; i++) {
                    var pname = document.getElementById("pn"+i).value;
                    var pcode = document.getElementById("pc"+i).value;
                    var group = document.getElementById("pg"+i).value;
                    var pyear = document.getElementById("yr"+i).value;
                    var pcurr = document.getElementById("cf"+i).value;
                   
                    if (pname !== "" || pcode !== "" || group !== "" || pyear !== "Select Year" || pcurr !== "")
                    {
                        flag++;
                        if (pname === "")
                        {
                            alert("Please enter programme name.");
                            document.getElementById("pn"+i).focus();
                            return false;
                        }
                        else if (pcode === "")
                        {
                            alert("Please enter programme code.");
                            document.getElementById("pc"+i).focus();
                            return false;
                        }
                        else if (group === "")
                        {
                            alert("Please enter programme grop.");
                            document.getElementById("pg"+i).focus();
                            return false;
                        }
                        else if (pyear === "Select Year")
                        {
                            alert("Please enter curriculum year.");
                            document.getElementById("yr"+i).focus();
                            return false;
                        }
                        else if (pcurr === "")
                        {
                            alert("Please browse curriculum file.");
                            document.getElementById("cf"+i).focus();
                            return false;
                        }
                        
                    }
                }
                
                
                if(flag===0)
                {
                    alert("Add atleast one programme.");
                    return false;
                }

            }


        </script>
    </head>
    <body>

        <form action="Commonsfileuploadservlet2" enctype="multipart/form-data" method="POST" name="myform" onsubmit="return check1();">
            <input type="hidden" id="number" value="5"/>
            <input type="hidden" id="number1" value="4"/>
            <%               try {
            %>
            <input type="hidden" name="check" value="7" />   
            <table align="center" border="1" id="table1">
                <tr>
                    <!--                <caption>Add Programme</caption>-->
                    <th class="heading" align="center">Programme Name</th>
                    <th class="heading" align="center">Programme Code</th>
                    <th class="heading" align="center">Group</th>
                    <th class="heading" align="center">Year</th>

                    <th class="heading" align="center">Curriculum</th>

                </tr>
                <%
                    int p = 2007, cyear1, i;
                    Calendar now = Calendar.getInstance();
                    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                            + "-"
                            + now.get(Calendar.DATE)
                            + "-"
                            + now.get(Calendar.YEAR));
                    int cyear = now.get(Calendar.YEAR);

                    for (i = 0; i < 5; i++) {
                        cyear1 = cyear + 3;
                %>
                <tr id="tr1">

                    <td><input type="text" name="text1" id="pn<%=i%>" size="12" onKeyPress="return disableEnterKey(event)"></td> 
                    <td><input type="text" name="text2" id="pc<%=i%>" size="12" onKeyPress="return disableEnterKey(event)"> </td>
                    <td><input type="text" name="text3" id="pg<%=i%>" size="12" onKeyPress="return disableEnterKey(event)"> </td>
                    <td><select name="year" id="yr<%=i%>">
                            <option>Select Year</option>
                            <%while (cyear1 >= p) {%>
                            <option><%=cyear1%></option>
                            <% cyear1--;
                                }%>
                        </select></td>
                    <td><input type="file" name="file1" id="cf<%=i%>" class="Button"></td>            
                </tr>
                <%}%>
            </table>
            <table class="pos_fixed" width="100%">
                <tr>
                    <td align="center">
                        <input type="button" name="add" value="Add more rows" class="Button1" onclick="AddRows();">
                        <input type="button" name="remove" value="Remove rows" class="Button1" onclick="RemoveRows();">
                        <input type="submit" name="submit" value="Submit" class="Button1">
                    </td>

                </tr>                             
            </table>

            <table align="center">
                <tr>
                    <td><div class="style30" id="errfn"></div></td>&nbsp;
                </tr>                             
            </table>


        </form>
        <%
        } catch (Exception ex) {
            System.out.println(ex);
        %>
        <script>


            window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
        </script>
        <%
            }
        %>
    </body>
</html>
