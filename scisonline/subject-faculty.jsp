<%-- 
    Document   : subject-faculty
    Created on : Jan 6, 2012, 5:55:40 PM
    Author     : jagan
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST">
                    <input type="hidden" name="check" value="4" />
                    
                    
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr> <th colspan="2"><font size="6">Subject-Faculty Information of Semester</font></th></tr>
                        <tr><td><table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr><th><font size="5">Session Date:</font></th>
                            <td><font size="5">Day</font><select name="text1">
                                    <option>1</option><option>2</option>
                                    <option>3</option><option>4</option>
                                    <option>5</option><option>6</option>
                                    <option>7</option><option>8</option>
                                    <option>9</option><option>10</option>
                                    <option>11</option><option>12</option>
                                    <option>13</option><option>14</option>
                                    <option>15</option><option>16</option>
                                    <option>17</option><option>18</option>
                                    <option>19</option><option>20</option>
                                    <option>21</option><option>22</option>
                                    <option>23</option><option>24</option>
                                    <option>25</option><option>26</option>
                                    <option>27</option><option>28</option>
                                    <option>29</option><option>30</option>
                                    <option>31</option>
                                  </select></td>
                                  <td><font size="5">Month</font><select name="text2">
                                          <option>Jan</option>
                                          <option>Feb</option>
                                          <option>Mar</option>
                                          <option>Apr</option>
                                          <option>May</option>
                                          <option>Jun</option>
                                          <option>Jul</option>
                                          <option>Aug</option>
                                          <option>Sep</option>
                                          <option>Oct</option>
                                          <option>Nov</option>
                                          <option>Dec</option>
                                      </select></td>
                                      <td><font size="5">Year</font><select name="text3">
                                              <option>2012</option>
                                              <option>2013</option>
                                              <option>2014</option>
                                              <option>2015</option>
                                              <option>2016</option>
                                              <option>2017</option>
                                              <option>2018</option>
                                              <option>2019</option>
                                              <option>2020</option>
                                              <option>2021</option>
                                          </select></td></tr>
                        
                    </table></td><tr>
                        <tr><td align="center"><font size="5">Upload the subject_faculty file(.csv)</font></td></tr>
                        
                    <tr><td colspan="2" align="center"><input type="file" name="file1" />
			<input type="Submit" value="Upload File" /><br></td></tr>
                    </table>
		</form>
    </body>
    
</html>
