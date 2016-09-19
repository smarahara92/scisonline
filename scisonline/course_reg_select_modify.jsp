<%-- 
    Document   : course_reg_select_modify
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="connectionBean.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>

        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
        </style>
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
        <title>Insert title here</title>
    </head>
    <body bgcolor="#CCFFFF">
        <%
            Connection con = conn.getConnectionObj();

           // String given_session = "";
            String stream = "";
            stream = (String) request.getParameter("stream");

            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
           // given_session=given_session;
           // System.out.println(" nw testing params here :"+given_session+given_year);
            //String given_session = (String)session.getAttribute("given_session");
            //if(year)
            //String stream=Integer.toString(year);
            String s = "";
            int i = 0;
           System.out.println("given Stream "+stream);
        %>

   <table>
            <tr>
                <td><font color="#c2000d"><b>Select Stream</b></font></td>

                <td>
                    <select name="stream" id="stream" >

                        <%
                            Statement st1 = (Statement) con.createStatement();
                            ResultSet rs2 = (ResultSet) st1.executeQuery("select * from " + given_session + "_stream where electives='yes'");

                            if (stream == null || stream == "") {
                        %>
                        <option value="" selected="selected">--choose--</option>
                        <option value="Other" >Other</option>




                        <%

                            while (rs2.next()) {

                        %>

                        <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>  
                        <%


                            }
} else if(stream.equalsIgnoreCase("Other")) {%>


                        <option value="">--choose--</option>
<option value="Other" selected="selected" >Other</option>

                        <%

                            while (rs2.next()) {

                                //if(stream!=null)
                            
                        %>

                        <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>  
                        <%
                                  

                                }
                            }
                            else {%>


                        <option value="">--choose--</option>
<option value="Other" >Other</option>

                        <%

                            while (rs2.next()) {

                                //if(stream!=null)
                                if (stream.equals(rs2.getString(1))) {
                        %>
                        <option value="<%=rs2.getString(1)%>" selected="selected"><%=rs2.getString(1)%></option>

                        <%    } else{
                        %>

                        <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>  
                        <%
                                    }

                                }
                            }

                        %>
                    </select>
                </td>
            </tr>
        </table>
        <%
            Statement st = con.createStatement();
            ResultSet rs = null;
            if (!(stream == null)&& !(stream.equalsIgnoreCase("Other")) ) {
                stream = stream.replace('-', '_');
                rs = st.executeQuery("select Code, Subject_Name ," + stream + ",type from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name and b." + stream + "!=0");

        %>
        <table>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td><font color="#c2000d"><b>Elective/Optional Core List for <%=stream.replace('_', ' ')%></b></font></td>
            </tr>
        </table>
        <table border="1">
              <tr>
                        <th align="left">Course</th>
                        <th align="left">Total Seats</th>
                        <th align="left">Type</th>
                </tr>
            <%
                while (rs.next()) {


            %>
            <tr>
                
                <td align="left"><%=rs.getString(2)%></td>
                <td align="left"><%=rs.getString(3)%></td>
                <td align="left"><%=rs.getString("type")%></td>
            </tr>
            <%

                }
            %>
        </table>
        <%
            }

        %>
        </br>
        </br>

    </body>
    <script type="text/javascript">
 
 
  $( "#stream option" ).click(function() { 
 
 
 
 

            
                var stream = document.getElementById("stream").value;
       
                if(stream!=null)
                    {
                        if(stream=="")
                            alert("Please choose 'stream'...!");
                       else if(stream=="Other"){
                    var hint="yes";
                    //alert(stream);
                    parent.left.location="./course_reg_select_modify.jsp?stream="+stream+"&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                       
                       
                            //stream = stream.replace('-', '_');
                            parent.act_area.location="./choose_ele_other_schools_modify1.jsp?stream=Other&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                    
                    
                    }
                       else
                        {   //stream = stream.replace('-', '_');
                            parent.left.location="./course_reg_select_modify.jsp?stream="+stream+"&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                       
                       
                            //stream = stream.replace('-', '_');
                            parent.act_area.location="./choose_ele_modify.jsp?stream="+stream+"&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                        }
                    }
            

            function show_stream()
            {
                var stream = document.getElementById("stream").value;
	
            }
            
             });
        </script>
<%
    conn.closeConnection();
    con = null;
%>                        
</html>