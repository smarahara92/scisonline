<%-- 
    Document   : sem-duration-stroing
--%>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="#CCFFFF">
<%
        Connection con = conn.getConnectionObj();
        
        String current_session = request.getParameter("current_session");
        String given_session = request.getParameter("current_session");
        String given_year = request.getParameter("given_year");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        Statement st1 = (Statement) con.createStatement();
        System.out.println(startdate + "   " + enddate);
%> 
        <%-- for Testing
            <%=current_session%>
            <%=startdate%>
            <%=enddate%>
            given session <%=request.getParameter("current_session")%>
            given year  <%=request.getParameter("given_year")%>
        --%>
<%
        if (startdate.equals("") == false && enddate.equals("") == false) {
            int sy = Integer.parseInt(startdate.substring(0, 4));
            int ey = Integer.parseInt(enddate.substring(0, 4));
            int sm = Integer.parseInt(startdate.substring(5, 7));
            int em = Integer.parseInt(enddate.substring(5, 7));
            int sd = Integer.parseInt(startdate.substring(8, 10));
            int ed = Integer.parseInt(enddate.substring(8, 10));
            if (sy <= ey) {
                if (sy == ey) {
                    if (sm >= em) {
                        if (sm == em && sd < ed) {
                            st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                            st1.executeUpdate("insert into session values('" + current_session + "','" + startdate + "','" + enddate + "')");
                            //st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
                            //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                            //st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                            //session.setAttribute("current_session",current_session);
                            //  response.sendRedirect("session_test.jsp");
                            //response.sendRedirect("session_test.jsp?current_session=" + current_session);
                            response.sendRedirect("sub-faconline_new.jsp?given_session=" + current_session + "&given_year=" + given_year);
                            //response.sendRedirect("nextPage.jsp?Name="+name "&Age="+age "&Sal="+sal);  template
                        } else {
%>
                            <script>
                                alert(" If same year  then start month should be less than end month OR If same year and same month then start date should be less than end" );
                            </script>
                            <jsp:forward page="sem-duration_old.jsp">
                                <jsp:param name="status" value="error1" ></jsp:param>
                                <jsp:param name="current_session" value="<%=current_session%>"></jsp:param>
                                <jsp:param name="year2" value="<%=given_year%>" ></jsp:param>
                            </jsp:forward>
<%
                            //   NOTE Both currnt_session, given_contains same values.
                            // sending seesin, year to sem-duration_old. so u should take care the varible names at that place.
                            // response.sendRedirect("sem-duration_old.jsp?current_session="+current_session +"&year2="+sy );
                        }
                    } else {
                        //st1.executeUpdate("drop table if exists session");
                        st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                        st1.executeUpdate("insert into session values('" + current_session + "','" + startdate + "','" + enddate + "')");
                        //st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
                        //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                        //st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                        //  session.setAttribute("current_session",current_session);
                        //response.sendRedirect("session_test.jsp");
                        response.sendRedirect("sub-faconline_new.jsp?given_session=" + current_session + "&given_year=" + given_year);
                    }
                } else {
                    // st1.executeUpdate("drop table if exists session");
                    st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                    st1.executeUpdate("insert into session values('" + current_session + "','" + startdate + "','" + enddate + "')");
                    // st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
                    //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                    //   st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                    // session.setAttribute("current_session",current_session);
                    //response.sendRedirect("session_test.jsp?");
                    response.sendRedirect("sub-faconline_new.jsp?given_session=" + current_session + "&given_year=" + sy);
                }
            } else {
%>
                <script>
                    alert(" End year must be greater than or equal to start." ); // it wont work for send, redirect jps tags
    //          </script>
                <jsp:forward page="sem-duration_old.jsp">
                    <jsp:param name="current_session" value="<%=current_session%>"></jsp:param>
                    <jsp:param name="year2" value="<%=given_year%>" ></jsp:param>
                    <jsp:param name="status" value="error2" ></jsp:param>
                </jsp:forward>
<%
                // sending seesin, year to sem-duration_old. so u should take care the varible names at that place.
                //  response.sendRedirect("sem-duration_old.jsp?current_session="+current_session +"&year2="+sy );
            }
        } else {
%>
            <script>
                alert(" Start and end dates should not be empty" );
                //alert(" we are going to some other page" );
            </script>
            <jsp:forward page="sem-duration_old.jsp">
                <jsp:param name="current_session" value="<%=current_session%>"></jsp:param>
                <jsp:param name="year2" value="<%=given_year%>" ></jsp:param>
                <jsp:param name="status" value="error3" ></jsp:param> 
            </jsp:forward>
<%
            /// the fallowing sending values using sendRedirect() which should be used for link some other domain pages, like google.com
            // sending seesin, year to sem-duration_old. so u should take care the varible names at that place.
            // response.sendRedirect("sub-faconline.jsp?current_session="+given_session +"&year2="+given_year );
        }
%>
        <%
        st1.close();
        conn.closeConnection();
        con = null;
        %>
    </body>
</html>
