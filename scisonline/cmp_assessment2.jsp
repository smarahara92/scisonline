<%-- 
    Document   : cmp_assessment2
    Created on : April 25, 2014, 1:20:21 PM
    Author     : srinu
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
        <script type="text/javascript">
              function find(temp)
           {
                  var Marks=document.getElementById(temp).value;
                
                 Marks=Marks.replace(/^\s+|\s+$/g,'');
                
                  if(Marks.length==2)
                     {
                       var cap=Marks.toUpperCase(); 
                       if(cap=="AB")
                        {   
                       document.getElementById(temp).value=cap;
                        document.getElementById(temp).style.color='black';
                        document.getElementById("xx").disabled =false; 
                        return;
                        }
                     }
                 if(Marks.length==0)
                     {
                        
                        
                       document.getElementById(temp).value=0;
                        document.getElementById(temp).style.color='black';
                        document.getElementById("xx").disabled =false; 
                       return;
                     }
                var i=0,j=0;
                for(i=0; i<Marks.length;i++)
			{	
                         //alert(cmp1.charCodeAt(i));		
			if (Marks.charCodeAt(i) <48 ||Marks.charCodeAt(i) >57)
			{			
			if(Marks.charCodeAt(i)!=46)
                         {
                             
                       // alert(Marks[i]);
                        alert("invalid input");
		
                        document.getElementById(temp).style.color='red';
                      document.getElementById(temp).focus();
                      document.getElementById("xx").disabled = true;
                      
			return;                        
			}}
                        }
                        document.getElementById(temp).value=Marks;
                  if(Marks>100||Marks<0)
                    {
                        alert("Please enter a value less than or equal to 100");
                        document.getElementById(temp).style.color='red';
                      document.getElementById(temp).focus();
                      document.getElementById("xx").disabled = true;
                    }
                  else
                    {
                        document.getElementById(temp).style.color='black';
                      
                      document.getElementById("xx").disabled =false; 
                    }
           }
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
    </head>
    <body>
        <form action="cmp_assessment3.jsp">
        <%
        Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           int cyear=now.get(Calendar.YEAR); 
           
           if(month>=1&&month<=6){cyear=cyear-1;}
          Statement st1=con2.createStatement();
          Statement st2=con2.createStatement();
          Statement st3=con2.createStatement();
          Statement st6=con2.createStatement();
          Statement st20=con2.createStatement();
          Statement st_sname=con2.createStatement();
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
          
          
          // get the new curriculum.
          ResultSet rs3=st3.executeQuery("select * from PhD_"+latestYear+"_currrefer ");
         // ResultSet rs3=st3.executeQuery("select * from PhD_curriculum offset limit 1");
          rs3.next();
          int noofelectives=Integer.parseInt(rs3.getString(2));
          int noofcores=Integer.parseInt(rs3.getString(1));
          String subid=request.getParameter("subid");
          String subname=request.getParameter("subname");
          %>
          <input type="hidden" name="subid" value="<%=subid%>">
          <input type="hidden" name="subname" value="<%=subname%>">
          
          <%
          String query="";
          int j=1;
          while(j<=noofcores)
          {
           query=query+"core"+j+"='"+subid+"' or "; 
           j++;
          }
          j=1;
           while(j<=noofelectives)
          {
            if(j==noofelectives)
                  query=query+"ele"+j+"='"+subid+"'";
            else            
                 query=query+"ele"+j+"='"+subid+"' or "; 
           j++;
          }
          %>
            <center><b><%=UNIVERSITY_NAME%></b></center>
        <center><b><%=SCHOOL_NAME%></b></center>
        <center><b>List of Ph.D. Students in <%=subname%></b></center>
        </br></br>
        
          <%
          ResultSet rs20=st20.executeQuery("select * from comprehensive_"+cyear+" where "+query+"");
          if(rs20.next()==true)
          {
                  %>
            <table border="5" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
       
              <tr>
                <th>StudentId</th>
                <th>StudentName</th>
                <th>Marks</th>
              </tr>   
            
            
            <%
          //int find=0;
          int i=1;
          rs20.beforeFirst();
          while(rs20.next())
              {
                    ResultSet rs_sname=st_sname.executeQuery("select * from  PhD_Student_info_"+cyear+" where StudentId='"+rs20.getString(1)+"'");
                    rs_sname.next();
            %>
              
                <tr>
                  <input type="hidden" name="stuid" value="<%=rs20.getString(1)%>">
                  <input type="hidden" name="stuname" value="<%=rs_sname.getString("StudentName")%>">
                  <td><%=rs20.getString(1)%></td>
                  <td><%=rs_sname.getString("StudentName")%></td>
                  
              
              
              <%
              j=1;
              while(j<=noofcores)
               {
                 if(rs20.getString("core"+j)!=null&&rs20.getString("core"+j).equals(subid))
                 {
                     if(rs20.getString("c"+j+"marks")!=null)
                     {
                     %><td><input type="text" style="width:75px" name="marks" value="<%=rs20.getString("c"+j+"marks")%>" id="marks<%=i%>" onchange="find(this.id)"  onKeyPress="return disableEnterKey(event)"></td><%
                     }
                     else
                     {
                      %><td><input type="text" style="width:75px" name="marks" value="<%=0%>" id="marks<%=i%>" onchange="find(this.id)"  onKeyPress="return disableEnterKey(event)"></td><%
                     }
                   break;                                             
                 }
                 j++;                                                                            
               }
              
              j=1;
              while(j<=noofelectives)
               {
                 if(rs20.getString("ele"+j)!=null&&rs20.getString("ele"+j).equals(subid))
                 {
                     if(rs20.getString("e"+j+"marks")!=null)
                     {
                     %><td><input type="text" style="width:75px" name="marks" value="<%=rs20.getString("e"+j+"marks")%>" id="marks<%=i%>" onchange="find(this.id)"  onKeyPress="return disableEnterKey(event)"></td><%
                     }
                     else
                     {
                      %><td><input type="text" style="width:75px" name="marks" value="<%=0%>" id="marks<%=i%>" onchange="find(this.id)"  onKeyPress="return disableEnterKey(event)"></td><%
                     }
                  break;                                             
                 }
                 j++;                                                                            
               }
              
              //find=1;
              i++;
              %></tr><%
              }
          
           %>
            </table>
            </br>
            </br>           <center>                 
            <input type="submit" id="xx" align="center" value="Save"  > </center> 
           
           <%
           }
          else
           {
             out.println("<center><h3>No one present in this subject</h3></center>");
           }
           try{
               st1.close();
               st2.close();
               st3.close();
               st10_cur.close();
               st6.close();
               st20.close();
               st_sname.close();
               rs3.close();
               rs10_cur.close();
           }
           catch(Exception e){
               System.out.println(e);
           }
           finally{
               con.close();
               con2.close();
           }
        %>
        </form>
    </body>
</html>
