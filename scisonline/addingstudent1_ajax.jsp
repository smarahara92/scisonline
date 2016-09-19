<%-- 
    Document   : addingstudent1_ajax
--%>

<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@ include file="connectionBean.jsp" %>
<%@ include file="id_parser.jsp" %>

<%
    String programmeName = null;
    String PROGRAMME_NAME = null;
    String year = null;
    String studentId = request.getParameter("stuid");
    studentId = studentId.trim();
    studentId = studentId.toUpperCase();
    System.out.println("dev : " + studentId);
    if(studentId=="") {
        return;
    }

    try { //validating student id for adding student.
        PROGRAMME_NAME = studentId.substring(SPRGM_PREFIX, EPRGM_PREFIX);
        String BATCH_YEAR = studentId.substring(SYEAR_PREFIX, EYEAR_PREFIX);
        year = "20" + BATCH_YEAR;
    } catch (Exception e) {
%>
        5
<%
        return;
    }
    
    Connection con = conn.getConnectionObj();
    
    Statement st = con.createStatement();
    Statement st1 = con.createStatement();

    System.out.println(programmeName);

    ResultSet rs = st.executeQuery("select Programme_name,Programme_group from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
    if (rs.next()) {
        String table = rs.getString(1).replace('-', '_') + "_" + year;
        ResultSet rs1 = st1.executeQuery("select * from " + table + " where studentId='" + studentId + "'");
        if (!rs1.next()) {//Duplicate entry
%>
            <selection id="pg<%=studentId%>" name="pg">
                <option value="-Programme-">-Programme-</option>
                <option value="<%=rs.getString(1)%>" selected><%=rs.getString(1)%></option>
            </selection>
<%
        } else {
%>
            4
<%
        }
    } else {//Invalid Student id.
%>
        3            
<%
    }
    conn.closeConnection();
    con = null;
%>