<%-- 
    Document   : readmin
    Created on : Mar 14, 2012, 9:58:10 AM
    Author     : admin
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.util.*"%>
<%@page import="java.util.Calendar"%>
<%@include file="checkValidity.jsp"%>
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
            <style>
.style30{width:150px;color:#000000}
.style31 {color: white}
</style>
        <script>
          
            
           
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        
            <center>
                <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>List of students who have failed in atleast one subject</b></center>
                </br>
                </br>
            <%
             HashMap hm = new HashMap(); 
    HashMap hm1 = new HashMap(); 
             Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int cyear=now.get(Calendar.YEAR);
    String semester="";
    String year1="",year2="",year3="",syear="";
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
     Statement st4=con.createStatement();
    
    if(month<=6)
          {
           semester="Winter";
           }
    else
         { 
          semester="Monsoon";
         }
    
     if(semester.equals("Moonson"))
                 {
                    year1=Integer.toString(cyear);
                    year2=Integer.toString(cyear-1);  
                    year3=Integer.toString(cyear-2);  
                 }
               else
               {
                 year1=Integer.toString(cyear-1);
                 year2=Integer.toString(cyear-2);  
                  year3=Integer.toString(cyear-3);  
               }
    %> <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
        <tr>
            <th>Select</th>
            <th>Student ID</th>
            <th>Failed Subjects</th>
           
          </tr><%
      int j=0;
      int studentsem=0;
            while(j<3)
            {
            
            ResultSet rs1=null;
            if(j==0)
             {
             rs1=st1.executeQuery("select * from MCA_"+year1+"");
             if(semester.equals("Moonson"))
                 studentsem=2;
             else
                 studentsem=2;
             syear=year1;
             }
            else if(j==1)
             {
             rs1=st1.executeQuery("select * from MCA_"+year2+"");
             if(semester.equals("Moonson"))
                 studentsem=3;
             else
                 studentsem=4;
             syear=year2;
             }
            else if(j==2)
             {
             rs1=st1.executeQuery("select * from MCA_"+year3+"");
             if(semester.equals("Moonson"))
                 studentsem=5;
             else
                 studentsem=6;
             syear=year3;
             }
         
            while(rs1.next())
             {
            ResultSetMetaData rsmd = rs1.getMetaData();
            int noOfColumns = rsmd.getColumnCount();
            int temp=(noOfColumns-2)/2;
            int i=0;int count=0;
           
           
                  while(temp>0)
                   {
                       int m=i+3;
                       String F="F";
                       if(F.equals(rs1.getString(m+1)))
                         {
                            ResultSet rs11=st3.executeQuery("select Alias from MCA_curriculum where subjId='"+rs1.getString(m)+"'");
                             String subjectname=rs1.getString(m);
                             while(rs11.next())
                              {
                             if(rs11.getString(1)!=null)
                                 subjectname=rs11.getString(1);
                              }
                              String qry7="select Subject_Name from subjecttable where Code='"+subjectname+"'";
                              ResultSet rs7=st4.executeQuery(qry7);
                              rs7.next();
                              subjectname=rs7.getString(1);
                          if(hm.containsKey(rs1.getString(1))==true)
                           {
                             String x=(String)hm1.get(rs1.getString(1));
                             x=x+" ,"+subjectname+"";
                            // System.out.println(x);
                             hm1.put(rs1.getString(1),x);
                           }
                          else
                           {   
                             //System.out.println("llll");                                                                             
                             hm.put(rs1.getString(1),rs1.getString(2));
                             hm1.put(rs1.getString(1),subjectname);
                           }
                          
                         }
                     i=i+2;
                     temp--;
                   }
             
             } 
          j++;}      
      
      
      
      
      //*************************************************************************************************************
         int k=0;
         String stream="";
         while(k<3)
         {  
            if(k==0)
               stream="MTech_CS";   
            else if(k==1)
               stream="MTech_AI"; 
            else if(k==2)
               stream="MTech_IT";                                                                 
            j=0;
            while(j<2)
            {
            
            ResultSet rs1=null;
            if(j==0)
             {
             rs1=st1.executeQuery("select * from "+stream+"_"+year1+"");
             if(semester.equals("Moonson"))
                 studentsem=2;
             else
                 studentsem=2;
             syear=year1;
             }
            else if(j==1)
             {
             rs1=st1.executeQuery("select * from "+stream+"_"+year2+"");
             if(semester.equals("Moonson"))
                 studentsem=3;
             else
                 studentsem=3;
             syear=year2;
             }
             
            while(rs1.next())
             {
            ResultSetMetaData rsmd = rs1.getMetaData();
            int noOfColumns = rsmd.getColumnCount();
            int temp=(noOfColumns-2)/2;
            int i=0;int count=0;
           
                  while(temp>0)
                   {
                       int m=i+3;
                       String F="F";
                       if(F.equals(rs1.getString(m+1)))
                         {
                            ResultSet rs11=st3.executeQuery("select Alias from "+stream+"_curriculum where subjId='"+rs1.getString(m)+"'");
                             String subjectname=rs1.getString(m);
                             while(rs11.next())
                              {
                                // System.out.println(rs1.getString(1));
                             if(rs11.getString(1)!=null)
                                 subjectname=rs11.getString(1);
                              }
                              String qry7="select Subject_Name from subjecttable where Code='"+subjectname+"'";
                             // System.out.println(subjectname);
                             // System.out.println(rs1.getString(1));
                              ResultSet rs7=st4.executeQuery(qry7);
                              rs7.next();
                                subjectname=rs7.getString(1);
                           
                            if(hm.containsKey(rs1.getString(1))==true)
                           {
                             String x=(String)hm1.get(rs1.getString(1));
                             x=x+" ,"+subjectname+"";
                             hm1.put(rs1.getString(1),x);
                           }
                          else
                           {                                                   
                             hm.put(rs1.getString(1),rs1.getString(2));
                             hm1.put(rs1.getString(1),subjectname);
                           }
                         }
                     i=i+2;
                     temp--;
                   }
             
             } 
          j++;}      
      
      
       k++;}
      
      
      //*************************************************************************************************************
         Set set = hm.entrySet();
// Get an iterator
Iterator i = set.iterator();
// Display elements
while(i.hasNext()) 
 {
    Map.Entry me = (Map.Entry)i.next(); 
   %> <tr>
                 <td><%=me.getKey()%></td>
            <td><%=me.getValue()%></td>
            <td><%=hm1.get(me.getKey())%></td>
              </tr><%
}     
            %>
            
    </table>
    </br>
    </br>
   <table align="center" cellspacing="20"><tr><td><div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
</div>
        </td>
   </table>
            </center>
       
    </body>
</html>
