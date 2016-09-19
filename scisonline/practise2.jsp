<%-- 
    Document   : practise2
    Created on : Jan 15, 2012, 5:34:19 PM
    Author     : jagan
--%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="JavaScript">
           
            function display1()
  {
      if(document.form1.mySelect1.options[0].selected)
      document.form1.mySelect2.options.selectedIndex=(0);
  
  if(document.form1.mySelect1.options[1].selected)
      document.form1.mySelect2.options.selectedIndex=(1);
  
  if(document.form1.mySelect1.options[2].selected)
      document.form1.mySelect2.options.selectedIndex=(2);
  
  if(document.form1.mySelect1.options[3].selected)
      document.form1.mySelect2.options.selectedIndex=(3);
  
  if(document.form1.mySelect1.options[4].selected)
      document.form1.mySelect2.options.selectedIndex=(4);

  }
  
  function display2()
  {
      if(document.form1.mySelect3.options[0].selected)
      document.form1.mySelect4.options.selectedIndex=(0);
  
  if(document.form1.mySelect3.options[1].selected)
      document.form1.mySelect4.options.selectedIndex=(1);
  
  if(document.form1.mySelect3.options[2].selected)
      document.form1.mySelect4.options.selectedIndex=(2);
  
  if(document.form1.mySelect3.options[3].selected)
      document.form1.mySelect4.options.selectedIndex=(3);
  
  if(document.form1.mySelect3.options[4].selected)
      document.form1.mySelect4.options.selectedIndex=(4);

  }
  
  function change()
  {
      document.forms.form1.submit();
  }
       

// here is your function

function findTheChecked(){
var radio_1 = window.document.form1.radio_1;
var radio_2 = window.document.form1.radio_2;

// the above locates the checkboxes

if(radio_1.checked == true){ //this finds which one is checked
radio_2.checked = false;
window.location.replace("browse.jsp"); // change that to the site
}else{
if(radio_2.checked == true){
radio_1.checked = false;
window.location.replace("update.jsp");// change that to the other
}
}
}

