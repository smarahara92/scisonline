<%-- 
    Document   : phd_ele_reg1
    Created on : Jun 6, 2013, 4:34:54 PM
    Author     : root
--%>

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
        <%
        
       
           Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           int cyear=now.get(Calendar.YEAR);
           if(month>=1&&month<=6){
                cyear=cyear-1;}           
          Statement st1=con2.createStatement();
          Statement st2=con2.createStatement();
          Statement st3=con2.createStatement();
          Statement st6=con2.createStatement();
          Statement st_comp=con2.createStatement();
          Statement st_comp2=con2.createStatement();
          Statement st7=con2.createStatement(); 
          Statement st_snam=con2.createStatement(); 
          
          ResultSet rs1=st1.executeQuery("select * from PhD_"+cyear+"");
           //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
           // srinivas comments
           // curriculum version code has to be added, 
           // currefer table has to be used for getting the # of ele, cores.
           // note that here, we are givin ele reg for the current starting batch eg : 2013 june / july joined batch, we are giving reg in 2013 july / aug. 
          // if you want to do ele reg in jan, the decrease cyear by 1, since cyear will be 2014 for 2013 batch in the jan 2014.
           //*****************************************************
   /*
                         *code for taking latest curriculum
                         */
                        
           int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
           Statement st10_cur = (Statement) con2.createStatement();

           ResultSet rs10_cur = st10_cur.executeQuery("select * from  PhD_curriculumversions order by Year desc");
           while (rs10_cur.next()) {
                curriculumYear = rs10_cur.getInt(1);

                if (curriculumYear <= cyear) {

                    latestYear = curriculumYear;
                    System.out.println(latestYear);
                    break;
                }
            }
                     // done   code for taking latest curriculum
         
          //ResultSet rs3=st3.executeQuery("select * from PhD_curriculum offset limit 1");
          ResultSet rs3=st3.executeQuery("select * from PhD_"+latestYear+"_currrefer ");
          rs3.next();
          int noofelectives=Integer.parseInt(rs3.getString(2));
          int noofcores=Integer.parseInt(rs3.getString(1));
          //out.println(noofelectives);
          while(rs1.next())
           {
                String temp[]=request.getParameterValues(rs1.getString(1));
                if(temp==null)
                {
                    int j=1;
               
                    ResultSet rs7=st7.executeQuery("select * from comprehensive_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
                    rs7.next();
                    System.out.println("tc 1");
                    while(j<=noofelectives)
                    {
                        if(rs7.getString("ele"+j)!=null&&rs7.getString("e"+j+"grade").equals("R"))
                        {   
                      //st6.executeUpdate("update PhD_"+cyear+" set ele"+j+"=null,e"+j+"grade='NR' where StudentId='"+rs7.getString(1)+"'");
                            st6.executeUpdate("update comprehensive_"+cyear+" set ele"+j+"=null,e"+j+"marks=null,e"+j+"grade='NR' where StudentId='"+rs7.getString(1)+"'");
                        } 
                        j++;
                    }
                    System.out.println("tc 2");               
                    j=1;
                    while(j<=noofcores)
                    {
                        if(rs7.getString("core"+j)!=null&&rs7.getString("c"+j+"grade").equals("R"))
                        {   
                      //st6.executeUpdate("update PhD_"+cyear+" set core"+j+"=null,c"+j+"grade='NR' where StudentId='"+rs7.getString(1)+"'");
                            st6.executeUpdate("update comprehensive_"+cyear+" set core"+j+"=null,c"+j+"marks=null,c"+j+"grade='NR' where StudentId='"+rs7.getString(1)+"'");
                        } 
                        j++;
                    }
                }
                else
                {
                     Statement st4=con2.createStatement();   
                    ResultSet rs4=st4.executeQuery("select * from PhD_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
                    ResultSet rs_comp2=st_comp2.executeQuery("select * from comprehensive_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
                 
                    System.out.println(rs1.getString(1));
                    rs4.next();
                    rs_comp2.next();
                    int i=0;
                    int j=1;
                    while(j<=noofelectives)
                    {
                 // System.out.println("llll");
                        if(rs_comp2.getString("ele"+j)!=null&&rs_comp2.getString("e"+j+"grade").equals("R"))
                        {   
                      //st6.executeUpdate("update PhD_"+cyear+" set ele"+j+"=null,e"+j+"grade='NR' where StudentId='"+rs4.getString(1)+"'");
                            st6.executeUpdate("update comprehensive_"+cyear+" set ele"+j+"=null,e"+j+"marks=null,e"+j+"grade='NR' where StudentId='"+rs4.getString(1)+"'");
                        }    
                        j++;
                    }
             
             
                    j=1;
                    while(j<=noofcores)
                    {
                 // System.out.println("llll");
                        if(rs_comp2.getString("core"+j)!=null&&rs_comp2.getString("c"+j+"grade").equals("R"))
                        {   
                      //st6.executeUpdate("update PhD_"+cyear+" set core"+j+"=null,c"+j+"grade='NR' where StudentId='"+rs4.getString(1)+"'");
                            st6.executeUpdate("update comprehensive_"+cyear+" set core"+j+"=null,c"+j+"marks=null,c"+j+"grade='NR' where StudentId='"+rs4.getString(1)+"'");
                        } 
                        j++;
                    }
              
              
                    for(i=0;i<temp.length;i++)
                    {
                // System.out.println(temp[i]);
                        Statement st5=con2.createStatement(); 
                
                        String type=temp[i].substring(0,1);
                        String subjid=temp[i].substring(1);
                        System.out.println(type+"   "+subjid);
                        ResultSet rs5=st5.executeQuery("select * from PhD_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
                        ResultSet rs_comp=st_comp.executeQuery("select * from comprehensive_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
                  
                        rs5.next();  
                        rs_comp.next();  
                  
                        int k=1;
                        if(type.equals("e"))
                        {
                            while(k<=noofelectives)
                            {
                                if(rs_comp.getString("ele"+k)==null&&rs_comp.getString("e"+k+"grade").equals("NR"))
                                {   
                        //System.out.println("llll"+temp[i]+k);
                        //st2.executeUpdate("update PhD_"+cyear+" set ele"+k+"='"+subjid+"',e"+k+"grade='R' where StudentId='"+rs5.getString(1)+"'");                     
                                    st2.executeUpdate("update comprehensive_"+cyear+" set ele"+k+"='"+subjid+"',e"+k+"marks=null,e"+k+"grade='R' where StudentId='"+rs5.getString(1)+"'");
                        // System.out.println("mmm");                       
                                    break;
                                } 
                                k++;
                            }
                        }
                        else if(type.equals("c"))
                        {
                            while(k<=noofcores)
                            {
                                if(rs_comp.getString("core"+k)==null&&rs_comp.getString("c"+k+"grade").equals("NR"))
                                {   
                        //System.out.println("llll"+temp[i]+k);
                        //st2.executeUpdate("update PhD_"+cyear+" set core"+k+"='"+subjid+"',c"+k+"grade='R' where StudentId='"+rs5.getString(1)+"'");                     
                                    st2.executeUpdate("update comprehensive_"+cyear+" set core"+k+"='"+subjid+"',c"+k+"marks=null,c"+k+"grade='R' where StudentId='"+rs5.getString(1)+"'");
                        // System.out.println("mmm");                       
                                    break;
                                } 
                                k++;
                            }
                        }
                    }
                }
           }
         %>
        <center><b><%=UNIVERSITY_NAME%></b></center>
        <center><b><%=SCHOOL_NAME%></b></center>
        <center><b>Ph.D. Students Comprehensive list</b></center>
        </br></br>
        <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
       
     <tr>
        <th>StudentId</th>
        <th>StudentName</th>
        <%
           int j=1;
           while(j<=noofcores)
              {  
              %><th>Core <%=j%></th><% 
              j++;                               
              }
           j=1;
            while(j<=noofelectives)
              {  
              %><th>Elective <%=j%></th><%
                j++;                                
              }
        %>
     </tr>
        <%
            Statement st20=con2.createStatement();
       
            // since we removed the student name fromt the comprehensive , drc tables so to get the student do join with with the master table.
            // syntax :  rs = statement.executeQuery("select * from stu_info, stu_marks where "+
            //"stu_info.ID=stu_marks.stu_id");
            ResultSet rs20=st20.executeQuery("select * from comprehensive_"+cyear+" , PhD_"+cyear+" where comprehensive_"+cyear+".StudentId=PhD_"+cyear+".StudentId");
            while(rs20.next())
            {
                ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+cyear+" where StudentId='"+rs20.getString("StudentId")+"'");
                rs_sname.next();
                j=1;
        %><tr>
              <td><%=rs20.getString("StudentId")%></td>
              <td><%=rs_sname.getString(2)%></td>
              <%
                    while(j<=noofcores)
                    {
                        if(rs20.getString("core"+j)!=null)
                        {   
              %>            <td><%=rs20.getString("core"+j)%></td>
                            <% 
                        }
                        else
                        {
                            %><td></td><%
                        }
                        j++;
                    }
                    j=1;
                    while(j<=noofelectives)
                    {
                        if(rs20.getString("ele"+j)!=null)
                        {   
                            %><td><%=rs20.getString("ele"+j)%></td>
                            <% 
                        } 
                        else
                        {
                            %><td></td><%
                        }
                        j++;
                    }
                 
                    %></tr><%   
            }
            %></table><%
        
            %></br>
            <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
            <tr>    <th>Subject Name</th>
                    <th>Code</th>
            </tr>
            <%  
                ResultSet rs2=st2.executeQuery("select * from PhD_electives");
           //ResultSet rs7 = (ResultSet)st20.executeQuery("select * from PhD_curriculum limit "+noofcores+" offset 1");
                ResultSet rs7_2 = (ResultSet)st20.executeQuery("select * from PhD_"+latestYear+"_curriculum");
         
                while(rs7_2.next())
                {
           %>       <tr>
                        <td><%=rs7_2.getString(2)%></td>   
                        <td><%=rs7_2.getString(1)%></td>   
                    </tr>
                    <%
                }
                while(rs2.next())
                {
                    %><tr>
                    <td><%=rs2.getString(2)%></td>   
                    <td><%=rs2.getString(1)%></td>   
                    </tr>
                    <%
                }
                %></table><%  
                try{
                    rs2.close();
                    rs3.close();
                    rs7_2.close();
                    st1.close();
                    st2.close();
                    st3.close();
                    st6.close();
                    st_comp.close();
                    st_comp2.close();
                    st7.close(); 
                    st_snam.close();
                    st10_cur.close();
                    rs10_cur.close();
                    rs1.close();
                   }
                catch(Exception e){
                    System.out.println(e);
                } 
                finally{
                    con.close();
                    con2.close();
                }
        
        %>
             
       
    </body>
</html>
