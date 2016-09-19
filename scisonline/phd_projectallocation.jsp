<%-- 
    Document   : phd_projectallocation
    Created on : Jun 3, 2013, 11:06:33 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
.style30{width:150px;color:#000000}
.style31 {color: white}
</style>
<script type="text/javascript">
    function validate(a)
     {
          var t=a.id;
          var e=t.substring(t.length-1,t.length);
          var x=document.getElementById(a.id).value;
         
          if(x=="PT"||x=="FT")
          {
            document.getElementById("org"+e).value="uoh";
            document.getElementById("esp"+e).value="";
            document.getElementById("org"+e).readOnly=true;
            document.getElementById("esp"+e).readOnly=true;
            document.getElementById("sup1"+e).disabled=false;
             document.getElementById("sup2"+e).disabled=false;
             document.getElementById("sup3"+e).disabled=false;
          }
          else if(x=="EX")
          {
             document.getElementById("sup2"+e).value="none";
             document.getElementById("sup3"+e).value="none";
             document.getElementById("sup2"+e).disabled=true;
             document.getElementById("sup3"+e).disabled=true; 
             document.getElementById("org"+e).readOnly=false;
             document.getElementById("esp"+e).readOnly=false;
             document.getElementById("org"+e).value="";
            document.getElementById("esp"+e).value="";
             
          }
     }
     
    function validate1(a)
    {
       var t=a.id;
       var k=a.id.substring(0,4);
      /// alert(k);
       var e=t.substring(t.length-1,t.length);
       var sup1=document.getElementById("sup1"+e).value;
       var sup2=document.getElementById("sup2"+e).value;
       var sup3=document.getElementById("sup3"+e).value;
       if((sup1!="none"&&sup2!="none"&&sup1==sup2))
       {
           
           alert("duplicate entry!");
           document.getElementById("sup2"+e).value="none";
       }
       if((sup1!="none"&&sup3!="none"&&sup1==sup3))
       {
           alert("duplicate entry!");
           document.getElementById("sup3"+e).value="none";
  
       }
       if((sup2!="none"&&sup3!="none"&&sup2==sup3))
       {
           alert("duplicate entry!");
           document.getElementById("sup3"+e).value="none";
  
       }
          sup1=document.getElementById("sup1"+e).value;
          sup2=document.getElementById("sup2"+e).value;
          sup3=document.getElementById("sup3"+e).value;
       
          if(sup1=="none"&&k!="sup1")
           {
            alert("enter supervisor1 before supervisor2 and 3");
            document.getElementById("sup2"+e).value="none";
            document.getElementById("sup3"+e).value="none";
           }
           else if(sup2=="none"&&sup3!="none")
           {
              alert("enter supervisor2 before supervisorid3");
           
            document.getElementById("sup3"+e).value="none"; 
           }
           if(sup1=="none"&&k=="sup1")
           {
           
            document.getElementById("sup2"+e).value="none";
            document.getElementById("sup3"+e).value="none";
           }
           
    }
    
    function find(a)
    {
       // alert(a);
        
        var i=1,j=0;
        for(i=1;i<=a;i++)
        {
           var id=document.getElementById("id"+i).value;
           
           
          
          
           var org=document.getElementById("org"+i).value;
           org=org.replace(/^\s+|\s+$/g,'');
           document.getElementById("org"+i).value=org;
           var esp=document.getElementById("esp"+i).value;
           esp=esp.replace(/^\s+|\s+$/g,'');
           document.getElementById("esp"+i).value=esp;
           var supervisor=document.getElementById("sup1"+i).value;
           //alert(supervisor);
            if(supervisor!="none")
             {
                   var type=document.getElementById("type"+i).value;
                   if(type=="FT"||type=="PT")
                   {
                     var t=document.getElementById("sup1"+i).value;
                     if(t=="none")
                      {
                          alert("choose supervisor1 for "+id);
                          return false;
                      }
                   }
                   else if(type=="EX")
                   {
                     
                     var t=document.getElementById("sup1"+i).value;
                     if(t=="none")
                      {
                          alert("choose supervisor1 for "+id);
                          return false;
                      }
                     if(org=="")
                      {
                          alert("enter organization for "+id);
                          return false;
                      }
                      if(esp=="")
                      {
                          alert("enter external supervisor for "+id);
                          return false;
                      }
                   }
             }
             else
               j++;
             
        }
       
        if(a==j)
         {
          alert("enter atleast one student details");
          return false;
         }
         return true;
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
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
            	<td align="center" class="style31"><font size="6">Ph.D. Registration</font></td>
            </tr>
        </table>
        </br>
        </br>
        <%
        try{
           Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           int cyear=now.get(Calendar.YEAR); 
           if(month>=1&&month<=6){cyear--;}
          Statement st3=con2.createStatement(); 
          ResultSet rs3=st3.executeQuery("select count(*) from PhD_"+cyear+"");
          String totalstudents="";
          if(rs3.next()==true)
             totalstudents=rs3.getString(1);
        // out.println(totalstudents);
        %>
        <form name="frm" action="phd_projectallocation1.jsp"  method="POST" onsubmit="return find('<%=totalstudents%>')">
         <table border="1" cellspacing="2" cellpadding="1" align="center">
       
     <tr>
        <th>StudentID</th>
        <th>Student Name</th>
        
         <th>Registration Type</th>
         <th>Supervisor1</th>
         <th>Supervisor2</th>
         <th>Supervisor3</th>
          <th>Organization</th>
          <th>Ext supervisor</th>
     </tr>
     <input type="hidden" name="noofstudents" value="<%=totalstudents%>">
         <%
          
    Statement st1=con2.createStatement(); 
    Statement st_snam=con2.createStatement(); 
   Statement st2=con.createStatement(); 
    try
    {
      ResultSet rs1=st1.executeQuery("select * from PhD_"+cyear+"");
      int i=1;
      while(rs1.next())
      {
          ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
          rs_sname.next();
 %>
       <tr>
           <td><input type="text" id="id<%=i%>" name="id" style="width:100px"value="<%=rs1.getString(1)%>" readonly  onKeyPress="return disableEnterKey(event)"></td>
           <td align="center"><input type="text" id="name<%=i%>" name="name" style="width:200px"value="<%=rs_sname.getString(2)%>" readonly onKeyPress="return disableEnterKey(event)"></td>
           <!--<td align="center"><input type="text" id="name<%=i%>" name="name" style="width:200px"value="<%=rs1.getString(2)%>" readonly></td>-->
           <% //*****************projecttitle
            
              //************************************************* %>  
                 <%
                 //***********pt-ft-ex***********
                 String course="";
                 if(rs1.getString("ft_pt_ex")!=null)
                      course=rs1.getString("ft_pt_ex");
                 %>
                   <td align="center">
                       <select id="type<%=i%>" name="type" onchange="validate(this)">
                           <option value="FT">FULL TIME</option>
                           <%if("PT".equals(course))
                            {%>
                            <option value="PT" selected>PART TIME</option>
                            <%}
                             
                             else
                            {%>
                            <option value="PT">PART TIME</option>
                            <%}%>
                             <%if("EX".equals(course))
                            {%>
                            <option value="EX" selected>EXTERNAL</option>
                            <%}
                            
                             else
                            {%>
                            <option value="EX">EXTERNAL</option>
                            <%}%>
                           
                       </select>
                   </td>  
                  <%
                   //*********************************************    
                   ResultSet rs2=st2.executeQuery("select * from faculty_data where ID<>'"+rs1.getString("drc1")+"' and ID<>'"+rs1.getString("drc2")+"'");                     
                   %>
                   
                   <td align="center">
                       <select style="width:150px" id="sup1<%=i%>" name="sid1" onchange="validate1(this)">
                           <option value="none">None</option>
                           <%
                            
                             while(rs2.next())
                             {
                              if(rs1.getString("supervisor1")!=null&&rs2.getString(1).equals(rs1.getString("supervisor1")))   
                               {
                                  
                               %><option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option><%   
                               }
                              else
                               {
                                %><option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option><%     
                               }                                
                              
                             }
                           
                           %>
                       </select>
                   </td>  
                   <td align="center">
                       <%
                        if(rs1.getString("ft_pt_ex")!=null&&rs1.getString("ft_pt_ex").equals("EX"))
                        {
                         %> <select style="width:150px" id="sup2<%=i%>" name="sid2" disabled="true" onchange="validate1(this)"><%
                        }
                       else
                        {
                       %><select style="width:150px" id="sup2<%=i%>" name="sid2" onchange="validate1(this)"><%
                       }
                          %> <option value="none">None</option>
                           <%
                           rs2.beforeFirst();
                             while(rs2.next())
                             {
                              if(rs1.getString("supervisor2")!=null&&rs2.getString(1).equals(rs1.getString("supervisor2")))   
                               {
                                  
                               %><option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option><%   
                               }
                              else
                               {
                                %><option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option><%     
                               }                                
                              
                             }
                           
                           %>
                       </select>
                   </td>  
                   <td align="center">
                       <%
                        if(rs1.getString("ft_pt_ex")!=null&&rs1.getString("ft_pt_ex").equals("EX"))
                        {
                         %>
                         <select style="width:150px" id="sup3<%=i%>" name="sid3" disabled="true" onchange="validate1(this)">
                        <%}
                         else
                        {
                       %><select style="width:150px" id="sup3<%=i%>" name="sid3" onchange="validate1(this)"><%
                        }
                           %><option value="none">None</option>
                           <%
                             rs2.beforeFirst();
                             while(rs2.next())
                             {
                              if(rs1.getString("supervisor3")!=null&&rs2.getString(1).equals(rs1.getString("supervisor3")))   
                               {
                                  
                               %><option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option><%   
                               }
                              else
                               {
                                %><option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option><%     
                               }                                
                              
                             }
                           
                           %>
                       </select>
                   </td>  
                   <%
                       if(rs1.getString("ft_pt_ex")==null||rs1.getString("ft_pt_ex").equals("FT")||rs1.getString("ft_pt_ex").equals("PT")) 
                        {
                        %><td><input type="text" id="org<%=i%>" name="org" style="width:150px" value="uoh" readonly  onKeyPress="return disableEnterKey(event)"></td>
                          <td><input type="text" id="esp<%=i%>" name="esp" style="width:120px" value="" readonly  onKeyPress="return disableEnterKey(event)"></td>
                        <%   
                        } 
                       else
                        {
                                 
                         %><td><input type="text" id="org<%=i%>" name="org" style="width:150px" value="<%=rs1.getString("organization")%>" onKeyPress="return disableEnterKey(event)">
                          <td><input type="text" id="esp<%=i%>" name="esp" style="width:120px" value="<%=rs1.getString("externalsup")%>" onKeyPress="return disableEnterKey(event)"></td><%  
                                                                                                              
                        }                                                                                               
                   %>
       </tr>
        
       <%
       i++;
      }
    }
    catch(Exception e)
    {} 
        st3.close();
        st1.close();
        st2.close();
        st_snam.close();
    }
    catch(Exception e){
           System.out.println(e);
        } 
    finally{
            con2.close();
            con.close();
        }
         %>   
         </table>
         </br>
         
         <center> <input type="submit" name="submit" value="submit"></center>
        </form>
       
    </body>
</html>
