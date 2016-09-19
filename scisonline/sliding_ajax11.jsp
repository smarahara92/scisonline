<%-- 
    Document   : sliding_ajax11
    Created on : 17 Mar, 2014, 10:43:50 PM
    Author     : veeru
--%>


<%@ include file="dbconnection.jsp" %>
<%@ include file="id_parser.jsp" %>

<%    String programmeName = null;
    String PROGRAMME_NAME = null;
    String year = null;
    String studentId = request.getParameter("stuid");
    String id = request.getParameter("stuid");

    try { //validating student id for adding student.

        PROGRAMME_NAME = studentId.substring(SPRGM_PREFIX, EPRGM_PREFIX);
        String BATCH_YEAR = studentId.substring(SYEAR_PREFIX, EYEAR_PREFIX);
        year = "20" + BATCH_YEAR;
        System.out.println(year);
    } catch (Exception e) {
%>
5
<% return;
    }
    Statement st = con.createStatement();
    Statement st1 = con.createStatement();
    Statement st2 = con.createStatement();
    System.out.println(programmeName);

    ResultSet rs = st.executeQuery("select Programme_name,Programme_group from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
    if (rs.next()) {
        int flag = 0;
        for (int i = 0; i < 2; i++) {
            String table = rs.getString(1).replace('-', '_') + "_" + year;
            ResultSet rs1 = st1.executeQuery("select * from " + table + " where studentId='" + studentId + "'");
            if (rs1.next()) {//Duplicate entry
                flag++;
            }
            year = Integer.toString(Integer.parseInt(year) + 1);
        }
        if (flag == 0) {
%>
4
<%
    return;
} else {
%>

<select id="fpg<%=id%>" name="fname" onchange="check2(this)">
    <option value="-Programme-">-Programme-</option>
    <%     ResultSet rs11 = null;

        rs11 = st2.executeQuery("select Programme_name from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
        while (rs11.next()) {

            if (rs11.getString(1).equalsIgnoreCase(rs.getString(1))) {
    %>
    <option value="<%=rs11.getString(1)%>" selected="yes"><%=rs11.getString(1)%></option>

    <%} else {
    %>
    <option value="<%=rs11.getString(1)%>"><%=rs11.getString(1)%></option>
    <%
                }

            }
        }
    %>
</select>
<%
} else {//Invalid Student id.
%>
3            
<%}%>