function checked1()
{
    window.document.forms["form1"].submit();
   /* var radio_1 = window.document.form1.radio_1;
var radio_2 = window.document.form1.radio_2;
   if(radio_1.checked == true){ //this finds which one is checked
radio_2.checked = false;

document.forms.form1.submit(); // change that to the site
}else{
if(radio_2.checked == true){
radio_1.checked = false;
document.forms.form2.submit();// change that to the other
}
}*/
}
function checked2()
{
    document.getElementById("year1").value=document.getElementById("year").value;
    document.getElementById("mySelect11").value=document.getElementById("mySelect1").value;
    document.getElementById("mySelect22").value=document.getElementById("mySelect2").value;
    //document.getElementById("mySelect33").value=document.getElementById("mySelect3").value;
    //document.getElementById("mySelect44").value=document.getElementById("mySelect4").value;
    document.getElementById("semester1").value=document.getElementById("semester").value;
    document.getElementById("subjid1").value=document.getElementById("subjid").value;
    document.getElementById("subjname1").value=document.getElementById("subjname").value;
    document.getElementById("pa1").value=document.getElementById("pa").value;
    document.getElementById("ca1").value=document.getElementById("ca").value;
    document.getElementById("pta1").value=document.getElementById("pta").value;
    
    
    //document.getElementById("text2").value=document.getElementById("text1").value;
    window.document.forms["form2"].submit();
   
}
</script>
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
    int year=now.get(Calendar.YEAR);
    String semester="";
    if(month==7 || month==8 || month==9 || month==10 || month==11 || month==12)
               {
   semester="Winter";
    }else if (month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
               {
         semester="Monsoon";
    }
    
        System.out.println("**************************************************************************");
        String sname=request.getParameter("subjectname");
     if(sname==null) sname="";
        

//session.setAttribute("facultyname",fname);
    System.out.println(sname);
    System.out.println("***************************************");
        String subjectid="";
        String subjectname="";
        String username=(String) session.getAttribute("facultyid");
        
if(username==null) username="";
System.out.println(username);
//String facultyname=request.getParameter("facultyname");
        //System.out.println(facultyname);
        
       try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    String qry="select code from subject_database where Subject_Name='"+sname+"'";
    String qry1="select subjectid,subjectname from subject_faculty where facultyid='"+username+"' ";
    
    
    Statement st1=con.createStatement();
   // ResultSet rs1=st1.executeQuery(qry);    
    ResultSet rs=st1.executeQuery(qry);
    System.out.println("out of while loop");
    
                        
    
                        
    %>
   <form id="form1" name="form1" action="browse.jsp">     
    <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%">
            <tr>
                <th>Year<br/><input type="text" name="year" id="year" value="<%=year%>" size="10" readonly="readonly" /></th>
                <%if(semester.equals("Monsoon"))
                                       {%>
                <th>From<br/>
    <select name="mySelect1" id="mySelect1" onChange="display1();">
        <option value=JAN15>JAN15</option>
        <option value=FEB15>FEB15</option>
        <option value=MAR15>MAR15</option>
        <option value=APR15>APR15</option>
        <option value=MAY15>MAY15</option>
      </select></th>
                
                <th>To<br/><select name="mySelect2" id="mySelect2">
         <option value=FEB14>FEB14</option>
        <option value=MAR14>MAR14</option>
        <option value=APR14>APR14</option>
        <option value=MAY14>MAY14</option>
        <option value=JUN14>JUN14</option>
      </select></th>
      <%}%>
      <%if(semester.equals("Winter"))
                   {%>
      <th>From<br/>
    <select name="mySelect1" id="mySelect1" onChange="display1();">
        <option value=JULY15>JULY15</option>
        <option value=AUG15>AUG15</option>
        <option value=SEP15>SEP15</option>
        <option value=OCT15>OCT15</option>
        <option value=NOV15>NOV15</option>
      </select></th>
                
                <th>To<br/><select name="mySelect2" id="mySelect2">
        <option value=AUG14>AUG14</option>
        <option value=SEP14>SEP14</option>
        <option value=OCT14>OCT14</option>
        <option value=NOV14>NOV14</option>
        <option value=DEC14>DEC14</option>
      </select></th>
      <%}%>
                <th>Semester<br/><input type="text" id="semester" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></th>
                
           <!--     <th>Semester<br/><select width="30" style="width:100px">
                        
                        <option>Winter</option>
                        <option>Summer</option>
                    </select>                   
                </th>
           -->
   <% while(rs.next())
                              {
                            System.out.println("within while loop");
                            
                        //System.out.print(""+rs.getString(2));
                        subjectid=rs.getString(1);
                        //subjectname=rs.getString(2);
                                               }
                       %>
                                               
                <th>Subject<br/><input type="text" name="subjname" id="subjname" value="<%=sname%>" size="25" readonly="readonly" />  
                   <% session.setAttribute("subjname",sname);%>
                </th>
                
                <th>Code<br/><input type="text" name="subjid" id="subjid" value="<%=subjectid%>" size="10" readonly="readonly" />    
                  <%  session.setAttribute("subjid",subjectid);%>
                </th>
                
            </tr>
            
            <%
            System.out.println("out of while loop........about to end");
            String qry2="insert into subject_attendance values('"+subjectid+"',0,0,0,0,0)";
            st1.executeUpdate(qry2);
            System.out.println("out of while loop........end");
             }
             catch(Exception e)
             {
                 e.printStackTrace();
                                 }
            %>
    </table>
    <br/>
    <%       try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
   String qry4="select cumatten from subject_attendance where subjectId='"+subjectid+"'";
    String qry5="select StudentId,StudentName,cumatten,percentage from july_2011_"+subjectid+" ";
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
   ResultSet rs4=st3.executeQuery(qry4);    
    ResultSet rs1=st2.executeQuery(qry5);
    
       %>
       
        <table border="0" style="color:blue;background-color:#CCFF99" cellspacing="10" cellpadding="0" >
            <tr>
                <td><center>Number of Hours<br/>taught:</center></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <% 
                if(rs4.next())
                  {
                    %>
                
                    
                <td>Previous Total<input type="text" name="pa" id="pa" value="<%=rs4.getInt(1)%>" readonly="readonly" size="15"/></td>
                <%}
    else
{
      %>    
                <td>Previous Total<input type="text" name="pa" id="pa" value="0" readonly="readonly" size="15"/></td>
                <%  
}%>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Current Month<input type="text" name="ca" id="ca" value=""  size="15"/></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Total<input type="text" name="pta" id="pta" value="" readonly="readonly" size="15"/></td>
            </tr>
        </table>
               <% }
        catch(Exception e)
               {
e.printStackTrace();
}
%>
   </form>
<br/>
<%     
       
