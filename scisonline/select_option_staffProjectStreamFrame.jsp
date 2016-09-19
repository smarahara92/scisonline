<%-- 
    Document   : select_option_staffProjectStreamFrame
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <%
        String streamName = request.getParameter("stream");
        String streamYear = request.getParameter("batch");
        session.setAttribute("projectStreamName", streamName);
        session.setAttribute("projectStreamYear", streamYear);
    %>

    <frameset cols="21%,*" target="main">
        <frame src="select_option_staffProjectStream1.jsp" name="left" noresize="noresize"/>
        <frame name="act_area"/>
    </frameset>
</html>
