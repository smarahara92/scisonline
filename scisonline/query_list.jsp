<%-- 
    Document   : query_list
    Created on : 23 Feb, 2015, 2:42:43 PM
    Author     : nwlab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
<%
        String heading = request.getParameter("heading");
        String[] title = request.getParameterValues("queryTitle");
        String[] link = request.getParameterValues("queryLink");
        int len = title.length;
%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/jquery.mobile-1.4.5.min.css">
        <link rel="stylesheet" href="./css/query_style.css">
        <script src="./js/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                
                var printID = ''; //need to maintained dynamically
                
                $(".toggle").slideUp();
                $(".trigger").click(function() {
                    //var myelement = $(this).next(".toggle");
                    var queryid = this.id;
                    var myelement = "#ql"+queryid;
                    
                    switch(queryid) {
<%
                        for(int i = 0; i < link.length; ++i) {
%>
                            case "<%=i%>" : $(myelement).load("<%=link[i]%>");
                                            break;
<%                            
                        }
%>
                    }
                    
                    $(".toggle:visible").not(myelement).hide();
                    
 //                   $(document).ajaxComplete(function(){
                    
                        $(myelement).slideToggle("slow", function() {
                            if($(".trigger").hasClass('ui-icon-minus')) {
                                $(".trigger").removeClass('ui-icon-minus');
                                $(".trigger").addClass('ui-icon-plus');
                            }
                            printID = $(".toggle:visible").attr("id");
                            if (typeof printID === "undefined") {
                                $('#printTable').css("visibility", 'hidden');
                            } else {
                                $('#printTable').css("visibility", 'visible');
                                var t = $(this).prev(".trigger");
                                if($(t).hasClass('ui-icon-plus')) {
                                    $(t).removeClass('ui-icon-plus');
                                    $(t).addClass('ui-icon-minus');
                                }
                            }
                        });
//                    });
                });
                
                $("#print").click(function(){
                    var data = $('#'+printID).html();
    
                    var mywindow = window.open('height=400,width=600');
                    mywindow.document.write('<html><head><style>');
                    mywindow.document.write('@media print { .noPrint {display:none;}}');
                    mywindow.document.write('</style></head><body>');
                    mywindow.document.write(data);
                    mywindow.document.write('</body></html>');

                    mywindow.document.close(); // necessary for IE >= 10
                    mywindow.focus(); // necessary for IE >= 10
                    
                    mywindow.print();
                    mywindow.close();

                });
            });
        </script>
    </head>
    <body>
        <h3 style="color:#c2000d" align="center"><%=heading%></h3>
        <table align="center" width="75%"><tr><td>
<%
            for(int i = 0; i < title.length; ++i) {
%>
                <div id = "<%=i%>" class = "trigger ui-btn ui-icon-plus ui-btn-icon-left"><%=title[i]%></div>
                <div id = "ql<%=i%>" class = "toggle"></div>
<%                
            }
%>        

        </td></tr>
            <tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
            <tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
            <tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr>
        </table>   
        <table width="100%" class="pos_fixed" id="printTable">
            <tr>
                <td align="center" class="border"> <input type="button" class="border" value="Print" id="print" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;"/>
                </td>
            </tr>
        </table>
    </body>
</html>