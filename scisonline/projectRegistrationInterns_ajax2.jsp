<%-- 
    Document   : projectRegistrationInterns_ajax2
    Created on : May 18, 2014, 6:24:08 PM
    Author     : veeru
--%>
<%@include file="programmeRetrieveBeans.jsp"%>


        <%
            System.out.println("@@@@@@@@@@@@@@@@q1");
            String check1 = (String)request.getParameter("check");
            System.out.println(check1);
            if (check1.equalsIgnoreCase("1")) {
                String streamName = request.getParameter("streamName");
                streamName = streamName.replace('-', '_');
                session.setAttribute("projectStreamName", streamName);
                System.out.println(session.getAttribute("projectStreamName"));
            } else if (check1.equalsIgnoreCase("2")) {

                String studentId = request.getParameter("studentId");
                int val = scis.isValidStudentId(studentId);
                if (val == 1) {
                    session.setAttribute("projectStudentId", studentId);
                    System.out.println(session.getAttribute("projectStudentId"));
                } else {
        %>
        1
        <%
                }
            }
        %>
    