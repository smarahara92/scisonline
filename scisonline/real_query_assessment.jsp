<%-- 
    Document   : real_query_assessment
    Created on : Mar 31, 2015, 4:32:53 PM
    Author     : richa
--%>
<%@page  import = "java.sql.ResultSet"%>
<%@page  import = "java.sql.*"%>
<%@include file ="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/jquery.mobile-1.4.5.min.css">
        <link rel="stylesheet" href="./css/query_style.css">
        <script src="./js/jquery.min.js"></script>
        <script> 
            var printID = '';
            var myelement;
            $(document).ready(function() {
                $('#sq0').load("programmeBatchDropDownMenu.jsp?id=0");
                $('#sq1').load("programmeBatchDropDownMenu.jsp?id=1");
                alert("");
                
                $(".toggle").slideUp();
                $(".trigger").click(function() {
                    var myelement = $(this).next(".toggle");
                    var queryid = this.id;
                                 
                    $(".toggle:visible").not(myelement).hide();
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
                
                $('.prgBatch0').change(function(){
                    var pname = $('#pgname0').val();
                    var pyear = $('#year0').val();
                    alert(pname+pyear);
                    $('#target10').load("Q_F_core3.jsp?pname="+pname+"&pyear="+pyear);
                });
                $('.prgBatch1').change(function(){
                    var pname = $('#pgname1').val();
                    var pyear = $('#year1').val();
                    alert(pname+pyear);
                    $('#target11').load("Q_allF3_15.jsp?pname="+pname+"&pyear="+pyear);
                });
                 
            });
        </script>
    </head>
    <body>
        <table align="center" width="75%"><tr><td>
        <div id = "q0" class = "trigger x ui-btn ui-icon-plus ui-btn-icon-left">List of students who have F grade in core subjects  </div>
        <div class = "toggle" id="sq0">
           
        </div>
        <div id = "q1" class = "trigger x ui-btn ui-icon-plus ui-btn-icon-left">List of students who have F grade in at least one subject </div>
        <div class = "toggle" id="sq1"></div>
        
         <div id = "target1"></div>
        </div>&nbsp;
        </td></tr>
             </table> 
        <table width="100%" class="pos_fixed" id="printTable" style="visibility:hidden;">
            <tr>
                <td align="center" class="border"> <input  type="button" class="border" value="Print" id="print" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;"/>
                </td>
            </tr>
        </table>

    </body>
</HTML>