<%-- 
    Document   : jquery_test
    Created on : Oct 15, 2013, 2:05:10 PM
    Author     : sri
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <select id="stream" name="current_session" >
                <option value="Winter">Winter</option>
                <option value="Monsoon">Monsoon</option>
        </select>
<p id="someElement"></p>
<script>
$( "#stream" ).change(function() {
  var selectedVal=$("#stream option:selected").val();
  $.ajax({
     url:"checkonserver.jsp?given_year="+selectedVal,
     success:function(msg){
             alert(msg);
             
             var xml =msg, // xml should be like this "<html><head><title>JSP Page</title></head><body>It's HOT</body></html> ",
xmlDoc = $.parseXML( xml ),
$xml = $( xmlDoc ),
$title = $xml.find( "body" );
var year= $title.text();
alert("helo "+year);
// Append "RSS Title" to #someElement
$( "#someElement" ).append( $title.text() );
             
             
     }
  });
});
</script>
        
    </body>
</html>
