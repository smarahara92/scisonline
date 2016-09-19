<%-- 
    Document   : student_status_update1
    Created on : 30 Apr, 2014, 4:52:34 PM
    Author     : srinu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>  
<%@include file="programmeRetrieveBeans.jsp"%>   

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
    </head>

    <body>
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
                <td align="center" class="style31"><font size="6">PhD students status</font></td>
            </tr>
        </table>
        </br>
        </br>
        <script type="text/javascript">
            function disableEnterKey(e)
	{
	     var key;
	 
	     if(window.event)
	          key = window.event.keyCode;     //IE
	     else
          key = e.which;     //firefox
	 	
		//alert("helloi");
	     if(key === 13)
	          return false;
	     else
	          return true;
	}
        </script>
        <%
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
          //  if(month>=1 && month<=6){cyear--;}
            int gyear = cyear - 11; // since we have get the 11 years students

            Statement st3 = con2.createStatement();
            Statement st1 = con2.createStatement();
            Statement st2 = con.createStatement();
            Statement st_snam = con2.createStatement();


            // out.println(totalstudents);
        %>
        <form name="frm" action="student_status_update2.jsp"  method="POST" >
            <table border="1" cellspacing="2" cellpadding="1" align="center">
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Status</th>

                </tr>

                <%
                    int totalstudents = 0;
                    DatabaseMetaData md = con2.getMetaData();
                    for (int k = gyear; k <= cyear; k++) {
                        ResultSet rs = md.getTables(null, null, "PhD_" + k, null);
                        if ((rs.next())) {
                            System.out.println("done");
                            System.out.println("PhD_" + k);
                            // System.out.println("PhD_" + k);

                            ResultSet rs1 = st1.executeQuery("select * from PhD_" + k + "");
                            int i = 1;
                            ResultSet rs3 = st3.executeQuery("select count(*) from PhD_" + k + "");

                            if (rs3.next() == true) {
                                totalstudents = totalstudents + Integer.parseInt(rs3.getString(1));
                            }
                            
                            while (rs1.next()) {
                                //System.out.println("students are present");
                                ResultSet rs_new=scis.getstatus();
                                ResultSet rs_sname = st_snam.executeQuery("select * from  PhD_Student_info_" + k + " where StudentId='" + rs1.getString(1) + "'");
                                rs_sname.next();

                %>
                <tr>
                    <td><input type="text" id="id<%=i%>" name="id" style="width:100px"value="<%=rs1.getString(1)%>" readonly  onKeyPress="return disableEnterKey(event)"></td>
                    <td align="center"><input type="text" id="name<%=i%>" name="name" style="width:200px"value="<%=rs_sname.getString(2)%>" readonly  onKeyPress="return disableEnterKey(event)"></td>
                    <td align="center">
                        <select style="width:150px" id="status<%=i%>" name="status">
                    <%       while(rs_new.next()) {
                                if(rs1.getString("status").equalsIgnoreCase(rs_new.getString(1))) { %>
                                    <option value="<%=rs_new.getString(1)%>" selected="selected"><%=rs_new.getString(2)%></option>
                    <%          } else {
                    %>              <option value="<%=rs_new.getString(1)%>"><%=rs_new.getString(2)%></option>
                    <%            }
                             }   %>
                        </select>
                        </br>
                    </td>
                </tr>
                        <%
                            
                            }
                                }
                            }
                            try {
                                st1.close();
                                st2.close();
                                st3.close();
                                st_snam.close();
                                scis.close_phd();
                            }
                            catch(Exception e){
                                System.out.println(e);
                            }
                            finally{
                                con.close();
                                con2.close();
                            }
                        %>
            </table>
            <input type="hidden" name="noofstudents" value="<%=totalstudents%>"><br><br>

            <center> <input type="submit" name="submit" value="submit"></center>
        </form>
    </body>
</html>