<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.style30 {color: #c2000d}
.style31 {color: white}
.style32 {color: green}
</style>
<script language="javascript">
function check(a)
{
        //alert(a);
	var stream =a;
	if(stream!=null)
	{
		if(stream=="")
			alert("Please choose 'stream'...!");
		else
		{
			parent.left.location="./select_option.jsp?stream="+stream;
			parent.act_area.location="./choose_ele.jsp?stream="+stream;
		}
	}
}

function p1()
            {
                document.getElementById("p1").style.display="none";
                window.print();
            }
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.pos_fixed
{
position:fixed;
bottom:0px;
background-color: #CCFFFF;
border-color: red;
}
.head_pos
{
position:fixed;
top:0px;
background-color: #CCFFFF;
}
.menu_pos
{
position:fixed;
top:105px;
background-color: #CCFFFF;
}
.table_pos
{
top:200px;
}
.border
{
background-color: #c2000d;
}
.fix
{
position:fixed;
background-color: #c2000d;
}
</style>
</head>
<body bgcolor="#CCFFFF">
<%
        //Statement st21=(Statement)con1.createStatement();
        //Statement st20=(Statement)con.createStatement();
        String value=request.getParameter("submit");
        System.out.println(value);
        Statement st13=(Statement)con1.createStatement();
        Statement st12=(Statement)con.createStatement();
	String stream = (String)session.getAttribute("stream");
        System.out.println(stream);
	String stream_table = (String)session.getAttribute("stream_table");
        System.out.println(stream_table);
	int course_count = (Integer)session.getAttribute("course_count");
        System.out.println(course_count);
	int i=0;
	String col1="", col2="", col3="", col4="", col=null, stream1="";
        Calendar cal=Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	if(stream.equals("MCA_III"))
	{
	        col1 = "ele1";
		col = "ele1";//System.out.println(stream);
                stream1="MCA III";
            ResultSet rs2 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from MCA_"+year+"");
            while(rs2.next())
            {
               st12.executeUpdate("update MCA_"+year+" set c1grade = 'R', c2grade ='R', c3grade  ='R', c4grade  ='R', c5grade  ='R', l1grade  ='R' where StudentId='"+rs2.getString(1)+"'"); 
            }
            
            ResultSet rs3 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs3.next())
            {
               st12.executeUpdate("update "+stream_table+" set c11grade = 'R', c12grade ='R', c13grade  ='R', c14grade  ='R',  l3grade  ='R' where StudentId='"+rs3.getString(1)+"'"); 
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,e1grade='NR' where StudentId='"+rs3.getString(1)+"'");
            }
                
	}
	else if(stream.equals("MCA_IV"))
	{
                col1 = "ele2";
		col = "ele2";
                stream1="MCA IV";
                int k=year-1;
           ResultSet rs4 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from MCA_"+k+"");
            while(rs4.next())
            {
               st12.executeUpdate("update MCA_"+k+" set c6grade = 'R', c7grade ='R', c8grade  ='R', c9grade  ='R', c10grade  ='R', l2grade  ='R' where StudentId='"+rs4.getString(1)+"'"); 
            }
            
            ResultSet rs5 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs5.next())
            {
               st12.executeUpdate("update "+stream_table+" set c15grade = 'R', c16grade ='R', c17grade  ='R', c18grade  ='R',  l4grade  ='R' where StudentId='"+rs5.getString(1)+"'"); 
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,e2grade='NR' where StudentId='"+rs5.getString(1)+"'");
            }     
		
	}
	else if(stream.equals("MCA_V"))
	{
                        col1 = "ele3";
			col2 = "ele4";
			col3 = "ele5";
			col4 = "ele6";
			col = "ele3, ele4, ele5, ele6";
                        stream1="MCA V";
                      ResultSet rs6 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs6.next())
            {
               st12.executeUpdate("update "+stream_table+" set c19grade = 'R' where StudentId='"+rs6.getString(1)+"'");
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,"+col2+"=null,"+col3+"=null,"+col4+"=null,e3grade='NR',e4grade='NR',e5grade='NR',e6grade='NR' where StudentId='"+rs6.getString(1)+"'");               
            }       
			
	}
	else if(stream.equals("MTECH_CS_I") || stream.equals("MTECH_AI_I"))
	{
                        col1 = "ele1";
			col2 = "ele2";
			col = "ele1, ele2";
                        if(stream.equals("MTECH_CS_I"))
                            stream1="MTECH CS I";
                        else
                            stream1="MTECH AI I";
            ResultSet rs10 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from MTech_IT_"+year+"");
            while(rs10.next())
            {
               st12.executeUpdate("update MTech_IT_"+year+" set c1grade = 'R', c2grade ='R', c3grade  ='R', c4grade  ='R', c5grade  ='R', l1grade  ='R' where StudentId='"+rs10.getString(1)+"'"); 
            }
	    ResultSet rs7 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs7.next())
            {
               st12.executeUpdate("update "+stream_table+" set c1grade = 'R', c2grade ='R', c3grade  ='R', l1grade  ='R',  l2grade  ='R' where StudentId='"+rs7.getString(1)+"'"); 
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,"+col2+"=null,e1grade='NR',e2grade='NR' where StudentId='"+rs7.getString(1)+"'");
            }     
                 	
	}
	else if(stream.equals("MTECH_CS_II"))
	{
                        col1 = "ele3";
			col2 = "ele4";
			col3 = "ele5";
			col4 = "ele6";
			col = "ele3, ele4, ele5, ele6";
                        stream1="MTECH CS II";
            
            
            
            ResultSet rs8 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs8.next())
            {
               st12.executeUpdate("update "+stream_table+" set c4grade = 'R',  l3grade  ='R'  where StudentId='"+rs8.getString(1)+"'"); 
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,"+col2+"=null,"+col3+"=null,"+col4+"=null,e3grade='NR',e4grade='NR',e5grade='NR',e6grade='NR' where StudentId='"+rs8.getString(1)+"'");
            }      
			
	}
	else if(stream.equals("MTECH_AI_II"))
	{
                        col1 = "ele3";
			col2 = "ele4";
			col = "ele3, ele4";
                     
                            stream1="MTECH AI II";
            ResultSet rs9 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs9.next())
            {
               st12.executeUpdate("update "+stream_table+" set c4grade = 'R', c5grade ='R', c6grade  ='R', l3grade  ='R' where StudentId='"+rs9.getString(1)+"'"); 
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,"+col2+"=null,e3grade='NR',e4grade='NR' where StudentId='"+rs9.getString(1)+"'");
            }
                        
	}
	else if(stream.equals("MTECH_IT_II"))
	{
	   
                        col1 = "ele1";
			col2 = "ele2";
			col = "ele1, ele2";
                            stream1="MTECH IT II";
            ResultSet rs11 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select * from "+stream_table+"");
            while(rs11.next())
            {
               st12.executeUpdate("update "+stream_table+" set c6grade = 'R', c7grade ='R', c8grade  ='R', l2grade  ='R',l3grade  ='R' where StudentId='"+rs11.getString(1)+"'"); 
               st12.executeUpdate("update "+stream_table+" set "+col1+"=null,"+col2+"=null,e1grade='NR',e2grade='NR' where StudentId='"+rs11.getString(1)+"'");
            }                           
                        
                        
                        
	}
        
	ResultSet rs = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId, StudentName from "+stream_table+"");
	String[] temp=null;
	String query="", query1="", query2="",query3="",query4="", att_table1="",att_table2="",att_table3="",att_table4="";
	int count=0;
        
        System.out.println(year +"  "+month);
        String s="";
        if(month <6)
            s ="Winter";
        if(month >=6)
            s ="Monsoon";
        String m;
        String attendancetable=s+"_"+year;
        String assessmenttable="Assessment_"+s+"_"+year;
        System.out.println(attendancetable);
        
        
	while(rs.next())
	{
		temp = request.getParameterValues(rs.getString(1));
                String sid=rs.getString(1);
                if(temp==null)
                        {
                         Statement st20=(Statement)con.createStatement();
                                ResultSet rs1=(ResultSet)st20.executeQuery("select course_name from elective_table where "+stream+"!=0");
				
                                while(rs1.next())
                                    {
                                      //System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
                                    //String k=rs1.getString(1);
                                    //System.out.println(k);
                                     st12.executeUpdate("delete from "+attendancetable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                      st13.executeUpdate("delete from "+assessmenttable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                    }
                        
                        }
		if(temp!=null)
		{
                        
			if(temp.length ==1)
			{
                                Statement st20=(Statement)con.createStatement();
                                ResultSet rs1=(ResultSet)st20.executeQuery("select course_name from elective_table where "+stream+"!=0");
				
                                while(rs1.next())
                                    {
                                      //System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
                                    //String k=rs1.getString(1);
                                    //System.out.println(k);
                                     st12.executeUpdate("delete from "+attendancetable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                      st13.executeUpdate("delete from "+assessmenttable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                    }
                                query = "update "+stream_table+" set "+col1+" = '"+temp[0]+"' where StudentId='"+rs.getString(1)+"'";
                                m="e"+col1.substring(3,4)+"grade";
                                //query = "update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
				att_table1=attendancetable+"_"+temp[0];
				query1="insert into "+att_table1+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
                                st13.executeUpdate("insert into "+assessmenttable+"_"+temp[0]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
			}
			else if(temp.length ==2)
			{
                                Statement st20=(Statement)con.createStatement();
                                ResultSet rs1=(ResultSet)st20.executeQuery("select course_name from elective_table where "+stream+"!=0");
				
                                while(rs1.next())
                                    {
                                     // System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
                                    //String k=rs1.getString(1);
                                    //System.out.println(k);
                                     st12.executeUpdate("delete from "+attendancetable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                      st13.executeUpdate("delete from "+assessmenttable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                    }        
				query = "update "+stream_table+" set "+col1+" = '"+temp[0]+"', "+col2+" ='"+temp[1]+"' where StudentId='"+rs.getString(1)+"'";
                                m="e"+col1.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                m="e"+col2.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
				att_table1=attendancetable+"_"+temp[0];
				query1="insert into "+att_table1+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
				st13.executeUpdate("insert into "+assessmenttable+"_"+temp[0]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                                att_table2=attendancetable+"_"+temp[1];
				query2="insert into "+att_table2+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
			        st13.executeUpdate("insert into "+assessmenttable+"_"+temp[1]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                        }
			else if(temp.length ==3)
			{
                                Statement st20=(Statement)con.createStatement();
                                ResultSet rs1=(ResultSet)st20.executeQuery("select course_name from elective_table where "+stream+"!=0");
				
                                while(rs1.next())
                                    {
                                      //System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
                                    //String k=rs1.getString(1);
                                    //System.out.println(k);
                                     st12.executeUpdate("delete from "+attendancetable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                      st13.executeUpdate("delete from "+assessmenttable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                    }
				query = "update "+stream_table+" set "+col1+" = '"+temp[0]+"', "+col2+" ='"+temp[1]+"', "+col3+" ='"+temp[2]+"' where StudentId='"+rs.getString(1)+"'";
                                m="e"+col1.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                m="e"+col2.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                m="e"+col3.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
				att_table1=attendancetable+"_"+temp[0];
				query1="insert into "+att_table1+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
				st13.executeUpdate("insert into "+assessmenttable+"_"+temp[0]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                                att_table2=attendancetable+"_"+temp[1];
				query2="insert into "+att_table2+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
				st13.executeUpdate("insert into "+assessmenttable+"_"+temp[1]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                                att_table3=attendancetable+"_"+temp[2];
				query3="insert into "+att_table3+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
			        st13.executeUpdate("insert into "+assessmenttable+"_"+temp[2]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                        }
			else if(temp.length ==4)
			{
                                Statement st20=(Statement)con.createStatement();
                                ResultSet rs1=(ResultSet)st20.executeQuery("select course_name from elective_table where "+stream+"!=0");
				
                                while(rs1.next())
                                    {
                                      //System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
                                    //String k=rs1.getString(1);
                                    //System.out.println(k);
                                     st12.executeUpdate("delete from "+attendancetable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                      st13.executeUpdate("delete from "+assessmenttable+"_"+rs1.getString(1)+" where StudentId='"+rs.getString(1)+"'");
                                    }
				query = "update "+stream_table+" set "+col1+" = '"+temp[0]+"', "+col2+" ='"+temp[1]+"', "+col3+" ='"+temp[2]+"', "+col4+" ='"+temp[3]+"' where StudentId='"+rs.getString(1)+"'";
				m="e"+col1.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                m="e"+col2.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                m="e"+col3.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                m="e"+col4.substring(3,4)+"grade";
                                st12.executeUpdate("update "+stream_table+" set "+m+" = 'R' where StudentId='"+rs.getString(1)+"'");
                                att_table1=attendancetable+"_"+temp[0];
				query1="insert into "+att_table1+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
				st13.executeUpdate("insert into "+assessmenttable+"_"+temp[0]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                                att_table2=attendancetable+"_"+temp[1];
				query2="insert into "+att_table2+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
				st13.executeUpdate("insert into "+assessmenttable+"_"+temp[1]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                                att_table3=attendancetable+"_"+temp[2];
				query3="insert into "+att_table3+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
				st13.executeUpdate("insert into "+assessmenttable+"_"+temp[2]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                                att_table4=attendancetable+"_"+temp[3];
				query4="insert into "+att_table4+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')";
			        st13.executeUpdate("insert into "+assessmenttable+"_"+temp[3]+"(StudentId, StudentName) values('"+rs.getString(1)+"','"+rs.getString(2)+"')");
                        }
			try{
				
				if(temp.length ==1)
				{
					ConnectionDemo.getStatementObj().executeUpdate(query);
					ConnectionDemo.getStatementObj().executeUpdate(query1);
				}
				else if(temp.length ==2)
				{
					ConnectionDemo.getStatementObj().executeUpdate(query);
					ConnectionDemo.getStatementObj().executeUpdate(query1);
					ConnectionDemo.getStatementObj().executeUpdate(query2);
				}
				else if(temp.length ==3)
				{
					ConnectionDemo.getStatementObj().executeUpdate(query);
					ConnectionDemo.getStatementObj().executeUpdate(query1);
					ConnectionDemo.getStatementObj().executeUpdate(query2);
					ConnectionDemo.getStatementObj().executeUpdate(query3);
				}
				else if(temp.length ==4)
				{
					ConnectionDemo.getStatementObj().executeUpdate(query);
					ConnectionDemo.getStatementObj().executeUpdate(query1);
					ConnectionDemo.getStatementObj().executeUpdate(query2);
					ConnectionDemo.getStatementObj().executeUpdate(query3);
					ConnectionDemo.getStatementObj().executeUpdate(query4);
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		}
		//break;
	}
        if(value.equals("SAVE")==true)
        {System.out.println("lllllll"+stream);
            %>
           <script type="text/javascript" language="JavaScript">
                 check('<%=stream%>');  
           </script>
           <%
        }
	rs.close();
	
	ResultSet rs1 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId, StudentName, "+col+" from "+stream_table+"");
%>
<!--
<table width="100%" align="center" class="head_pos">
	<tr>
		<td align="center" class="style30"><u><h2>Elective Registration For <%=stream %></h2></u></td>
	</tr>
	<tr>
		<td align="left" class="style31"><b>Selected Elective List for each Student</b></td>
	</tr>
</table>
-->
<table width="100%" align="center">
        <tr>
		<td align="center" class="style30">University of Hyderabad</td>
	</tr>
        <tr>
		<td align="center" class="style30">Department of Computer and Information Sciences</td>
	</tr>
	<tr>
		<td align="center" class="style30">Selected Elective List for <%=stream1 %></td>
	</tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
</table>

<table width="100%" align="center">
	
	<tr>
		<td>
                    <table align="center" border="1" cellspacing="0" cellpadding="0">
			<tr>
				<td class="style30" align="center" width="50" ><b>S.No</b></td>
                                <td class="style30" align="center" width="100"><b>Student Id</b></td>
				<td class="style30" align="center" width="300"><b>Student Name</b></td>
				<%
					i=course_count;
					int k=0;
					while(i!=0)
					{
				%>
				<td class="style30" align="center" width="90"><b>Elective <%=++k %></b></td>
				<%
						i--;
					}
					i=0;
				%>		
			</tr>
			
			<%
				while(rs1.next())
				{
					int j=3;
			%>
			<tr>
				<td align="center" width="50"><%=++i %></td>
                                <td align="center" width="100"><%=rs1.getString(1) %></td>
				<td align="center" width="300"><%=rs1.getString(2) %></td>
				<% 
					for(j=3; j<=course_count+2; j++)
					{
				%>
				<td align="center" width="90"><%=rs1.getString(j) %></td>
				<%
					}
				%>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
                </br>
                </br>
                </br>
           <%
           Statement st6=(Statement)con.createStatement();
           ResultSet rs15=(ResultSet)st6.executeQuery("select Code, Subject_Name , "+stream+" from subjecttable as a, elective_table as b where a.Code=b.course_name and b."+stream+"!=0");
           %>     
                <table width="100%" align="center" border="1">
                    <tr>
                        <th>Subject Id</th>
                        <th>Subject Name</th>
                    </tr>
                   <%
                     while(rs15.next())
                      {
                      %>
                      <tr>
                          <td><center><%=rs15.getString(1)%></center></td>
                          <td><center><%=rs15.getString(2)%></center></td>
                      </tr>
                     <% }
                     %>
                </table>    
                </br>
                <div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" onclick="p1();" />
</div>
</body>
</html>