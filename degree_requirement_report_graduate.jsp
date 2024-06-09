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
                            <th>Degree Name</th>
                            <th>Category/Department</th>
                            <th>Units Left</th>
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
                               
                                // Retrieve all student attributes given the PID
                                String degreeName = request.getParameter("DegreeName");
                                String sql = "SELECT degree_name, department_name, category_name, min_units " +
                                                "FROM degree_requirements " +
                                                "WHERE degree_name = ? ";
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

                                    // Get the units taken by the student in the category
                                    String category_name = rs3.getString("category_name");
                                    String xsql = 
                                        "SELECT SUM(pe.units) AS units_taken " +
                                        "FROM past_enrollment pe " +
                                        "JOIN students s ON pe.student_pid = s.pid " +
                                        "JOIN classes cls ON pe.class_id = cls.class_id " +
                                        "JOIN category_consists_of cco ON cls.course_id = cco.course_id " +
                                        "WHERE pe.student_pid = ? " +
                                        "AND cco.category_name = ?";
                                    PreparedStatement pstmt4 = conn3.prepareStatement(xsql);
                                    pstmt4.setString(1, request.getParameter("hiddenPID"));
                                    pstmt4.setString(2, category_name);
                                    ResultSet rs4 = pstmt4.executeQuery();
                                    int categoryUnitsTaken = 0;
                                    if (rs4.next()) {
                                        categoryUnitsTaken = rs4.getInt("units_taken");
                                    }
                                    rs4.close();
                                    pstmt4.close();
                    %>
                                    <tr>
                                        <form action="degree_requirement_report_graduate.jsp" method="get">
                                            <td><input type="text" name="DegreeName" value="<%= rs3.getString("degree_name") %>" size="25" /></td>
                                            <td><input type="text" name="Category" value="<%= rs3.getString("category_name") %>" size="22" /></td>
                                            <td><input type="text" name="Units Left" value="<%= rs3.getInt("min_units") - categoryUnitsTaken %>" size="9" /></td>
                                        </form>
                                    </tr>
                    <%
                                    totalMinUnits += rs3.getInt("min_units") - categoryUnitsTaken;
                                }
                                // Add new row that displays the sum of the min_units
                    %>
                                <tr>
                                    <form action="degree_requirement_report_graduate.jsp" method="get">
                                        <td><input type="text" name="DegreeName" value="<%= firstDegreeName %>" size="25" /></td>
                                        <td><input type="text" name="Category" value="<%= firstDepartmentName %>" size="22" /></td>
                                        <td><input type="text" name="Units Left" value="<%= totalMinUnits %>" size="9" /></td>
                                    </form>
                                </tr>
                    <%
                                
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