<%-- 
    Document   : sliding_ajax2
    Created on : Mar 9, 2014, 7:17:49 PM
    Author     : veeru
--%>



<%@ include file="dbconnection.jsp" %>


<%
    String programmeName2 = null;
   
    String year = null;
    String programmeName1 = request.getParameter("stream1");
    programmeName2 = request.getParameter("stream2");


    Statement st = con.createStatement();
    Statement st1 = con.createStatement();


System.out.println(programmeName1);
System.out.println(programmeName2);

    ResultSet rs = st.executeQuery("select Programme_group from programme_table where Programme_name='" + programmeName2 + "'");
    ResultSet rs2 = st1.executeQuery("select Programme_group from programme_table where Programme_name='" + programmeName1 + "'");
    if (rs.next()) {
        if (rs2.next()) {
            System.out.println("inside");

            if (rs.getString(1).replace('-', '_').equalsIgnoreCase(rs2.getString(1).replace('-', '_'))) {
%>
1
<%    }else{
            
            %>
2
<%
            }
        }
    }
%>