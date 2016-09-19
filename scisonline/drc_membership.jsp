<%-- 
    Document   : drc_membership
    Created on : Jun 5, 2013, 11:19:04 AM
    Author     : root
--%>

<%@page import="javax.sound.midi.SysexMessage"%>
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
function validate1(a)
    {
        
       var t=a.id;
       var k=a.id.substring(0,4);
      
       var e=t.substring(t.length-1,t.length);
       var x=document.getElementById("area"+e).value;
       var y=document.getElementById("id"+e).value;
       x=x.replace(/^\s+|\s+$/g,'');
       document.getElementById("area"+e).value=x;
       if(x=="")
        {
            alert("First you enter Area of Research for "+y);
            document.getElementById("drc1"+e).value="none";
            document.getElementById("drc2"+e).value="none";
            return;
        }
       var drc1=document.getElementById("drc1"+e).value;
       var drc2=document.getElementById("drc2"+e).value;
       if((drc1!="none"&&drc2!="none"&&drc1==drc2))
       {
           alert("duplicate entry!");
           if(k=="drc1")
             document.getElementById("drc2"+e).value="none";
           else
              document.getElementById(t).value="none";
           
       }
         
           else if(drc1=="none"&&drc2!="none")
           {
              alert("enter drcmember1 before drcmember2");
           
            document.getElementById("drc2"+e).value="none"; 
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
    
    function find(a)
    {
       var i=1,j=0;
       for(i=1;i<=a;i++)
       {
          var x=document.getElementById("area"+i).value;
          x=x.replace(/^\s+|\s+$/g,'');
          document.getElementById("area"+i).value=x;
          if(x==""||x=="NOT APPLICABLE")
              {
              var y=document.getElementById("drc1"+i).value;
              var z=document.getElementById("drc2"+i).value;
              if(y!="none"||z!="none")
               {
                   alert("enter area of research for "+document.getElementById("id"+i).value);
                   return false;
               }
              j++;
              }
          else
            {
                var y=document.getElementById("drc1"+i).value;
                if(y=="none")
                 {
                     alert("enter drc member for "+document.getElementById("id"+i).value);
                     return false;
                 }
            }
       }
       if(j==a)
        {
            alert("enter atleast one student datails");
            return false;
        }
    }
  </script>  
    </head>
    <body>
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
            	<td align="center" class="style31"><font size="6">DRC Membership</font></td>
            </tr>
        </table>
        </br>
        </br>
        
         
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
        Statement st1=con2.createStatement();
        Statement st3=con2.createStatement();
        Statement st2=con.createStatement(); 
        
        Statement st_snam=con2.createStatement(); 
        
        String user=(String)session.getAttribute("user");
       // out.println(user);
        ResultSet rs1=null;
         ResultSet rs3=null;
        if(user.equals("staff"))
            {          
             rs1=st1.executeQuery("select * from PhD_"+cyear+"");
              rs3=st3.executeQuery("select count(*) from PhD_"+cyear+"");
            }
        else
            {
             rs1=st1.executeQuery("select * from PhD_"+cyear+" where supervisor1='"+user+"' or supervisor2='"+user+"' or supervisor3='"+user+"'");
             rs3=st3.executeQuery("select count(*) from PhD_"+cyear+" where supervisor1='"+user+"' or supervisor2='"+user+"' or supervisor3='"+user+"'");
            }
       int totalstudents=0;
       if(rs3.next()==true)
             totalstudents=Integer.parseInt(rs3.getString(1));
       
       %>
       <form name="frm" action="drc_membership1.jsp"  method="POST" onsubmit="return find('<%=totalstudents%>')">
           <input type="hidden" name="totalstudents" value="<%=totalstudents%>"  >
         <table border="1" cellspacing="2" cellpadding="1" align="center">
       
     <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Area of Research</th>
        <th>DRC Member1</th>
        <th>DRC Member2</th>
     </tr>  
           
           
         <%
        int i=1;
        while(rs1.next())
        {    ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
             rs_sname.next();
           if(rs1.getString("supervisor1")!=null)
            {
             %>
             <tr>
           <td><input type="text" id="id<%=i%>" name="id" style="width:100px"value="<%=rs1.getString(1)%>" readonly  onKeyPress="return disableEnterKey(event)"></td>
           <td align="center"><input type="text"  id="name<%=i%>" name="name" style="width:200px"value="<%=rs_sname.getString(2)%>"readonly  onKeyPress="return disableEnterKey(event)"></td>
          <%if(rs1.getString("areaofresearch")!=null)
              {%><td align="center"><input type="text"  id="area<%=i%>" name="area" style="width:300px" value="<%=rs1.getString("areaofresearch")%>"  onKeyPress="return disableEnterKey(event)"></td><%}
             else
                {%><td align="center"><input type="text"  id="area<%=i%>" name="area" style="width:300px" value=""  ></td><%}
             ResultSet rs2=st2.executeQuery("select * from faculty_data where ID<>'"+rs1.getString("supervisor1")+"' and ID<>'"+rs1.getString("supervisor2")+"' and ID<>'"+rs1.getString("supervisor3")+"'"); 
          %>
          
             <td align="center">
                       <select style="width:150px" id="drc1<%=i%>" name="drc1" onchange="validate1(this)">
                           <option value="none">None</option>
                           <%
                             
                             while(rs2.next())
                             {
                              if(rs1.getString("drc1")!=null&&rs2.getString(1).equals(rs1.getString("drc1")))   
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
                       <select style="width:150px" id="drc2<%=i%>" name="drc2" onchange="validate1(this)">
                           <option value="none">None</option>
                           <%
                            rs2.beforeFirst();
                             while(rs2.next())
                             {
                              if(rs1.getString("drc2")!=null&&rs2.getString(1).equals(rs1.getString("drc2")))   
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
             </tr>
              
             
             <%
            }
           else
            {
               %>
             <tr>
           <td><input type="text" id="id<%=i%>" name="id" style="width:100px"value="<%=rs1.getString(1)%>" readonly  onKeyPress="return disableEnterKey(event)"></td>
           <td align="center"><input type="text"  id="name<%=i%>" name="name" style="width:200px"value="<%=rs_sname.getString(2)%>"readonly    onKeyPress="return disableEnterKey(event)"></td>
          <%if(rs1.getString("areaofresearch")!=null)
              {%><td align="center"><input type="text"  id="area<%=i%>" name="area" style="width:300px"  value="<%=rs1.getString("areaofresearch")%>"readonly  onKeyPress="return disableEnterKey(event)"></td><%}
             else
                {%><td align="center"><input type="text"  id="area<%=i%>" name="area" style="width:300px" value="NOT APPLICABLE" readonly></td><%}
             ResultSet rs2=st2.executeQuery("select * from faculty_data where ID<>'"+rs1.getString("supervisor1")+"' and ID<>'"+rs1.getString("supervisor2")+"' and ID<>'"+rs1.getString("supervisor3")+"'"); 
          %>
          
             <td align="center">
                       <select style="width:150px" id="drc1<%=i%>" disabled="true" name="drc1" onchange="validate1(this)">
                           <option value="none">None</option>
                           <%
                             
                             while(rs2.next())
                             {
                               if(rs1.getString("drc1")!=null&&rs2.getString(1).equals(rs1.getString("drc1")))   
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
                       <select style="width:150px" id="drc2<%=i%>" disabled="true" name="drc2" onchange="validate1(this)">
                           <option value="none">None</option>
                           <%
                             rs2.beforeFirst();
                             while(rs2.next())
                             {
                              if(rs1.getString("drc2")!=null&&rs2.getString(1).equals(rs1.getString("drc2")))   
                               {
                                  
                               %><option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option><%   
                               }
                              else
                               {
                                %><option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option><%     
                               }                                
                            //   rs2 = null;
                             }
                           
                           %>
                       </select>
                   </td>  
             </tr>    
             <%
            }
           i++;
           rs_sname = null;
        }
           st1 = null;
           st2 = null;
           st3 = null;
           st_snam = null;
           rs1 = null;
           rs3 = null;
        }
        catch(Exception e){
            System.out.println(e);
         }
        finally{
            con.close();
            con2.close();
         }
        
        %>
         </table>
          </br>
          <center> <input type="submit" name="submit" value="submit"> </center>

        </form>
         
    </body>
    
</html>
