<%-- 
    Document   : allocatedrc1
    Created on : Jun 9, 2013, 10:29:04 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function find()
            {
                
                document.form1.submit();
            }
        </script>
    </head>
    <body>
        <%
        try {
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            int gyear=cyear-11; // since we have get the 11 years students
            System.out.println("lllll");
            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            String user = (String) session.getAttribute("user");
        %>  <form name="form1" action="allocatedrc2.jsp" target="staffaction" method="POST">
                <center><b>Select Student:  </b><select  style="width:170px" name="studentid" onchange="find()">
                    <option value="none">None</option> 
                    <%
                        DatabaseMetaData md = con2.getMetaData();
                        for(int k=gyear;k<=cyear;k++){
                            ResultSet rs = md.getTables(null, null, "PhD_"+k , null);
                            if ((rs.next())) {
                                System.out.println("done");
                                System.out.println("PhD_"+k);
                                ResultSet rs1=null;
                                if(user.equalsIgnoreCase("staff")){
                                     rs1 = st1.executeQuery("select * from PhD_" +k + " where status !='G' ");
                                }
                                else{
                                    rs1 = st1.executeQuery("select * from PhD_" +k + " where supervisor1='" + user + "' or supervisor2='" + user + "' or supervisor3='" + user + "' and status !='G'");
                                }
                                while (rs1.next()) {
                                     System.out.println("done2");
                                    %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option><%
                        //rs1 = null;
                                }
                            }
                        rs = null;
                        }
                    %>                           

                </select> </center> 
                <%
                st1 = null;
                st2 = null;
                st3 = null;
                        
            }
            catch(Exception e){
                System.out.println(e);
            }
        finally{
            con.close();
            con2.close();
         }
                %>
        </form>  
    </body>
</html>

