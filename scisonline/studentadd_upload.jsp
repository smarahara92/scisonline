<%-- 
    Document   : studentadd_upload
--%>
<% response.setContentType("text/xml");%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>   
   <body>
        <%
            Connection con = conn.getConnectionObj();
            
            int v = 0;
            String stream = request.getParameter("stream");
            stream=stream.replace('-','_');
            String year = request.getParameter("year1");
            session.setAttribute("year_upload", year);
            session.setAttribute("pname_upload", stream);
            System.out.println(stream);
            System.out.println(year);

            DatabaseMetaData metadata = con.getMetaData();
            ResultSet resultSet;
            resultSet = metadata.getTables(null, null, "" + stream + "_" + year + "", null);
            if (resultSet.next()) {
                System.out.println("table exist");
                %>
                
                true
           
                <% } else{
            %>
            
            null
            
            <%}

        %>
        <%
        conn.closeConnection();
        con = null;
        %>

   </body>
   

