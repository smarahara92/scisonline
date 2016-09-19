<%-- 
    Document   : ajax_studentlist
    Created on : Apr 28, 2015, 12:43:56 PM
    Author     : richa
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String prg = request.getParameter("programme");
    String batch = request.getParameter("batch");
%>
    <option style=" alignment-adjust: central" value="">Select Student ID</option>
<%
    try {
        ResultSet rss = scis.studentList(prg, batch);
        while(rss.next()) {
%>
            <option value="<%=rss.getString(1)%>"><%=rss.getString(1)%></option>
<%            
        }
    } catch(Exception e) {
        System.out.println(e);
    }
   // scis.close();
%>