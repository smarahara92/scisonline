<%-- 
    Document   : allocatedrc3
    Created on : Jun 12, 2013, 11:10:12 PM
    Author     : root
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%--<%@page import="java.sql.Date"%>--%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser.jsp"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        try{
           Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           //int cyear=now.get(Calendar.YEAR); 
           String studentid=request.getParameter("studentid");
           String studentname=request.getParameter("studentname");
           String area=request.getParameter("area");
           String title=request.getParameter("title");
           String status=request.getParameter("status");
           String date=request.getParameter("startdate");
           String progress=request.getParameter("progress");
           String suggestions=request.getParameter("sugestions");
           
           
           
           Statement st1=con2.createStatement();
           Statement st2=con2.createStatement();
           Statement st3=con2.createStatement();
           Statement st_snam=con2.createStatement(); 
           
           int   BATCH_YEAR  =Integer.parseInt( CENTURY+studentid.substring(SYEAR_PREFIX,EYEAR_PREFIX));
           ResultSet rs1=st1.executeQuery("select * from drcreports_"+BATCH_YEAR+" where StudentId='"+studentid+"'");
//           ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+BATCH_YEAR+" where StudentId='"+rs1.getString(1)+"'");
//           rs_sname.next();
           String lastdate="";
           if(rs1.next()==true)
           {
            int j=1;
            int i=1;
            while(j<=12)
            {
              if(rs1.getString("date"+j)!=null)
               {
                lastdate=rs1.getString("date"+j);
                i++;
               }
              j++;
            }
            
            if(lastdate.equals(""))
            {
             try
             {
               st2.executeUpdate("update drcreports_"+BATCH_YEAR+" set date1='"+date+"',status1='"+status+"',progress1='"+progress+"',suggestions1='"+suggestions+"' where StudentId='"+studentid+"'");
             }
             catch(Exception e)
             {
               out.println("<center><h3>problem with input text</h3></center>");
               return;
             }
              //****************************************************
             %>           
              <center><b><%=UNIVERSITY_NAME%></b></center>
                <center><b><%=SCHOOL_NAME%></b></center>
                <center><b>Ph.D DRC Report</b></center>
                </br></br>
                 <table border="10" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                 <tr>
                <td align="center">Student Id</td>
                <td align="center">Student Name</td>
                <td align="center">Area of Research</td>
                <td align="center">Thesis Title</td>
                </tr>
                
                <tr> 
                <td align="center"><b><%=studentid%></b></td>
                <td align="center"><b><%=studentname%></b></td>
                <td align="center"><b><%=area%></b></td>
                <td align="center"><b><%=title%></b></td>
                </tr>
                <tr></tr>
                <tr></tr>
                <tr>
                    <td align="center" colspan="2">Status</td>
                    <td align="center" colspan="2">Date</td>
                </tr>
                <tr>
                <td align="center" colspan="2">
                    <b><%=status%></b>
                </td> 
                <td colspan="2" align="center">
                    <b><%=date%></b>
                </td>
                </tr>
                 <tr></tr>
                <tr></tr>
                <tr>
                <td><b>Progress of Work</b></td>
                </tr>
            
                <tr>
                <td align="center" colspan="4">
                   <%=progress%>
                </td>
                </tr>
                 <tr></tr>
                <tr></tr>
                <tr>
                <td><b>Suggestions</b></td>
                </tr>
            
                <tr>
                <td align="center" colspan="4">
                    <%=suggestions%>
                </td>
                </tr>
                 
                </table>
                <%
             
             
             //*********************************************************
            
            }
            else
            {
                 //************************************************************
                   try{
 
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        	Date date1 = (Date)sdf.parse(date);
        	Date date2 = (Date)sdf.parse(lastdate);
               // out.println(i);
        	System.out.println(sdf.format(date1));
        	System.out.println(sdf.format(date2));
 
        	if(date1.compareTo(date2)>0)
                         {
        		System.out.println("Date1 is after Date2");
        	          }
                else if(date1.compareTo(date2)<0)
                        {
        		System.out.println("Date1 is before Date2");
                        throw new Exception();
        	        }
                 else if(date1.compareTo(date2)==0)
                        {
        		System.out.println("Date1 is equal to Date2");
                        throw new Exception();
        	        }
                j++;
                try
                {
                st2.executeUpdate("update drcreports_"+BATCH_YEAR+" set date"+i+"='"+date+"',status"+i+"='"+status+"',progress"+i+"='"+progress+"',suggestions"+i+"='"+suggestions+"' where StudentId='"+studentid+"'");  
                }
                catch(Exception e)
                {
                out.println("<center>"+e+"</center>");
                // out.println("<center><h3>problem with input text</h3></center>");
               return;
                }
                %>
                <center><b>University of Hyderabad</b></center>
                <center><b>School of Computer and Information Sciences</b></center>
                <center><b>Ph.D DRC Report</b></center>
                </br></br>
                 <table border="10" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                 <tr>
                <td align="center">Student Id</td>
                <td align="center">Student Name</td>
                <td align="center">Area of Research</td>
                <td align="center">Thesis Title</td>
                </tr>
                
                <tr> 
                <td align="center"><b><%=studentid%></b></td>
                <td align="center"><b><%=studentname%></b></td>
                <td align="center"><b><%=area%></b></td>
                <td align="center"><b>
            <%  if(title == null) {
                } else { %>
                    <%=title%></b>
            <%    }
            %>
                </td>
                </tr>
                <tr></tr>
                <tr></tr>
                <tr>
                    <td align="center" colspan="2">Status</td>
                    <td align="center" colspan="2">Date</td>
                </tr>
                <tr>
                <td align="center" colspan="2">
                    <b><%=status%></b>
                </td> 
                <td colspan="2" align="center">
                    <b><%=date%></b>
                </td>
                </tr>
                 <tr></tr>
                <tr></tr>
                <tr>
                <td><b>Progress of Work</b></td>
                </tr>
            
                <tr>
                <td align="center" colspan="4">
                   <%=progress%>
                </td>
                </tr>
                 <tr></tr>
                <tr></tr>
                <tr>
                <td><b>Suggestions</b></td>
                </tr>
            
                <tr>
                <td align="center" colspan="4">
                    <%=suggestions%>
                </td>
                </tr>
                 
                </table>
                <%
 

                                              
    	}
                     
        catch(Exception ex)
        {
    	     out.println("<center><h3>your entering date should be  next to the "+lastdate+"</h3></center>");
    	}


            }     //************************************************************                                                             
            
            }
           st1 = null;
           st2 = null;
           st3 = null;
           st_snam = null;
           rs1 = null;
              
        
                   
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
