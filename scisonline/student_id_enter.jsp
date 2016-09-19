<%-- 
    Document   : student_id_enter
    Created on : 4 May, 2014, 2:50:37 PM
    Author     : srinu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        String id = request.getParameter("ID");
        String rdirectPage = request.getParameter("RdirectPage");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#rollno<%=id%>').change(function(){
                    //alert("<%=rdirectPage%>");
                    var rollno = $(this).val();
                    $('#target<%=id%>').load("<%=rdirectPage%>?studentid=" + rollno);
                });//*/
            });
        </script> 
        <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javascript">
            function find()
            {
                
                document.form1.submit();
            }
        </script-->
        
        
    </head>
    <body>
        <!--form name="form1" action="fullrecordview.jsp" target="staffaction" method="POST"-->
            <br>
    <center><b>Enter Student ID:  </b><input id = "rollno<%=id%>" type="text"   name="studentid" value="">
    <div id = "target<%=id%>"></div>   
                
        <!--/form-->
    </body>
</html>
