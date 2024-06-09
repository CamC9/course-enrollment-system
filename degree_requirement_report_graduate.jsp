<!DOCTYPE html>
<html>
<head>
    <title>Graduate Student Remaining Units Report Form</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function updateUndergradPID() {
            var UndergradPID = document.getElementById('UndergradPIDSelect').value;
            document.getElementById('selectedUndergradPID').value = UndergradPID;
        }
        function updateDegreeName() {
            var DegreeName = document.getElementById('DegreeNameSelect').value;
            document.getElementById('selectedDegreeName').value = DegreeName;
        }
        window.onload = function() {
            updateUndergradPID();  // The initial PID is now set when the page loads
            updateDegreeName();
        }
    </script>
</head>
<body>
    <table>
        <tr>
            <td>
                <%@ page import="java.sql.*" %>
                <jsp:include page="menu.html" />
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <th>PID</th>
                            <th>First</th>
                            <th>Middle</th>
                            <th>Last</th>
                        </tr>
                        <tr>
                            <form action="degree_requirement_report_graduate.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="submit" value="Select Student" />
                                <select name="UndergradPID" id="UndergradPIDSelect" onchange="updateUndergradPID()">
                                    <% 
                                        Connection conn1 = null;
                                        Statement stmt1 = null;
                                        ResultSet rs1 = null;
                                        try {
                                            Class.forName("org.postgresql.Driver");
                                            conn1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                            stmt1 = conn1.createStatement();
                                            
                                            String action = request.getParameter("action");
                                            if (action != null && action.equals("select")) {
                                                conn1.setAutoCommit(false);
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT PID FROM students WHERE graduate_status = 'Postgraduate'");
                                                rs1 = pstmt.executeQuery();
                                                conn1.commit();
                                                conn1.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs1.next()) {
                                                String PID = rs1.getString("PID");
                                                %>
                                                <option value="<%= PID %>"><%= PID%></option>
                                                <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            try {
                                                if (rs1 != null) {
                                                    rs1.close();
                                                }
                                                if (stmt1 != null) {
                                                    stmt1.close();
                                                }
                                                if (conn1 != null) {
                                                    conn1.close();
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    %>
                                </select>
                            </form>
                        </tr>
                        <tr>
                            <form action="degree_requirement_report_graduate.jsp" method="get">
                                <input type="hidden" name="action" value="show_undergrad_details" />
                                <input type="hidden" name="UndergradPID" id="selectedUndergradPID" />
                                <input type="hidden" name="DegreeName" id="selectedDegreeName" />
                                <input type="submit" value="Show Student Details" />
                            </form>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("org.postgresql.Driver");
                                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                stmt = conn.createStatement();
                                
                                // Check if any form data was submitted
                                String action = request.getParameter("action");
                                if (action != null && action.equals("show_undergrad_details")) {
                                    conn.setAutoCommit(false);
                                   
                                    // Retrieve all student attributes given the PID
                                    PreparedStatement pstmt = conn.prepareStatement(
                                        "SELECT * FROM students WHERE PID = ?");
                                    
                                    pstmt.setString(1, request.getParameter("UndergradPID"));
                                    rs = pstmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);

                                    while (rs.next()) {
                                        String pid = rs.getString("PID");
                        %>
                            <script>
                                localstorage.setItem("undergradPID", "<%= pid %>");
                            </script>
                            <tr>
                                <form action="degree_requirement_report_graduate.jsp" method="get">
                                    <td><input type="text" name="PID" value="<%= pid %>" size="10" /></td>
                                    <td><input type="text" name="First" value="<%= rs.getString("first") %>" size="13" /></td>
                                    <td><input type="text" name="Middle" value="<%= rs.getString("middle") %>" size="11" /></td>
                                    <td><input type="text" name="Last" value="<%= rs.getString("last") %>" size="11" /></td>
                                </form>
                            </tr>
                        <%
                                    }

                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Completed Concentrations </th>
                        </tr>
                        <tr>
                            <form action="degree_requirement_report_graduate.jsp" method="get">
                                <input type="hidden" name="action" value="show_degree_requirements" />
                                <select name="DegreeName" id="DegreeNameSelect" onchange="updateDegreeName()">
                                    <% 
                                        Connection conn2 = null;
                                        Statement stmt2 = null;
                                        ResultSet rs2 = null;
                                        try {
                                            Class.forName("org.postgresql.Driver");
                                            conn2 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                            stmt2 = conn2.createStatement();
                                            
                                            String action = request.getParameter("action");
                                            if (action != null && action.equals("show_undergrad_details")) {
                                                conn2.setAutoCommit(false);
                                                PreparedStatement pstmt = conn2.prepareStatement("SELECT degree_name FROM degree_requirements WHERE degree_name NOT LIKE 'BSC%' GROUP BY degree_name");
                                                rs2 = pstmt.executeQuery();
                                                conn2.commit();
                                                conn2.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs2.next()) {
                                                String degree_name = rs2.getString("degree_name");
                                                %>
                                                <option value="<%= degree_name %>"><%= degree_name %></option>
                                                <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            try {
                                                if (rs2 != null) {
                                                    rs2.close();
                                                }
                                                if (stmt2 != null) {
                                                    stmt2.close();
                                                }
                                                if (conn2 != null) {
                                                    conn2.close();
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    %>
                                </select>
                                <input type="hidden" name="DegreeName" id="selectedDegreeName" />
                                <input type="hidden" name="hiddenPID" id="hiddenPID" value="<%= request.getParameter("UndergradPID") %>" />
                                <input type="submit" value="Show Degree Requirements" />
                            </form>
                        </tr>
                    <% 
                        Connection conn3 = null;
                        PreparedStatement pstmt3 = null;
                        ResultSet rs3 = null;
                        String errorMessage = "";
                        try {
                            Class.forName("org.postgresql.Driver");
                            conn3 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                            
                            // Check if any form data was submitted
                            String action = request.getParameter("action");
                            if (action != null && action.equals("show_degree_requirements")) {
                                conn3.setAutoCommit(false);
                               
                                // Display the completed concentrations, which is defined by having the min_units met and the min_gpa met
                                String gradPID = request.getParameter("hiddenPID");
                                // Get the degree requirements for the selected degree
                                String degreeName = request.getParameter("DegreeName");
                                // Get completed concentrations for the student
                                String completedConcentrationsPt1SQL = "SELECT cc.concentration_name " +
                                                "FROM concentration_consists_of cc " +
                                                "JOIN classes cls ON cc.course_id = cls.course_id " +
                                                "JOIN past_enrollment pe ON cls.class_id = pe.class_id " +
                                                "WHERE pe.student_pid = ? AND cc.degree_name = ? AND pe.grade NOT LIKE 'IN%' " +
                                                "GROUP BY cc.concentration_name " +
                                                "HAVING SUM(pe.units) >= MIN(cc.min_units_concentration) ";
                                // Get rid of concentrations that don't have the minimum GPA
                                // Ignore courses taken for grading_type = 'S/U' for GPA calculation, but include them in the units calculation


                                pstmt3 = conn3.prepareStatement(completedConcentrationsPt1SQL);
                                pstmt3.setString(1, gradPID);
                                pstmt3.setString(2, degreeName);
                                rs3 = pstmt3.executeQuery();
                                conn3.commit();
                                conn3.setAutoCommit(true);
                                boolean hasResults = false;
                                while (rs3.next()) {
                    %>
                                    <tr>
                                        <form action="degree_requirement_report_graduate.jsp" method="get">
                                            <td><input type="text" name="ConcentrationName" value="<%= rs3.getString("concentration_name") %>" size="27" /></td>
                                        </form>
                                    </tr>
                    <%
                                    hasResults = true;
                                }
                                if (!hasResults) {
                    %>
                                    <tr>
                                        <td colspan="3">No concentrations have been completed for this student.</td>
                                    </tr>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            errorMessage = e.getMessage();
                            %> 
                            <tr>
                                <td colspan="3"><%= errorMessage %></td>
                            </tr>
                            <% 
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs3 != null) {
                                    rs3.close();
                                }
                                if (pstmt3 != null) {
                                    pstmt3.close();
                                }
                                if (conn3 != null) {
                                    conn3.close();
                                }
                            } catch (Exception e) {
                                errorMessage = e.getMessage();
                                %> 
                                <tr>
                                    <td colspan="3"><%= errorMessage %></td>
                                </tr>
                                <% 
                                e.printStackTrace();
                            }
                        }
                    %>
                    </thead>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>