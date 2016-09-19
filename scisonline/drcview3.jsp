<%-- 
    Document   : drcview3
    Created on : Jun 13, 2013, 2:57:18 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser.jsp"%>   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .var_value
            {
                width: 50px;
                overflow: hidden;
            }

            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
        </style>
    </head>
    <body>
        <%
        // we will get the student id, and drc dates as input for this file
        try{
           Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           int cyear=now.get(Calendar.YEAR); 
           Statement st1=con2.createStatement();
           Statement st2=con2.createStatement();
           Statement st3=con2.createStatement();
           Statement st_snam=con2.createStatement();
           
           String studentid=request.getParameter("studentid");
           String date=request.getParameter("date");
           
           int   BATCH_YEAR  =Integer.parseInt( CENTURY+studentid.substring(SYEAR_PREFIX,EYEAR_PREFIX));
           ResultSet rs1=st1.executeQuery("select * from drcreports_"+BATCH_YEAR+" where StudentId='"+studentid+"'");
           ResultSet rs2=st2.executeQuery("select * from PhD_"+BATCH_YEAR+" where StudentId='"+studentid+"'");
           ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+BATCH_YEAR+" where StudentId='"+studentid+"'");
           rs_sname.next();
           
           if(rs1.next()==true&&rs2.next()==true)
           {
             int i=1;
             while(i<=12)
             {
              if(date.equals(rs1.getString("date"+i)))
              {
               %>           
              <center><b><%=UNIVERSITY_NAME %></b></center>
                <center><b><%=SCHOOL_NAME %></b></center>
                <center><b>Student Id : <font color="blue"><%=studentid%></font>               Student Name : <font color="blue"><%=rs_sname.getString(2)%></font></b></center>
                 <center><b>Area of Research : <font color="blue"><%=rs2.getString("areaofresearch")%></font></b></center>
                 <center><b>Thesis Title : <font color="blue"><%=rs2.getString("thesistitle")%></font></b></center>
                 <center><b>DRC Report Date : <font color="blue"><%=rs1.getString("date"+i)%></font></b></center>
                 </br>
                 </br>
                  <table border="5" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                      <tr>
                          <th>Progress of Work</th>
                      </tr>
                      <tr>
                          <td>
                            <%=rs1.getString("progress"+i)%>  
                          </td>
                      </tr>
                  </table>
                          
                          <BR>
                  <table border="5" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                      <tr>
                          <th>Suggestions</th>
                      </tr>
                      <tr>
                          <td>
                            <%=rs1.getString("suggestions"+i)%>  
                          </td>
                      </tr>
                  </table>
              <%
              break;
              }
              i++;
             }
           }
           
                st1 = null;
                st2 = null;
                st3 = null;
                st_snam = null;
                rs1 = null;
                rs_sname = null;
                rs2 = null;

        } 
        catch(Exception e){
            System.out.println(e);
        }
        finally {
            con2.close();
            con.close();
        }
       
        %>
        
        <br>
        <table width="100%" class="pos_fixed">
        <tr>
            <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
            </td>
        </tr>
    </table>
    </body>
</html>
