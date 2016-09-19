<%-- 
    Document   : chooose_ele_other_schools_modify1
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>


        <style>
            .style30 {color: red}
            .style31 {
                background-color: #c2000d;
                color: white}
            .style32 {color: green}
            .style44{

                background-color: #9FFF9D;
            }




        </style> 


        <style type="text/css">
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos
            {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos
            {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos
            {
                top:200px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {   
                background-color: #c2000d;
            }

            td,table
            {
                white-space: nowrap;


            }


        </style>
       
    </head>
    <body>
        <%
            Connection con = conn.getConnectionObj();
           // String given_session = "";
            String stream = "";
            stream = (String) request.getParameter("stream");

            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            %>
    <form name="frm1">

        <h2 align="center" class="style30" > Modify Course Registration </h2>

        <table align="center" border="1"><!-- class="table_pos"-->

            <tr class="fix">

                    <td class="style31" align="center"><b>Student ID</b></td>
                   
                    <td class="style31" align="center"><b>Course 1</b></td>
                    <td class="style31" align="center"><b>Course 2</b></td>
                    <td class="style31" align="center"><b>Course 3</b></td>
                    <td class="style31" align="center"><b>Course 4</b></td>
                    <td class="style31" align="center"><b>Grade Formula</b></td>

                </tr>
            <tr>
                <td>
                  <select name="student_id" id="student">
                  <option value="none">Select</option>         
               
             <% 
            
            
    String stream_table=" Other_Schools_"+given_session+"_"+given_year;
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from " + stream_table + "");
                while (rs.next()) {
                    String student_id = rs.getString(1);
                    String student_name = rs.getString(2);

            %>
        

                
                 <option value="<%=student_id%>"><%=student_id%></option>
               
                <%  
                }
                
                %>
                  </select>
                  </td>
                  
                  <%
                    
                  for(int i=1;i<=5;i++){
                      
                   %>
                   <td>
                   <select>
                  <option value="none">None</option>    
                  </select>
                   </td>
                  <%    
                      
                      
                  }
                     
                  %>
                  
                  
                  
                  </tr>
                 
        </table>       
            <table>
                <tr><td>&nbsp;</td></tr>
                 <tr><td>&nbsp;</td></tr>
                  <tr><td>&nbsp;</td></tr>
                 
                 
            </table>
     
                <script>
                    
            $( "#student option" ).click(function() {   // to call when we select the value in the drop down box. note if use "#year1 instead of "#year1 option we will get weired response.
                var student_id=$("#student").val(); 
                //alert("oue");
                if(student_id=="none"){
                    alert("enter the student id")
                }
                else{
                     document.getElementById('send_id').value =student_id;
                    // alert("test okey");
                document.frm1.action="choose_ele_other_schools_modify2.jsp";
               
                document.frm1.submit();
                    
                }
     
             });    
             
             
                    
                </script>
            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>"> 
            
            <input type="hidden" name="stream_table" value="<%=stream_table%>">
            <input type="hidden" id="send_id" name="selected_id">
    </form>
            <%
                conn.closeConnection();
                con = null;
            %>
    </body>
</html>
