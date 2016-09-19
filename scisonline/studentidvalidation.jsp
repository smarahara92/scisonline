<%-- 
    Document   : studentidvalidation
    Created on : Mar 4, 2014, 4:42:27 PM
    Author     : veeru
--%>
<%@ include file="dbconnection.jsp" %>
<%@ include file="id_parser.jsp" %>

<%
    String programmeName = null;
    String PROGRAMME_NAME = null;
    String year = null;
    String studentId = request.getParameter("stuid");
    programmeName = request.getParameter("stream");

    try { //validating student id for adding student.


        PROGRAMME_NAME = studentId.substring(SPRGM_PREFIX, EPRGM_PREFIX);
        String BATCH_YEAR = studentId.substring(SYEAR_PREFIX, EYEAR_PREFIX);
        year = "20" + BATCH_YEAR;
    } catch (Exception e) {
%>
5
<% return;
    }
    Statement st = con.createStatement();
    Statement st1 = con.createStatement();
    System.out.println(programmeName);



    ResultSet rs = st.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
    if (rs.next()) {

        if (rs.getString(1).equalsIgnoreCase(programmeName)) {

            String table = rs.getString(1).replace('-', '_') + "_" + year;
            ResultSet rs1 = st1.executeQuery("select * from " + table + " where studentId='" + studentId + "'");
            if (rs1.next()) {//Duplicate entry
%>
1
<%    }

} else {//Invalid student id for Programme.
%>
2
<%                }

} else {//Invalid Student id.
%>
3            
<%    }


%>