<%-- 
    Document   : readminlink
    Created on : Mar 16, 2012, 10:22:26 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        //String studentid[]=request.getParameterValues("studentid");
        int flag=0;
        String status[]=request.getParameterValues("status1");
        if(status==null)
           {
              %>
              <script type="text/javascript" language="JavaScript">
              
               alert("choose atleast one student");
                window.location.replace("readmin.jsp");
               </script> 
               <%
           }
        else
         {
           int i=0;
           for(i=0;i<status.length;i++)
             {
           //****************************************************************************
               String stream="";
               status[i]=status[i].trim();
               status[i]=status[i].replace(" ","");
               String studentid=status[i].substring(0,8);
               String syear=status[i].substring(8);
               studentid=studentid.trim();
               syear=syear.trim();
               if(studentid.substring(4,6).equals("MT"))
                             stream="MTech_CS";
                    else if(studentid.substring(4,6).equals("MB"))
                             stream="MTech_IT";
                     else if(studentid.substring(4,6).equals("MI"))
                             stream="MTech_AI";
                     else
                         stream="MCA";
               // out.println(studentid+"    "+syear+"    "+stream);
                Statement st2=con.createStatement();
                ResultSet rs =st2.executeQuery("select * from "+stream+"_curriculum limit 1"); 
                int total=0;
                int core=0;
                int electives=0;
                int labs=0;
                int project=0;
                System.out.println("executed");
                 while(rs.next())
                  {
        
                   core=Integer.parseInt(rs.getString(1));
                   labs=Integer.parseInt(rs.getString(2));
                   project=Integer.parseInt(rs.getString(3));
                   electives=Integer.parseInt(rs.getString(4));
                   total=Integer.parseInt(rs.getString(1))+Integer.parseInt(rs.getString(2))+Integer.parseInt(rs.getString(3))+Integer.parseInt(rs.getString(4));
                  }
               // out.println(core+"    "+labs+"    "+project+"   "+electives);
                Statement st3=con.createStatement();
                Statement st4=con.createStatement();
                 Statement st5=con.createStatement();
                 Statement st6=con.createStatement();
                ResultSet rs3=st3.executeQuery("select * from "+stream+"_"+syear+" where StudentId='"+studentid+"'");
                try
                {
                while(rs3.next())
                 {
                   int yearfinding=Integer.parseInt(syear)+1;
                    st4.executeUpdate("insert into "+stream+"_"+yearfinding+"(StudentId,StudentName)values('"+rs3.getString(1) +"','"+rs3.getString(2) +"')");
                    int j=1;
                    int m=3;
                        while(j<=core)
                          {
                            String grade="";
                                if("F".equals(rs3.getString(m+1)))
                                     grade="NR";
                                else
                                     grade=rs3.getString(m+1); 
                            st5.executeUpdate("update "+stream+"_"+yearfinding+" set core"+j+"='"+rs3.getString(m)+"',c"+j+"grade='"+grade+"' where StudentId='"+studentid+"'");
                            j++;m=m+2; 
                          }
                    int k=1;
                        while(k<=labs)
                          {
                            String grade="";
                                if("F".equals(rs3.getString(m+1)))
                                     grade="NR";
                                else
                                     grade=rs3.getString(m+1); 
                            st5.executeUpdate("update "+stream+"_"+yearfinding+" set lab"+k+"='"+rs3.getString(m)+"',l"+k+"grade='"+grade+"' where StudentId='"+studentid+"'");
                            k++;
                            m=m+2;  
                          }
                       k=1;
                        while(k<=project)
                          {
                            String grade="";
                                if("F".equals(rs3.getString(m+1)))
                                     grade="NR";
                                else
                                     grade=rs3.getString(m+1); 
                            st5.executeUpdate("update "+stream+"_"+yearfinding+" set project"+k+"='"+rs3.getString(m)+"',p"+k+"grade='"+grade+"' where StudentId='"+studentid+"'");
                            k++;
                            m=m+2;                            
                          }
                       k=1;
                        while(k<=electives)
                          {
                            if(rs3.getString(m)==null)
                                 st5.executeUpdate("update "+stream+"_"+yearfinding+" set ele"+k+"="+rs3.getString(m)+",e"+k+"grade='"+rs3.getString(m+1)+"' where StudentId='"+studentid+"'");
                            else
                               {
                                String grade="";
                                if("F".equals(rs3.getString(m+1)))
                                     grade="NR";
                                else
                                     grade=rs3.getString(m+1);                                                                  
                                st5.executeUpdate("update "+stream+"_"+yearfinding+" set ele"+k+"='"+rs3.getString(m)+"',e"+k+"grade='"+grade+"' where StudentId='"+studentid+"'");
                               }
                            k++;
                            m=m+2;                             
                          }
                        st6.executeUpdate("delete from "+stream+"_"+syear+" where StudentId='"+studentid+"'");
                 }
                }
                catch(Exception e)
                 {out.println("<center><h3>"+studentid+"  Readmission not possible</h3></center>");
                 flag++;}
              //**********************************for ending*************************************
             }
         }
        
        
   if(flag==0)
{%>
    <center>
        <table align="center">
        	<tr align="center"><h2>Re-Admission of the students successfully compleated.</h2></tr>
        </table></center>
  <%}%>
    </body>
</html>