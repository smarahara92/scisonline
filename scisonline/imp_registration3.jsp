<%-- 
    Document   : imp_registration3
    Created on : May 23, 2013, 5:16:43 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="connectionBean.jsp" %>
<%@page import ="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
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
        Connection con = conn.getConnectionObj();
        try{
            HashMap hm = new HashMap(); 
           String studentid=request.getParameter("studentid");
           String noofsub=request.getParameter("noofsub");
           String choosensub[]=request.getParameterValues("sub");
           int i=0;
           
           
           Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int cyear=now.get(Calendar.YEAR);
    String semester;
    if(month<=6)
          {
           semester="Monsoon";
           cyear = cyear-1;
           
           }
    else
         { 
          semester="Winter";
         }
           
           Statement st1=con.createStatement();
           Statement st2=con.createStatement();
           Statement st3=con.createStatement();
         ResultSet rs1=st1.executeQuery("select * from  imp_"+semester+"_"+cyear+" where studentId='"+studentid+"'");
         if(rs1.next()==true)
          {
            st2.executeUpdate("delete  from imp_"+semester+"_"+cyear+" where studentId='"+studentid+"'");
            st2.executeUpdate("insert into imp_"+semester+"_"+cyear+"(studentId) values('"+studentid+"')");
            i=0;
            int j=1;
            while(i<Integer.parseInt(noofsub))
             {
               if(choosensub[i].equals("none")!=true)
               {
                st2.executeUpdate("update imp_"+semester+"_"+cyear+" set coursename"+j+"='"+choosensub[i]+"' where studentId='"+studentid+"'");
                //**********************************************
                ResultSet rs3=st3.executeQuery("select * from subjecttable where Code='"+choosensub[i]+"'");
                rs3.next();
                if(hm.containsKey(studentid)==true)
                {
                     String x=(String)hm.get(studentid);
                     x=x+" ,"+rs3.getString(2)+"";
                     hm.put(studentid,x);
                }
               else
                {   
                   hm.put(studentid,rs3.getString(2));
                }
                
                
                //*********************************************
                j++;
               }
               i++;
             }
            
          }
         else
           {
             st2.executeUpdate("insert into imp_"+semester+"_"+cyear+"(studentId) values('"+studentid+"')");
             i=0;
            int j=1;
            while(i<Integer.parseInt(noofsub))
             {
               if(choosensub[i].equals("none")!=true)
               {
                st2.executeUpdate("update imp_"+semester+"_"+cyear+" set coursename"+j+"='"+choosensub[i]+"' where studentId='"+studentid+"'");
                //**********************************************
                ResultSet rs3=st3.executeQuery("select * from subjecttable where Code='"+choosensub[i]+"'");
                rs3.next();
                if(hm.containsKey(studentid)==true)
                {
                     String x=(String)hm.get(studentid);
                     x=x+" ,"+rs3.getString(2)+"";
                     hm.put(studentid,x);
                }
               else
                {   
                   hm.put(studentid,rs3.getString(2));
                }
                
                
                //*********************************************
                j++;
               }
               i++;
             }
           }
          
      %>    <center>
                <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>improvement registration</b></center> 
         </br>
          
        
        <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
        <tr>
            
            <th>Student ID</th>
            <th>Registered Subjects</th>
          </tr>
          
          <%
Set set = hm.entrySet();
Iterator it = set.iterator();
while(it.hasNext()) 
 {
    Map.Entry me = (Map.Entry)it.next(); 
    %>
    <tr>
        <td><%=me.getKey()%></td>
        <td><%=me.getValue()%></td>
    </tr>
    
    
    <%
    
 }
        
        %>
       </br>
    </br>
   <table align="center" cellspacing="20"><tr><td><div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
</div>
        </td>
   </table>  
       
    </body>
</html>
<%}catch (Exception e) {
                out.println(e);
            } finally{
              conn.closeConnection();
              con = null;
        }

%>
