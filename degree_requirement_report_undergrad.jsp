<!DOCTYPE html>
<html>
<head>
    <title>Classes Taken By Student Report Form</title>
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
                            <form action="degree_requirement_report_undergrad.jsp" method="get">
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
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT PID FROM students WHERE graduate_status = 'Undergraduate'");
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
                            <form action="degree_requirement_report_undergrad.jsp" method="get">
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
                        %>
                            <tr>
                                <form action="degree_requirement_report_undergrad.jsp" method="get">
                                    <td><input type="text" name="PID" value="<%= rs.getString("PID") %>" size="10" /></td>
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
                <table>
                    <thead>
                        <tr>
                            <th>DegreeName</th>
                            <th>Category/Department</th>
                            <th>MinUnits</th>
                        </tr>
                        <tr>
                            <form action="degree_requirement_report_undergrad.jsp" method="get">
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
                                                PreparedStatement pstmt = conn2.prepareStatement("SELECT degree_name FROM degree_requirements WHERE degree_name NOT LIKE 'MSC%' AND degree_name NOT LIKE 'PHD%' GROUP BY degree_name");
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
                                <input type="submit" value="Show Degree Requirements" />
                            </form>
                        </tr>
                    <% 
                        Connection conn3 = null;
                        PreparedStatement pstmt3 = null;
                        ResultSet rs3 = null;
                        try {
                            Class.forName("org.postgresql.Driver");
                            conn3 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                            
                            // Check if any form data was submitted
                            String action = request.getParameter("action");
                            if (action != null && action.equals("show_degree_requirements")) {
                                conn3.setAutoCommit(false);
                               
                                // Retrieve all student attributes given the PID
                                String degreeName = request.getParameter("DegreeName");
                                String sql = "SELECT departments.department_name, degree_requirements.degree_name, category_name, SUM(min_units) AS total_min_units " +
             "FROM departments " +
             "JOIN degree_requirements ON departments.department_name = degree_requirements.department_name " +
             "WHERE degree_requirements.degree_name = ? " +
             "GROUP BY departments.department_name, degree_requirements.degree_name, category_name";
                                pstmt3 = conn3.prepareStatement(sql);
                                pstmt3.setString(1, request.getParameter("DegreeName"));
                                rs3 = pstmt3.executeQuery();
                                conn3.commit();
                                conn3.setAutoCommit(true);
                                boolean hasResults = false;
                                String firstDegreeName = "";
                                String firstDepartmentName = "";
                                int totalMinUnits = 0;
                                while (rs3.next()) {
                                    if (!hasResults) {
                                        hasResults = true;
                                        firstDegreeName = rs3.getString("degree_name");
                                        firstDepartmentName = rs3.getString("department_name");
                                    }
                    %>
                                    <tr>
                                        <form action="degree_requirement_report_undergrad.jsp" method="get">
                                            <td><input type="text" name="DegreeName" value="<%= rs3.getString("degree_name") %>" size="15" /></td>
                                            <td><input type="text" name="Category" value="<%= rs3.getString("category_name") %>" size="17" /></td>
                                            <td><input type="text" name="MinUnits" value="<%= rs3.getInt("total_min_units") %>" size="7" /></td>
                                        </form>
                                    </tr>
                    <%
                                    totalMinUnits += rs3.getInt("total_min_units");
                                }
                                // Add new row that displays the sum of the min_units
                    %>
                                <tr>
                                    <form action="degree_requirement_report_undergrad.jsp" method="get">
                                        <td><input type="text" name="DegreeName" value="<%= firstDegreeName %>" size="15" /></td>
                                        <td><input type="text" name="Category" value="<%= firstDepartmentName %>" size="17" /></td>
                                        <td><input type="text" name="MinUnits" value="<%= totalMinUnits %>" size="7" /></td>
                                    </form>
                                </tr>
                    <%
                                
                            }
                        } catch (Exception e) {
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