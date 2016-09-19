<%-- 
    Document    :   course_reg_start
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading {
                color: white;
                background-color: #c2000d;
            }
            .border {
                background-color: #c2000d;
            }
            .pos_fixed {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold {
                font-weight: bold;
            }
        </style>
        <script>
            function fun1() {
                document.getElementById("stream").focus();
                document.getElementById("year1").focus();
                 
                d = new Date();
                curr_year = d.getFullYear();
                //curr_year=curr_year+1;
                //   
                for(i = 0; i < 6; i++) {  
                    document.getElementById('year1').values[i] = new Option(curr_year-i+1,curr_year-i+1);
                    document.getElementById('year1').options[i] = new Option(curr_year-i+1,curr_year-i+1);
                    document.getElementById('year1').values[i] = new Value(curr_year-i+1,curr_year-i+1);
                }
            } 
             
            // for new, here we cal page for start date, end date. 
            function open1() {
                document.frm2.action="course_reg_new.jsp";
                //document.frm2.target="right_f";
                document.frm2.submit();
            }
            
            // for modify
            function open2() {
                document.frm2.action="course_reg_modify.jsp";
                // document.frm2.target="right_f";
                document.frm2.submit();
            }
             
            // for delete all
            function open3() {
                var x;
                var r=confirm("Delete whole registration? ");
                if (r===true) {
                  //  document.frm2.action="sub-faconline_delete.jsp";
                // document.frm2.target="right_f";
                //document.frm2.submit();
                }
            }
             
            // for view
            function open4() {               
                document.frm2.action="course_reg_view.jsp";
                // document.frm2.target="right_f";
                document.frm2.submit();
            }
        </script>
    </head>
    <body>
<%
        Calendar now = Calendar.getInstance();
        int sys_year = now.get(Calendar.YEAR);
        int next_year = sys_year + 1;
        int prev_year1 = sys_year - 1;
        int prev_year2 = sys_year - 2;
        int prev_year3 = sys_year - 3;
        int prev_year4 = sys_year - 4;
        int prev_year5 = sys_year - 5;

%> 
        <table width="100%">
            <tr>
                <th colspan="5" class="style30" align="center"><font size="6">Course Registration</font></th>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        <form name="frm2" method="POST">
            <table align="center" border="1">
                <tr>
                    <th class="heading" align="center">Session</th>
                    <th class="heading" align="center">Year</th>
                </tr>
                <tr>
                    <td class="style30">
                        <select  id="stream" name="current_session" >
                            <option value="none" > Select Session </option>
                            <option value="Winter" > Winter </option>
                            <option value="Monsoon">Monsoon</option>
                        </select></td>
                    <td>
                        <select name="year2" id="year1" style="width:200px;" >
                            <option value="none">Select Year</option>
                            <option value="<%=next_year%>"><%=next_year%></option>
                            <option value="<%=sys_year%>"><%=sys_year%></option>
                            <option value="<%=prev_year1%>"><%=prev_year1%></option>
                            <option value="<%=prev_year2%>"><%=prev_year2%></option>
                            <option value="<%=prev_year3%>"><%=prev_year3%></option>
                        </select>
                    </td>              
                </tr>      
            </table>
            <table align = "center">
                <tr>
                    <td id = "erMsg"></td>
                </tr>
            </table>
            <br>
            <table align="center">
                <tr>
                    <td colspan="2" align="center" id="bold">
                        <input type="button" id="newbtn" name="new" value="Register" style="height: 28px; width: 80px" onclick="open1();" disabled="disabled">&nbsp;
                        <input type="button"  id="modifybtn" name="modify" value="Modify" style="height: 28px; width: 80px" onclick="open2();" disabled="disabled" />&nbsp;
                        <input type="button" name="view" id="viewbtn" value="View" style="height: 28px; width: 80px" disabled="disabled" onclick="open4();">
                    </td>
                </tr>
            </table>
        </form>
        <script>
            $( "select" ).change(function() {   // to call when we select the value in the drop down box. note if use "#year1 instead of "#year1 option we will get weired response.
                var year=$("#year1").val(); 
                var stream=$("#stream").val();
                
                if((year!=="none") && (stream!=="none")) {
                    document.getElementById("erMsg").innerHTML = "";
                    $.ajax({
                        url:"checkonserver_reg.jsp",
                        data: {selectedYear : year, stream: stream},
                        success:function(msg) {
                            //alert(msg);  // msg contains respons from ajax in the form xml
                            var xml =msg, // xml should be like this "<html><head><title>JSP Page</title></head><body>It's HOT</body></html> ",
                            xmlDoc = $.parseXML( xml ),
                                    $xml = $( xmlDoc ),
                                    $title = $xml.find( "body" );
                            var test= $title.text();
                            if(test.contains("00")||test.contains("01")) {
                                document.getElementById("newbtn").disabled=true;
                                document.getElementById("modifybtn").disabled=true;
                                //document.getElementById("deletebtn").disabled=true;
                                document.getElementById("viewbtn").disabled=true;
                                alert("Alocation was not done.");
                            } else if(test.contains("10") ) {
                                document.getElementById("newbtn").disabled=true;
                                document.getElementById("modifybtn").disabled=true;
                                //document.getElementById("deletebtn").disabled=false;
                                document.getElementById("viewbtn").disabled=true;
                                alert("Stream limits not given");
                            } else if(test.contains("11")) {
                                document.getElementById("newbtn").disabled=false;
                                document.getElementById("modifybtn").disabled=false;
                                //document.getElementById("deletebtn").disabled=true;
                                document.getElementById("viewbtn").disabled=false;
                                // alert("11");
                            }
                            // Append "RSS Title" to #someElement
                            //$( "#someElement" ).append( $title.text() );
                        }
                    });
                } else {
                    if((year==="none") && (stream==="none")) {
                        document.getElementById("erMsg").innerHTML = "*Select Session and year";
                    } else if(year !== "none") {
                        document.getElementById("erMsg").innerHTML = "*Select Session";
                    } else {
                        document.getElementById("erMsg").innerHTML = "*Select Year";
                    }
                    //alert("Select Session and year");
                }
            });
        </script>
    </body>
</html>