if(username==null) username="";
System.out.println(username);
//String facultyname=request.getParameter("facultyname");
        //System.out.println(facultyname);
        
       try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    String qry="select code from subject_database where Subject_Name='"+sname+"'";
    String qry1="select subjectid,subjectname from subject_faculty where facultyid='"+username+"' ";
    
    
    Statement st1=con.createStatement();
   // ResultSet rs1=st1.executeQuery(qry);    
    ResultSet rs=st1.executeQuery(qry);
    System.out.println("out of while loop");
    
                        
    
                        
    %>
   
    <!-- form2 -->
    
    <form id="form2" action="update.jsp" method="POST">
        
        <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%">
            <tr>
                <th><br/><input type="hidden" name="year" id="year1" value="2011" size="10" readonly="readonly" /></th>
                <%if(semester.equals("Monsoon"))
                                       {%>
                <th><br/>
    <select name="mySelect1" id="mySelect11" onChange="display1();" style="display:none;">
        <option value=JAN15>JAN15</option>
        <option value=FEB15>FEB15</option>
        <option value=MAR15>MAR15</option>
        <option value=APR15>APR15</option>
        <option value=MAY15>MAY15</option>
      </select></th>
      
                
                <th><br/><select name="mySelect2" id="mySelect22" style="display:none;">
        <option value=FEB14>FEB14</option>
        <option value=MAR14>MAR14</option>
        <option value=APR14>APR14</option>
        <option value=MAY14>MAY14</option>
        <option value=JUN14>JUN14</option>
      </select></th>
<%}%>      
      <%if(semester.equals("Winter"))
                   {%>
                   <th><br/>
    <select name="mySelect1" id="mySelect11" onChange="display2();" style="display:none;">
        <option value=JULY15>JULY15</option>
        <option value=AUG15>AUG15</option>
        <option value=SEP15>SEP15</option>
        <option value=OCT15>OCT15</option>
        <option value=NOV15>NOV15</option>
      </select></th>
                
                <th><br/><select name="mySelect2" id="mySelect22" style="display:none;">
        <option value=AUG14>AUG14</option>
        <option value=SEP14>SEP14</option>
        <option value=OCT14>OCT14</option>
        <option value=NOV14>NOV14</option>
        <option value=DEC14>DEC14</option>
      </select></th>
      <%}%>
                <th><br/><input type="hidden" name="semester" id="semester1"value="Monsoon" size="10" readonly="readonly" /></th>
                
           <!--     <th>Semester<br/><select width="30" style="width:100px">
                        
                        <option>Winter</option>
                        <option>Summer</option>
                    </select>                   
                </th>
           -->
   <% while(rs.next())
                              {
                            System.out.println("within while loop");
                            
                        //System.out.print(""+rs.getString(2));
                        subjectid=rs.getString(1);
                        //subjectname=rs.getString(2);
                                               }
                       %>
                                               
                <th><br/><input type="hidden" name="subjname" id="subjname1" value="<%=sname%>" size="25" readonly="readonly" />  
                   <% session.setAttribute("subjname",sname);%>
                </th>
                
                <th><br/><input type="hidden" name="subjid" id="subjid1" value="<%=subjectid%>" size="10" readonly="readonly" />    
                  <%  session.setAttribute("subjid",subjectid);%>
                </th>
                
            </tr>
            
            <%
            String qry2="insert into subject_attendance values('"+subjectid+"',0,0,0,0,0)";
            st1.executeUpdate(qry2);
            System.out.println("out of while loop........end");
             }
             catch(Exception e)
             {
                 e.printStackTrace();
                                 }
            %>
    </table>
    <%       try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
   String qry4="select cumatten from subject_attendance where subjectId='"+subjectid+"'";
    String qry5="select StudentId,StudentName,cumatten,percentage from july_2011_"+subjectid+" ";
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
   ResultSet rs4=st3.executeQuery(qry4);    
    ResultSet rs1=st2.executeQuery(qry5);
    
       %>
       
        
                
                
                <% 
                while(rs4.next())
                  {
                    %>
                
                    
                <input type="hidden" name="pa" id="pa1" value="<%=rs4.getInt(1)%>" readonly="readonly" size="15"/>
                <%}%>
               
                <input type="hidden" name="ca" id="ca1" value="0"  size="15"/>
                
                <input type="hidden" name="pta" id="pta1" value="0" readonly="readonly" size="15"/>
           
        
               <% }
        catch(Exception e)
               {
e.printStackTrace();
}
%>
<br/><br/><br/>
    <center>
        <input type="hidden" id="text2" name="text" value="sunil"/>
<input type="radio" name="radio_1" onClick="checked1();"><b>Upload from a file</b> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="radio_2" onClick="checked2();"><b>Update Online</b>
    </center>
</form>

    
    
        
    </body>
    
</html>