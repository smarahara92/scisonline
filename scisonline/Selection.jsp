<%-- 
    Document   : Selection
    Created on : 6 Feb, 2012, 2:59:11 PM
    Author     : khushali
--%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {width:300px}
        </style>
        <script type="text/javascript">

            function checked1()
            {
                window.document.forms["form1"].submit();
            }
            function checked2()
            {
                window.document.forms["form2"].submit();
            }
        </script>
    </head>
    <body onload="checked2()">
        <%
            String sname = request.getParameter("subjectname");
            String sid = request.getParameter("subjectid");
            String MARKS = request.getParameter("selectmarks");
            System.out.println(MARKS);
            System.out.println(MARKS);
            if (sname == null) {
                sname = "";
            }
            System.out.println(sname);
            Connection con = conn.getConnectionObj();
            try {
                String subjectid = "";
                String subjectname = "";
                Statement st1 = con.createStatement();
                System.out.println("out of while loop");
        %>
        <form id="form1" name="form1" action="browseMarks.jsp" method="POST">     


            <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="80%"> 

                <th>Subject<br/><input type="text" name="subjname" id="subjname" class="style30" value="<%=sname%>" size="25" readonly="readonly" />  
                    <% session.setAttribute("subjname", sname);%>
                </th><th>Code<br/><input type="text" name="subjid" id="subjid" value="<%=sid%>" size="10" readonly="readonly" />    
                    <%  session.setAttribute("subjid", sid);%>
                </th>
                <th>Marks<br/><input type="text" name="selectmarks" style="width:150px" id="selectmarks" value="<%=MARKS%>" size="10" readonly="readonly" />    
                    <%  session.setAttribute("selectmarks", MARKS);%>
                </th>

                <% } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>

            <br/>
        </form>

        <%
            try {

                System.out.println("out of while loop");%>
        <form id="form2" action="Table1.jsp" method="POST">

            <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%">
                <tr>
                    <th><br/><input type="hidden" name="subjname" id="subjname1" value="<%=sname%>" size="25" readonly="readonly" />  
                        <% session.setAttribute("subjname", sname);%>
                    </th>
                    <th><br/><input type="hidden" name="subjid" id="subjid1" value="<%=sid%>" size="10" readonly="readonly" />    
                        <%  session.setAttribute("subjid", sid);%>
                    </th>
                    <th><br/><input type="hidden" name="selectmarks" id="selectmarks" value="<%=MARKS%>" size="10" readonly="readonly" />    
                        <%  session.setAttribute("selectmarks", MARKS);%>
                    </th>
                </tr>
            </table>
            <%     } catch (Exception e) {
                    // e.printStackTrace();
                } finally{
                    conn.closeConnection();
                    con = null ;
            }                 
           
            %>
            <br/><br/><br/>
         <%--   <center>
                <input type="hidden" id="text2" name="text" value="sunil"/>
         <%!  <% if (MARKS.equals("Internal_Major Marks")) {%>   
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <input type="radio" name="radio_1" onClick="checked2();"><b>Updated Online</b> 
                <%} else {%>

                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="radio_1" onClick="checked2();"><b>Update Online</b>
                <% }%>
         !%>
            </center>--%>
        </form>
    </body>
</html>
