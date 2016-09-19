<%-- 
    Document   : id_parser
--%>
<%
    /*   We will get the university name from the initialization, and it will stored in the  "curr_univ". 
     *   In this page we will have all the universities student id parsing schema,
     *   for example :  
     *                  Univerisity of Hyderabad
     *                  student id : 12MCMC20
     *                               01234567
     * 
     *                               12--> year                          (0 to 1)     
     *                               MC--->SCIS                          (2 to 3)
     *                               MC/MT/MI/MB---->programe code:  MCA (4 to 5)
     *                               28----> roll number.                (6 to 7)
     *   String curr_univ = "Univerisity of Hyderabad"; // this will contains current univerisity name.
     */

    String curr_univ = "Univerisity of Hyderabad";
    String  CENTURY ="20"; // FOR 20TH CENTURY GIVE 20. eg : 2000,2001,.. 2014,..
    int SYEAR_PREFIX = 0; // contians batch year starting location in the string.
    int EYEAR_PREFIX = 0; // contians batch year ending location in the string.
    
    int SPRGM_PREFIX = 0; //Contains program code start
    int EPRGM_PREFIX = 0; //Contains program code end
    
    if (curr_univ.equalsIgnoreCase("Univerisity of Hyderabad")) {
        SYEAR_PREFIX = 0;
        EYEAR_PREFIX = 1;
        
        SPRGM_PREFIX = 4;
        EPRGM_PREFIX = 5;
    } else if (curr_univ.equalsIgnoreCase("JNTU HYDERABAD")) {
        // student id example formate : 08 49 1A0 5C2
        //                              01 23 456 789                              
        SYEAR_PREFIX = 0;
        EYEAR_PREFIX = 1;
        
        SPRGM_PREFIX = 4; // Contains program code start
        EPRGM_PREFIX = 6;  //Contains program code end
    }
    
    // After adding all the universities, at final line increment the end positions, since substring we have to give end position +1;
    
    // mandatory line 
    EPRGM_PREFIX=EPRGM_PREFIX+1;
    EYEAR_PREFIX=EYEAR_PREFIX+1;
    
    /*
     * Now you can use the above prefixes to get batch year, programe name by using substring on the student id.\
     * example :  student_id ="12mcmi29.
     * String PROGRAMME_NAME = student_id.substring(SPRGM_PREFIX,EPRGM_PREFIX);
     * int   BATCH_YEAR     =Integer.parseInt( CENTURY+student_id.substring(SYEAR_PREFIX,EYEAR_PREFIX));
     *
     */
%>
 
