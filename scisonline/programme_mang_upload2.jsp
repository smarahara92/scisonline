<%-- 
    Document   : cFile
    Created on : Mar 8, 2012, 9:49:00 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.net.ntp.TimeInfo"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.*"%>
<%@page import="org.apache.commons.net.ntp.NTPUDPClient"%>

<%@include file="dbconnection.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <%            try {
                int i, j = 4;
                Calendar now = Calendar.getInstance();
                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);
                if(month<=6){
                cyear=cyear-1;
                }
                cyear=cyear;

                Statement st1 = con.createStatement();
//                ResultSet rs = st1.executeQuery("select start from session where name='Monsoon'");


                /*
                 *get current date time with Date()
                 */
                Date date = new Date();
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String CurrentDate = dateFormat.format(date);
                System.out.println(CurrentDate);
                Date date1 = dateFormat.parse(CurrentDate);

                DateFormat dateFormat1 = new SimpleDateFormat("yyyy");

//                
//                rs.next();
//     Date date2 = rs.getDate(1);
//               String SessionYear=dateFormat1.format(date2);
//               int SessionYear1=Integer.parseInt(SessionYear);
//               System.out.println("jjjjjjjjjjjjjjjjjjj"+SessionYear);
//               //if(SessionYear1==cyear){ 
//               if (date1.compareTo(date2) > 0) {
//                    cyear += 1;
//                    j--;
//                }
                //  }
                ResultSet rs1 = null;
                rs1 = scis.getProgramme(1);
        %>
        <form action="Commonsfileuploadservlet1" enctype="multipart/form-data" method="POST">
            <input type="hidden" name="check" value="7" />
            <table align="center" border="0" cellpadding="5" cellspacing="5">
                <tr> 
                <caption> <h2>Update Curriculum</h2><caption> 
                        </tr>
                        <tr><td><select name="text1" style="width:200px;">
                                    <%while (rs1.next()) {%>
                                    <option><%=rs1.getString(1)%></option>
                                    <%}%>
                                </select> 
                            </td>
                            <td> 
                                <select name="text2" id="year1" style="width:200px;">
                                    <%for (i = 1; i <= j; i++) {%>
                                    <option><%=cyear%></option>
                                    <% cyear++;
                                        }%>
                                </select> 
                                </select> 
                            </td> 
                        </tr>
                        <tr><td colspan="2" align="center"><input type="file" name="file1" />
                                <input type="Submit" value="Upload File"><br></td></tr>
                        </table>
                        </form>
                        <%
                            rs1.close();
                            st1.close();
                        } catch (Exception e) {%>
                        <script type="text/javascript">
                            alert("Add at least one programme");
                        </script> 
                        <%}%>
                        </body>


                        </html>
