<%-- 
    Document   : attmodify4
    Created on : 21 Nov, 2012, 4:58:03 AM
    Author     : laxman
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file="dbconnection.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="javascript" src="print.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
          
    @media print {
       
        .noPrint
        {
            display:none;
        }
    }
    </style>
    </head>
    <body>
        <%
       
        String[] ItemNames = request.getParameterValues("student");
        Statement stat1=con.createStatement();
        Statement stat2=con.createStatement();
        Statement stat3=con.createStatement();
        Statement stat4=con.createStatement();
        Statement stat5=con.createStatement();
         Statement stat6=con.createStatement();
        String year=request.getParameter("year");
        String semester=request.getParameter("semester");
        String subjectName=request.getParameter("subjname");
        String subjectId=request.getParameter("subjid"); 
        String pmc=request.getParameter("pmc");
        String mmc=request.getParameter("mmc");         
        String columnname=(String)session.getAttribute("columnname");
        int value=(Integer)session.getAttribute("value");
        String from=columnname.substring(0,10);
        String to=columnname.substring(12);
        System.out.println(year);
        System.out.println(semester);
        System.out.println(subjectName);
        System.out.println(subjectId);                                                      
        System.out.println(pmc);
        System.out.println(mmc +"  lllll  "+columnname+"  kkkkkk "+mmc+" lllllllllll "+value);
          
          
          String qry1="select cumatten from subject_attendance_"+semester+"_"+year+" where subjectId='"+subjectId+"'";
          ResultSet rs2=stat1.executeQuery(qry1);
        rs2.next();
        int cumatten=rs2.getInt(1);
        int w=Integer.parseInt(mmc)-Integer.parseInt(pmc);
        cumatten=cumatten+w;
        String qry2="update subject_attendance_"+semester+"_"+year+" set  cumatten="+cumatten+",col"+value+"="+mmc+" where subjectId='"+subjectId+"'";
        stat1.executeUpdate(qry2);
   
          String qry3="select StudentId,StudentName,cumatten,"+columnname+" from "+semester+"_"+year+"_"+subjectId+" ";            
          ResultSet rs3=stat2.executeQuery(qry3);
            while(rs3.next())
            {
                 String qry4="update "+semester+"_"+year+"_"+subjectId+" set cumatten="+(rs3.getInt(3)-rs3.getInt(4))+" where StudentId='"+rs3.getString(1)+"' ";
                        stat1.executeUpdate(qry4);    
            }
         /* String qry9="select cumatten from subject_attendance_"+semester+"_"+year+" where subjectId='"+subjectId+"'";
          ResultSet rs9=stat5.executeQuery(qry9);
          rs9.next();
          int r=rs9.getInt(1);*/
           String qry4="select StudentId,StudentName,cumatten,"+columnname+" from "+semester+"_"+year+"_"+subjectId+" ";            
          ResultSet rs4=stat3.executeQuery(qry3);
          int k=0;
          while(rs4.next())
            {
              String qry16="update "+semester+"_"+year+"_"+subjectId+" set cumatten="+(Integer.parseInt(ItemNames[k])+rs4.getInt(3))+" where StudentId='"+rs4.getString(1)+"' ";
                        stat1.executeUpdate(qry16);     
                
               String qry="update "+semester+"_"+year+"_"+subjectId+" set "+columnname+"="+Integer.parseInt(ItemNames[k])+" where StudentId='"+rs4.getString(1)+"' ";//set cumatten=cumatten+ItemName1[k]
                       stat1.executeUpdate(qry);
                       k++;
              
            
       }
        String qry9="select StudentId,cumatten,"+columnname+" from "+semester+"_"+year+"_"+subjectId+" ";            
          ResultSet rs9=stat5.executeQuery(qry9);
        
            while(rs9.next())
            {
                 int g=rs9.getInt(2);
                 float v=(float)g/cumatten;
                 v=v*100;
                 String qry10="update "+semester+"_"+year+"_"+subjectId+" set percentage="+v+" where StudentId='"+rs9.getString(1)+"' ";//set cumatten=cumatten+ItemName1[k]
                       stat6.executeUpdate(qry10);
            }
         %>
          <table align="center" border="0"  cellspacing="5" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%">
            <tr>
                <th>Year<br/><input type="text" name="year" value="<%=year%>" size="10" readonly="readonly" /></th>
                
                <th>From<br/><input type="text" name="from" value="<%=from%>" size="20"  readonly="readonly"/></th>
                <th>To<br/><input type="text" name="from" value="<%=to%>" size="20"  readonly="readonly"/></th>
                
                <th>Semester<br/><input type="text" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></th>
                
          
   
                            
                                               
                <th>Subject<br/><input type="text" name="subjname" value="<%=subjectName%>" size="25" readonly="readonly" />                    
                </th>
                
                <th>Code<br/><input type="text" name="subjid" value="<%=subjectId%>" size="10" readonly="readonly" />                            
               
                <th>Total Classes<br/><input type="text" name="ca" value="<%=mmc%>" size="10" readonly="readonly" />                            
                </th>
            </tr>
            
                </table>      
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <table border="1" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <th  align ="center">Student Id </th>
                <th  width="300" align ="center">Student name</th>
                <th   align ="center" >Attended Classes</th>
                 <th   align ="center" >Percentage</th>
               
            </tr>
            <%
               String qry7="select StudentId,StudentName,"+columnname+" from "+semester+"_"+year+"_"+subjectId+" ";            
               ResultSet rs7=stat4.executeQuery(qry7);
               while(rs7.next())
               {
                     int e=Integer.parseInt(mmc);
                     float m=(float)rs7.getInt(3)/e;
                     m=m*100;
                    %>
                   <tr>
                <td  align ="center"><%=rs7.getString(1)%> </td>
                <td  align ="center"><%=rs7.getString(2)%></td>
                <td   align ="center" ><%=rs7.getInt(3)%></td>
                 <td   align ="center" ><%=m%></td>
                
            </tr>   
               <%
               }
            %>
            </table>
            <div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
</div>
    </body>
</html>