<%-- 
    Document   : addSubject
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
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
        </script>
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                for(var i = 0; i < 5; i++) {
                    $('#sid'+i).change(function() {
                        var sid = $(this).val().toUpperCase();
                        $(this).val(sid);
                    });
                    $('#sname'+i).change(function() {
                        var sid = $(this).val().toUpperCase();
                        $(this).val(sid);
                    });
                }
                
                $('#submit').click(function(){
                    var count = 0;
                    var valid = 1;
                    for(var i = 0; i < 5; i++) {
                        var sid = $('#sid'+i).val();
                        var sname = $('#sname'+i).val();
                        var stype = $('#stype'+i).val();
                        var credit = $('#credits'+i).val();
                        if(sid !== '' && sname !== '' && stype !== '' && credit !== '') {
                            count = count + 1;
                            var status = 1;
                            $.ajax({
                                url: 'ajax_addSubject_validate.jsp?sid='+sid,
                                async: false,
                                success: function(output) {
                                    status = $.trim(output);
                                }
                            });
                            if(status === "0") {
                                valid = 0;
                                alert("Subject ID "+sid+" already exists.");
                                break;
                            }
                        } else if(sid === '' && sname === '' && stype === '' && credit === '') {
                            
                        } else {
                            var r = i + 1;
                            alert("Row - "+r+" is incomplete.");
                            valid = 0;
                            break;
                        }
                    }
                    if(valid === 1 && count === 0) {
                        valid = 0;
                        alert("At least enter one subject details.");
                    }
                    if(valid === 1) {
                        $("form").submit();
                    } else {
                        return false;
                    }
                });
            });
        </script>
    </head>
    <body>
        <form action="addSubject_link.jsp" method="get" name="form1">
            <table align="center">
                <tr><th colspan="4" align="center"><font size="5">Add New Subjects</font></th></tr>
                <tr></tr>
                <tr>
                    <th>Subject ID</th>
                    <th>Subject Name</th>
                    <th>Subject Type</th>
                    <th>Credits</th>
                </tr> <%
                int i = 0;
                while(i < 5) { %>
                    <tr>
                        <td><input type="text" id="sid<%=i%>" name="sid" value="" onKeyPress="return disableEnterKey(event);"></td>
                        <td><input type="text" id="sname<%=i%>" name="sname" value="" onKeyPress="return disableEnterKey(event);"></td>
                        <td><!--input type="text" name="stype" value="" onKeyPress="return disableEnterKey(event);"-->
                            <select id="stype<%=i%>" name="stype">
                                <option value="">Choose Subject Type</option>
                                <option value="E">Elective</option>
                                <option value="O">Optional Core</option>
                            </select>
                        </td>
                        <td><input type="number" min="1" id="credits<%=i%>" name="credits" value="" onKeyPress="return disableEnterKey(event);"></td>
                    </tr> <%
                    i++;
                } %>
                <tr><td colspan="4" align="center"><button id="submit">submit</button></td></tr>
            </table>
        </form>
    </body>
</html>
