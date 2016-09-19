<%-- 
    Document   : faculty_upload
--%>


<%@include file="checkValidity.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script type="text/javascript" src="jquery.js"></script>  
        <script type="text/javascript">
          /*  function Upload()
            {
                var xmlhttp1;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp1 = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                    xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp1.onreadystatechange = function()
                {
                    if (xmlhttp1.readyState === 4 && xmlhttp1.status === 200)
                    {
                        var x = xmlhttp1.responseText;

                        var xml = x;
                        xmlDoc = $.parseXML(xml);
                        $xml = $(xmlDoc);
                        $title = $xml.find("body");
                        var test = $title.text();
                        if (test.contains("true"))
                        {
                            var r = confirm("This will erase the existing data.Do you want to continue?");
                            if (r === true) {

                                document.frm2.action = "facultyinfo.jsp";
                                document.frm2.submit();
                            }
                        }
                    }
                };

                xmlhttp1.open("GET", "faculty_uploadcheck_ajax.jsp", true);
                xmlhttp1.send();

            }//*/
                
            function open1() {
                document.frm2.action = "faculties.jsp";
                document.frm2.submit();
            }
            function open2() {
                document.frm2.action = "addFaculty.jsp";
                document.frm2.submit();
            }
            function open3() {
                document.frm2.action = "deleteFaculty.jsp";
                document.frm2.submit();
            }
        </script>
    </head>
    <body bgcolor="EOFFFF">
        <h3 ><font color="#c2000d"> Faculty Database</font></h3>   <br><br>
        <form name="frm2" target="subdatabase" action="" method="post" >
            <!--input type="radio" id="r" name="r" value="Upload" onclick="Upload();">Upload<br-->
            <input type="radio" id="r" name="r" value="View" onclick="open1();">View<br>
            <input type="radio" id="r" name="r" value="Add Faculty" onclick="open2();" >Add Faculty<br>
            <input type="radio" id="r" name="r" value="Delete Faculty" onclick="open3();">Delete Faculty<br>
        </form>
    </body>
</html>
