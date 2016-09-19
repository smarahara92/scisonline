<%-- 
    Document   : ajax_active_batch
    Created on : 17 Mar, 2015, 10:58:55 AM
    Author     : nwlab
--%>

<%@page import = "java.sql.ResultSet"%>
<%@page import = "java.util.List"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "java.util.Collections"%>
<%@include file = "programmeRetrieveBeans.jsp" %>
<%
    String prg = request.getParameter("programme");
    ArrayList<Integer> years = new ArrayList<Integer>();
    try {
        ResultSet rs = scis.getActiveBatchs(prg);
        
        ResultSet rs1 = scis.getProgramme(prg, 1);
        while(rs1.next()) {
            System.out.println("111");
            String progName = rs1.getString(1);
            while(rs.next()) {
                int batch = rs.getInt(1);
                int currYear = scis.latestCurriculumYear(progName, batch);
                int year = rs.getInt(2);
                String query = "select Semester from "+ progName.replace('-', '_')+"_" +currYear+ "_curriculum where Type = 'P'";
                ResultSet rs2 = scis.executeQuery(query);
                System.out.println(query);
                if(rs2 == null) {
                    System.out.println("A");
                    return;
                }
                if(!rs2.next()) {
                    System.out.println("B");
                    return;
                }
                int year1 = (1 + scis.roman2num(rs2.getString(1))) / 2;
                if(year1 == year) {
                    if(!years.contains(batch)){
                        years.add(batch);
                    }
                }
            }
            rs.beforeFirst();
        }
        %>
        <option style=" alignment-adjust: central" value="">Select Year</option>
<%
        if(years.isEmpty()) {
            String msg = "None of the active batches from " +prg+ " have projects in this semester";
            %>
            <script>
                alert("<%=msg%>");
            </script>
<%
            return;
        }
        Collections.sort(years);
        
        for(int i : years) {
%>
            <option value="<%=i%>" ><%=i%></option>
<%
        }
    } catch(Exception e) {
        System.out.println(e);
    }
    scis.close();
%>