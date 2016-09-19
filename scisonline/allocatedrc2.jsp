<%-- 
    Document   : allocatedrc2
    Created on : Jun 9, 2013, 10:36:42 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="id_parser.jsp"%>   
<!DOCTYPE html>
<html>
    <head>
        
        <script language="javaScript" type="text/javascript" src="calendar.js">
        </script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
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
        <script language="javascript">
            function find()
            {
                
              var v=document.getElementById("progress").value;
              v=v.replace(/^\s+|\s+$/g,'');
              //v = v.replace(/\n/g, '\n');
              v=v.replace(/\s+/g, ' ');
              document.getElementById("progress").value=v;
              var m=document.getElementById("sugestions").value;
              m=m.replace(/^\s+|\s+$/g,'');
              m=m.replace(/\s+/g, ' ');
              document.getElementById("sugestions").value=m;
              
              var s=document.getElementById("startdate").value;
              if(s=="")
                {
                 alert("please select date");
                 return false;
                }
            //  if(v=="")
              //    {
              //   alert("please enter progress of work");
               //  return false;
               //   }
               //if(m=="")
               //   {
               //  alert("please enter Suggestions");
               //  return false;
                //  }   
            }
        </script>
    </head>
    <body>
        <form action="allocatedrc3.jsp" onsubmit="return find()">
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
           Statement st1=con2.createStatement();
           Statement st2=con2.createStatement();
           Statement st3=con2.createStatement();
           Statement st_snam=con2.createStatement(); 
          
           String user=(String)session.getAttribute("user");
           String sid=request.getParameter("studentid");
           if(sid.equals("none"))
            {
             out.println("<center><h3>please select student id</h3></center>");
            }
           else
            {
              int   BATCH_YEAR  =Integer.parseInt( CENTURY+sid.substring(SYEAR_PREFIX,EYEAR_PREFIX));
              ResultSet rs1=st1.executeQuery("select * from PhD_"+BATCH_YEAR+" where StudentId='"+sid+"'");
               ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+BATCH_YEAR+" where StudentId='"+sid+"'");
              rs_sname.next();
              rs1.next();
              %>
        <center>
        </br>
        </br>
        <table border="10" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
            <tr>
                <td align="center">Student ID</td>
                <td align="center">Student Name</td>
                <td align="center">Area of Research</td>
                <td align="center">Thesis Title</td>
            </tr>
            <tr> 
            <input type="hidden" name="studentid" value="<%=rs1.getString("StudentId")%>">
            <td align="center"><b><%=rs1.getString("StudentId")%></b></td>
             
            <input type="hidden" name="studentname" value="<%=rs_sname.getString(2)%>">
            <td align="center"><b><%=rs_sname.getString(2)%></b></td>
             
            <input type="hidden" name="area" value="<%=rs1.getString("areaofresearch")%>">
            <td align="center"><b>
            <%if(rs1.getString("areaofresearch") == null) {
            } else { %>        
                <%=rs1.getString("areaofresearch")%></b>
            <%}%>
            </td>
             
             <input type="hidden" name="title" value="<%=rs1.getString("thesistitle")%>">
            <td align="center"><b>
            <%if(rs1.getString("thesistitle") == null) {
                    
            } else { %>
                    <%=rs1.getString("thesistitle")%></b>
            <%    }
            %>
            </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <select id="status" name="status">
                        <option value="Satisfactory">Satisfactory</option>
                        <option value="UnSatisfactory">UnSatisfactory</option>
                    </select>
                </td>
               <td colspan="2" align="center">
                    <input type="text"  name="startdate" id="startdate" readonly="readonly"><a href="#" onClick="setYears(2008, 2020);showCalender(this, 'startdate');">
                    <img src="calender.png"></a>
      			<table id="calenderTable">
                            <tbody id="calenderTableHead">
                                <tr>
                                    <td colspan="4" align="center">
	          			<select onChange="showCalenderBody(createCalender(document.getElementById('selectYear').value,this.selectedIndex, false));" id="selectMonth">
                                            <option value="0">Jan</option>
                                            <option value="1">Feb</option>
                                            <option value="2">Mar</option>
                                            <option value="3">Apr</option>
                                            <option value="4">May</option>
                                            <option value="5">Jun</option>
                                            <option value="6">Jul</option>
                                            <option value="7">Aug</option>
                                            <option value="8">Sep</option>
                                            <option value="9">Oct</option>
                                            <option value="10">Nov</option>
                                            <option value="11">Dec</option>
                                        </select>
                                    </td>
                                    <td colspan="2" align="center">
			    		<select onChange="showCalenderBody(createCalender(this.value, document.getElementById('selectMonth').selectedIndex, false));" id="selectYear">
                                        </select>
                                    </td>
                                    <td align="center">
			    		<a href="#" onClick="closeCalender();"><font color="#003333" size="+1">X</font></a>
                                    </td>
		  		</tr>
       				</tbody>
                            <tbody id="calenderTableDays">
         			<tr style="">
                                    <td>Sun</td><td>Mon</td><td>Tue</td><td>Wed</td><td>Thu</td><td>Fri</td><td>Sat</td>
         			</tr>
                            </tbody>
                            <tbody id="calender"></tbody>
    			</table>
                </td>
                
            </tr>
            <tr>
                <td><b>Progress of Work</b></td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <textarea rows="10" id="progress" name="progress" cols="150">

                    </textarea> 
                </td>
            </tr>
             <tr>
                <td><b>Suggestions</b></td>
            </tr>
            <tr>
                
                <td align="center" colspan="4">
                    <textarea rows="10" id="sugestions" name="sugestions" cols="150" >
                        
                    </textarea> 
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center"><input type="submit" value="Submit"></td>
            </tr>
        </table>
      </center>
              <%
              rs1 = null;
              rs_sname = null;
        
            }
            st1 = null;
            st2 = null;
            st3 = null;
            st_snam = null;
            
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
