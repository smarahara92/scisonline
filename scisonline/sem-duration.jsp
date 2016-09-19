    <%-- 
    Document   : sem-duration
--%>
<%@include file="checkValidity.jsp"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
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

            #bold
            {

                font-weight: bold;
            }

        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
              
            function fun1(){
                document.getElementById("stream").focus();
                document.getElementById("year1").focus();
                 
                d = new Date();
                curr_year = d.getFullYear();
                //curr_year=curr_year+1;
             
    
                //   
                for(i = 0; i < 6; i++)
                {  
                    document.getElementById('year1').values[i] = new Option(curr_year-i+1,curr_year-i+1);
                    document.getElementById('year1').options[i] = new Option(curr_year-i+1,curr_year-i+1);
                    document.getElementById('year1').values[i] = new Value(curr_year-i+1,curr_year-i+1);
                }
            } 
             
            // for new, here we cal page for start date, end date. 
            function open1(){
                document.frm2.action="sem-duration_old.jsp";
                //document.frm2.target="right_f";
                document.frm2.submit();
            }
             
            // for modify
            function open2(){
                document.frm2.action="sub-faconline_modify.jsp";
                // document.frm2.target="right_f";
                document.frm2.submit();
            }
             
            // for delete all
            function open3(){
                
                var x;
                var r=confirm("Delete whole allocation ? ");
                if (r===true)
                {
                    document.frm2.action="sub-faconline_delete.jsp";
                    // document.frm2.target="right_f";
                    document.frm2.submit();
                }
            }
             
             
            // for view
            function open4(){ 
               
                document.frm2.action="sub-faconline_view.jsp";
                // document.frm2.target="right_f";
                document.frm2.submit();
            }
            
            function prgmtables(){
                
                //alert("srinivas");
            <%

                Calendar now2 = Calendar.getInstance();


                int system_year = now2.get(Calendar.YEAR);

                Statement st1 = (Statement) con.createStatement();
                 Statement st2 = (Statement) con.createStatement();
                int count1 = 0; //ResultSet rs1 = null;


                st1.executeUpdate("create table if not exists session_course_registration(session varchar(20),year varchar(20),limits varchar(10),registration	varchar(10),primary key(session,year))");

                // Note :         
                // the fallowing tables has to be created at the programme management module, since they are not done with these, i have created these table here statically. if these tables aleardy created then fallowing code wont be exectuted.           
                st2.executeUpdate("drop table if exists Winter_stream" );
                 st2.executeUpdate("drop table if exists Monsoon_stream" );
                
                st1.executeUpdate("create table if not exists Winter_stream(sname varchar(20),electives varchar(20),primary key(sname))");
                st1.executeUpdate("create table if not exists Monsoon_stream(sname varchar(20),electives varchar(20),primary key(sname))");



                String str[] = new String[15]; // I TOOK ONLY 12 SEMESTERS
                str[1] = "I";
                str[2] = "II";
                str[3] = "III";
                str[4] = "IV";
                str[5] = "V";
                str[6] = "VI";
                str[7] = "VII";
                str[8] = "VIII";
                str[9] = "IX";
                str[10] = "X";
                str[11] = "XI";
                str[12] = "XII";
                int active_year = system_year;
                Statement st10_prgm = (Statement) con.createStatement();
                String program_name = "";
                ResultSet rs10_prgm = (ResultSet) st10_prgm.executeQuery("select Programme_name from programme_table where Programme_status='1' and Programme_name!='PhD'");
                while (rs10_prgm.next()) {
                    int year1 = active_year;
                    program_name = rs10_prgm.getString(1);

                    program_name = program_name.replace("-", "_");
                    System.out.println(program_name);
                    for (int i = 1; i <= 12;) {

                        /*
                         *code for taking latest curriculum
                         */
                        
                        int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
                        Statement st10_cur = (Statement) con.createStatement();

                        ResultSet rs10_cur = st10_cur.executeQuery("select * from " + program_name + "_curriculumversions order by Year desc");
                        while (rs10_cur.next()) {
                            curriculumYear = rs10_cur.getInt(1);

                            if (curriculumYear <= active_year) {

                                latestYear = curriculumYear;
                                System.out.println(latestYear);
                                break;
                            }
                        }
                        
                        // latest curiculum done.
                        
                        // testing program semester corresponding batch . eg mtech-ai-ii is 2013 batch in 2014.
                        System.out.println(program_name+"-"+str[i]+ "batch "+year1);
                        
                        System.out.println("curr year" + latestYear);
                        // now take the currefer table, and see for the given semester (eg I,II,..VI) entry exists or not in the curerer table.
                        Statement st10_refer = (Statement) con.createStatement();
                        Statement st10_refer2 = (Statement) con.createStatement();
                        //MTech_CS_2012_currrefer
                        program_name = program_name.replace("-", "_");
                      String  program_name_2=program_name.replace("_", "-");
                        ResultSet rs10_refer = st10_refer.executeQuery("select * from " + program_name + "_" + latestYear + "_currrefer where Semester='" + str[i] + "'");
                        if (rs10_refer.next()) {
                            //System.out.println("sem " + str[i] + "exists for" + program_name + " " + str[i]);

                            ResultSet rs10_refer2 = st10_refer2.executeQuery("select * from " + program_name + "_" + latestYear + "_currrefer where Semester='" + str[i] + "'   AND Electives !=0");
                            if (rs10_refer2.next()) {
                               // System.out.println("sem " + str[i] + "exists and elective also exists for" + program_name + " " + str[i]);
                                if (i % 2 != 0) {
                                    st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('"+program_name_2+"-"+str[i]+"','yes')");
                                } else {
                                    st1.executeUpdate("insert into Winter_stream(sname,electives) values('"+program_name_2+"-"+str[i]+"','yes')");
                                }

                            } else {
                              //  semester exists but elective does not.
                                 if (i % 2 != 0) {
                                    st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('"+program_name_2+"-"+str[i]+"','no')");
                                } else {
                                    st1.executeUpdate("insert into Winter_stream(sname,electives) values('"+program_name_2+"-"+str[i]+"','no')");
                                }
                               // System.out.println("sem " + str[i] + "exists and no elective for" + program_name + " " + str[i]);
                            }
                            i++;
                            if (i % 2 == 0) {
                                year1 = year1 - 1;
                            }
                            rs10_refer2.close();
                        } else {
                            i = 13; // stop when no more semester for given programe.
                        }
                        rs10_refer.close();
                        rs10_cur.close();
                        st10_cur.close();
                        st10_refer.close();
                        st10_refer2.close();
                    }
                }


// the above tables winter_stream, monsoon_strem has been created.




                // st1.executeUpdate("create table if not exists programme(pname varchar(20),active varchar(20),primary key(pname))");
                // comented on 20-1-14 $$$$$$$$$$$$$$$$$$$$$$$$$$4
                    /*
                 DatabaseMetaData md = con.getMetaData();
          
                 ResultSet rs_stream = md.getTables(null, null, "Winter_stream", null);
                    
     
                 if (!(rs_stream.next())) {
                                         

                
                 st1.executeUpdate("create table if not exists Winter_stream(sname varchar(20),electives varchar(20),primary key(sname))");
                 st1.executeUpdate("create table if not exists Monsoon_stream(sname varchar(20),electives varchar(20),primary key(sname))");
                 // st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective(course_name,MCA_I,MCA_II,MCA_III,MCA_IV,MCA_V,MCA_VI,MTech_CS_I,MTech_CS_II,MTech_CS_III,MTech_CS_IV,MTech_AI_I,MTech_AI_II,MTech_AI_III,MTech_AI_IV,MTech_IT_I,MTech_IT_II,MTech_IT_III,MTech_IT_IV) values('" + sub + "',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)");
                         
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MTech-AI-I','yes')");
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MTech-AI-III','no')");
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MTech-CS-I','yes')");                                       
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MTech-CS-III','no')");              
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MCA-I','no')");            
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MCA-III','yes')");            
                 st1.executeUpdate("insert into Monsoon_stream(sname,electives) values('MCA-V','yes')");            
                   


                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MTech-AI-II','yes')");
                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MTech-AI-IV','no')");
                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MTech-CS-II','yes')");                                       
                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MTech-CS-IV','no')");              
                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MCA-II','no')");            
                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MCA-IV','yes')");            
                 st1.executeUpdate("insert into Winter_stream(sname,electives) values('MCA-VI','no')");  
      


                 }
                 */

            
                rs10_prgm.close();
                st1.close();
                st2.close();
                st10_prgm.close();
%>
                }
            
      
  
        </script>


    </head>
    <%


        Calendar now = Calendar.getInstance();


        int sys_year = now.get(Calendar.YEAR);
        int next_year = sys_year + 1;
        int prev_year1 = sys_year - 1;
        int prev_year2 = sys_year - 2;
        int prev_year3 = sys_year - 3;
        int prev_year4 = sys_year - 4;
        int prev_year5 = sys_year - 5;

    %> 
    <body  onload="prgmtables();">
        <table width="100%">
            <tr>
                <th colspan="5" class="style30" align="center"><font size="6">Course Allocation</font></th>

            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        <form name="frm2" method="POST">
            <table align="center" border="1">
                <tr>
                    <th class="heading" align="center">Session</th>
                    <th class="heading" align="center">Year</th>

                </tr>
                <tr>
                    <td class="style30">

                        <select  id="stream" name="current_session" >
                            <option value="none" > Select Session </option>
                            <option value="Winter" > Winter </option>
                            <option value="Monsoon">Monsoon</option>
                        </select></td>
                    <td>
                        <select name="year2" id="year1" style="width:200px;" >
                            <option value="none">Select Year</option>
                            <option value="<%=next_year%>"><%=next_year%></option>
                            <option value="<%=sys_year%>"><%=sys_year%></option>
                            <option value="<%=prev_year1%>"><%=prev_year1%></option>
                            <option value="<%=prev_year2%>"><%=prev_year2%></option>
                            <option value="<%=prev_year3%>"><%=prev_year3%></option>

                        </select>
                    </td>              
                </tr>      
            </table>
            <table align = "center">
                <tr>
                    <td id = "erMsg"></td>
                </tr>
            </table>
            <br>
            <table align="center">

                <tr><td colspan="2" align="center" id="bold">
                        <input type="button" id="newbtn" name="new" value="New" style="height: 28px; width: 80px" onclick="open1();" disabled="disabled">&nbsp;
                        <input type="button"  id="modifybtn" name="modify" value="Modify" style="height: 28px; width: 80px" onclick="open2();" disabled="disabled" />&nbsp;

                        <input type="button" name="deleteall" id="deletebtn" value="Delete All" style="height: 28px; width: 80px" disabled="disabled"  onclick="open3();">
                        <input type="button" name="view" id="viewbtn" value="View" style="height: 28px; width: 80px" disabled="disabled" onclick="open4();">
                    </td>
                </tr>
            </table>

        </form>




        <script>
 
            $( "select" ).change(function() {   // to call when we select the value in the drop down box. note if use "#year1 instead of "#year1 option we will get weired response.
                var year=$("#year1").val(); 
                var stream=$("#stream").val();
          
                if((year!=="none") && (stream!=="none"))    
                {   
                    document.getElementById("erMsg").innerHTML = "";
                    $.ajax({
                        url:"checkonserver.jsp",
                        data: {selectedYear : year, stream: stream},
                        success:function(msg){
                            // alert(msg);   //msg contains respons from ajax in the form xml
             
                            var xml =msg, // xml should be like this "<html><head><title>JSP Page</title></head><body>It's HOT</body></html> ",
                            xmlDoc = $.parseXML( xml ),
                            $xml = $( xmlDoc ),
                            $title = $xml.find( "body" );
                            var test= $title.text();
                            if(test.contains("00"))
                            {   
                                document.getElementById("newbtn").disabled=false;
                                document.getElementById("modifybtn").disabled=true;
                                document.getElementById("deletebtn").disabled=true;
                                document.getElementById("viewbtn").disabled=true;
                                //alert("00");
                            }
                            else if(test.contains("10")){
                                document.getElementById("newbtn").disabled=true;
                                document.getElementById("modifybtn").disabled=false;
                                document.getElementById("deletebtn").disabled=false;
                                document.getElementById("viewbtn").disabled=false;
                                // alert("10");
                            }
                            else if(test.contains("11")){
                                document.getElementById("newbtn").disabled=true;
                                document.getElementById("modifybtn").disabled=false;
                                document.getElementById("deletebtn").disabled=true;
                                document.getElementById("viewbtn").disabled=false;
                                //alert("11");
                            }
    
                            // Append "RSS Title" to #someElement
                            //$( "#someElement" ).append( $title.text() );
                        }
                    });
                }
                else{
                    document.getElementById("newbtn").disabled=true;
                    document.getElementById("modifybtn").disabled=true;
                    document.getElementById("deletebtn").disabled=true;
                    document.getElementById("viewbtn").disabled=true;
                    
                    if((year==="none") && (stream==="none")) {
                        document.getElementById("erMsg").innerHTML = "*Select Session and year";
                    } else if(year !== "none") {
                        document.getElementById("erMsg").innerHTML = "*Select Session";
                    } else {
                        document.getElementById("erMsg").innerHTML = "*Select Year";
                        //alert("Select Session and year");
                    }
                }
           
            });

        </script>
    </body>
</html>
<%
    try {
        con.close();
        con1.close();
        con2.close();
    } catch (Exception e) {
        System.out.println(e);
    } finally {
        con.close();
        con1.close();
        con2.close();
    }
%>