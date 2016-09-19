<%-- 
    Document   : drc_membership1
    Created on : Jun 5, 2013, 10:12:37 PM
    Author     : root
--%>

<%@page import="com.sun.org.apache.xerces.internal.parsers.IntegratedParserConfiguration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>  
<%@include file="university-school-info.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <center><b><%=UNIVERSITY_NAME%></b></center>
         <center><b><%=SCHOOL_NAME%></b></center>
        <center><b>Ph.D. DRC Membership</b></center>
        </br></br>
       <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
       
     <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Area of Research</th>
        <th>DRC Member1</th>
        <th>DRC Member2</th>
     </tr>
        <%  
            try {
                Calendar now = Calendar.getInstance();
                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month=now.get(Calendar.MONTH)+1;
                int cyear=now.get(Calendar.YEAR); 
                if(month>=1 && month<=6){cyear--;}
                String totalstudents=request.getParameter("totalstudents");
                String id[]=request.getParameterValues("id");
                String name[]=request.getParameterValues("name");
                String area[]=request.getParameterValues("area");
                String drc1[]=request.getParameterValues("drc1"); 
                String drc2[]=request.getParameterValues("drc2");  
                Statement st1=con2.createStatement();
                int i=0;
                int j=0;
                for(i=0;i<Integer.parseInt(totalstudents);i++)
                {
        %>
                    <tr>
                    <td><%=id[i]%></td>
                    <td><%=name[i]%></td>
                    <%
                        if(area[i].equals("")!=true)
                        {
                            if(area[i].equals("NOT APPLICABLE")!=true)
                            {
                                %><td><%=area[i]%></td><%
                                System.out.println(drc1[j]+drc2[j]);
                                st1.executeUpdate("update PhD_"+cyear+" set areaofresearch='"+area[i]+"' where StudentId='"+id[i]+"'");
                                 if(drc1[j].equals("none"))
                                 {
                                    st1.executeUpdate("update PhD_"+cyear+" set drc1=null where StudentId='"+id[i]+"'");
                    %><td></td><%
                                 }
                                else
                                {
                                    st1.executeUpdate("update PhD_"+cyear+" set drc1='"+drc1[j]+"' where StudentId='"+id[i]+"'");
                                    %><td><%=drc1[j]%></td><%
                                }
                                if(drc2[j].equals("none"))
                                {
                                    st1.executeUpdate("update PhD_"+cyear+" set drc2=null where StudentId='"+id[i]+"'");
                     %><td></td><%
                                }
                                else
                                {
                                    st1.executeUpdate("update PhD_"+cyear+" set drc2='"+drc2[j]+"' where StudentId='"+id[i]+"'");
                    %><td><%=drc2[j]%></td><%
                                }
                                st1.executeUpdate("update PhD_"+cyear+" set status='A' where StudentId='"+id[i]+"'");
                          
                            j++; 
                            }
                            else
                            {
                    %><td></td>
                    <td></td>
                    <td></td><%
                                st1.executeUpdate("update PhD_"+cyear+" set areaofresearch=null,drc1=null,drc2=null where StudentId='"+id[i]+"'");
                            }
                        }
                     else
                    {
                 %><td></td>
                    <td></td>
                    <td></td><%
                        j++;
                        st1.executeUpdate("update PhD_"+cyear+" set areaofresearch=null,drc1=null,drc2=null where StudentId='"+id[i]+"'");
                        // st1.executeUpdate("update PhD_"+cyear+" set status='NR' where StudentId='"+id[i]+"'");
                    }
              
                 %></tr><%
            }
             st1 = null;
          }
         catch(Exception e){
            System.out.println(e);
         }
        finally{
            con.close();
            //con1.close();
            con2.close();
         }   
                                                                                 
        %>                      
    </body>
</html>
