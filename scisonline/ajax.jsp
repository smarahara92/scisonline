<%-- 
    Document   : ajax
    Created on : Mar 28, 2014, 11:42:33 AM
    Author     : veeru
--%>

<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@ include file="id_parser.jsp" %>

<%    //System.out.println("//////in ajax code for deletesubject test");
    String choise = request.getParameter("choice");

    /*
     * ajax for delete faculty....
     */
    if (choise.equalsIgnoreCase("1")) {

        String studId = request.getParameter("stuId");
        System.out.println(studId);

        Calendar now = Calendar.getInstance();
        int month = now.get(Calendar.MONTH) + 1;
        int year = now.get(Calendar.YEAR);
       

        Statement st = con.createStatement();
        try {
            ResultSet rs1 = (ResultSet) st.executeQuery("select * from Temp_Reassign_Mtech_MCA_Student_" + year + " where StudentId='" + studId + "'");

            if (rs1.next()) {
                
%>
1
<%
} else {
               
                
%>
2
<%
    }
} catch (Exception e) {
%>
2
<%
        }

    }

    /*
     *................
     */

%>