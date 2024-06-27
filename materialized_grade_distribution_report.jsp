<!DOCTYPE html>
<html>
<head>
    <title>Materialized Multi-dimensional Grade Distribution Report Form</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/static/styles.css"> 
    <script>
        function updateCourseID() {
            var CourseID = document.getElementById('CourseIDSelect').value;
            document.getElementById('selectedCourseID').value = CourseID;
        }
        function updateFacultyName() {
            var FacultyName = document.getElementById('FacultyNameSelect').value;
            document.getElementById('selectedFacultyName').value = FacultyName;
        }
        function updateQuarter() {
            var Quarter = document.getElementById('QuarterSelect').value;
            document.getElementById('selectedQuarter').value = Quarter;
        }
        function updateYear() {
            var Year = document.getElementById('Year').value;
            document.getElementById('selectedYear').value = Year;
        }
        window.onload = function() {
            updateCourseID();  // The initial CourseID is now set when the page loads
            updateFacultyName();
            updateQuarter();
        }
    </script>
</head>
<body>
    <table>
        <tr>
            <td>
                <%@ page import="java.sql.*" %>
                <%@ include file="menu.html" %>
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <form action="materialized_grade_distribution_report.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="submit" value="Select Options" />
                                <select name="CourseID" id="CourseIDSelect" onchange="updateCourseID()">
                                    <% 
                                        Connection conn1 = null;
                                        Statement stmt1 = null;
                                        ResultSet rs1 = null;
                                        String errorMessage = "";
                                        try {
                                            Class.forName("org.postgresql.Driver");
                                            conn1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                            stmt1 = conn1.createStatement();
                                            
                                            String action = request.getParameter("action");
                                            if (action != null && action.equals("select")) {
                                                conn1.setAutoCommit(false);
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT course_id FROM courses");
                                                rs1 = pstmt.executeQuery();
                                                conn1.commit();
                                                conn1.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs1.next()) {
                                                String CourseID = rs1.getString("course_id");
                                                %>
                                                <option value="<%= CourseID %>"><%= CourseID %></option>
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
                                <select name="ProfessorName" id="FacultyNameSelect" onchange="updateFacultyName()">
                                    <% 
                                        Connection conn2 = null;
                                        Statement stmt2 = null;
                                        ResultSet rs2 = null;
                                        String errorMessageProf = "";
                                        try {
                                            Class.forName("org.postgresql.Driver");
                                            conn2 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                            stmt2 = conn2.createStatement();
                                            
                                            String action = request.getParameter("action");
                                            if (action != null && action.equals("select")) {
                                                conn2.setAutoCommit(false);
                                                PreparedStatement pstmt = conn2.prepareStatement("SELECT name FROM faculty");
                                                rs2 = pstmt.executeQuery();
                                                conn2.commit();
                                                conn2.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs2.next()) {
                                                String ProfessorName = rs2.getString("name");
                                                %>
                                                <option value="<%= ProfessorName %>"><%= ProfessorName %></option>
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
                                <select name="Quarter" id="QuarterSelect" onchange="updateQuarter()">
                                    <option value="Fall">Fall</option>
                                    <option value="Winter">Winter</option>
                                    <option value="Spring">Spring</option>
                                    <option value="Summer">Summer</option>
                                </select>
                                <input type="text" name="Year" id="Year" size="6" placeholder="Year" onchange="updateYear()" />
                            </form>
                        </tr>
                        <tr>
                            <form action="materialized_grade_distribution_report.jsp" method="get">
                                <input type="hidden" name="action" value="show_grade_distribution_details" />
                                <input type="hidden" name="CourseID" id="selectedCourseID" />
                                <input type="hidden" name="FacultyName" id="selectedFacultyName" />
                                <input type="hidden" name="Quarter" id="selectedQuarter" />
                                <input type="hidden" name="Year" id="selectedYear" />
                                <input type="submit" value="Show Grade Details" />
                            </form>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            String errorMessageMain = "";
                            try {
                                Class.forName("org.postgresql.Driver");
                                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                stmt = conn.createStatement();
                                
                                // Check if any form data was submitted
                                String action = request.getParameter("action");
                                if (action != null && action.equals("show_grade_distribution_details")) {
                                    conn.setAutoCommit(false);
                                   
                                    // Retrieve all student attributes given the PID
                                    String queryCPQG = "SELECT " +
                                                    "course_id, " +
                                                    "instructor, " +
                                                    "quarter, " +
                                                    "year, " +
                                                    "SUM(CASE WHEN grade LIKE 'A%' THEN grade_count ELSE 0 END) AS count_A, " +
                                                    "SUM(CASE WHEN grade LIKE 'B%' THEN grade_count ELSE 0 END) AS count_B, " +
                                                    "SUM(CASE WHEN grade LIKE 'C%' THEN grade_count ELSE 0 END) AS count_C, " +
                                                    "SUM(CASE WHEN grade LIKE 'D%' THEN grade_count ELSE 0 END) AS count_D, " +
                                                    "SUM(CASE WHEN grade NOT LIKE 'A%' AND grade NOT LIKE 'B%' AND grade NOT LIKE 'C%' AND grade NOT LIKE 'D%' THEN grade_count ELSE 0 END) AS count_other " +
                                                    "FROM CPQG " +
                                                    "WHERE course_id = ? AND instructor = ? AND quarter = ? AND year = ? " +
                                                    "GROUP BY course_id, instructor, quarter, year ";

                                    PreparedStatement pstmt = conn.prepareStatement(queryCPQG);
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("CourseID")));
                                    pstmt.setString(2, request.getParameter("FacultyName"));
                                    pstmt.setString(3, request.getParameter("Quarter"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("Year"))); 
                                    try {
                                        rs = pstmt.executeQuery();
                                        conn.commit();
                                    } catch (Exception e) {
                                        errorMessageMain = e.getMessage();
                                        %>
                                        <tr>
                                            <td colspan="15"><%= errorMessageMain %></td>
                                        </tr>
                                        <%
                                        e.printStackTrace();
                                        conn.rollback();
                                    }

                                    while (rs.next()) {
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center;">Course + Professor + Quarter</td>
                            </tr>
                            <tr>
                                <th>A</th>
                                <th>B</th>
                                <th>C</th>
                                <th>D</th>
                                <th>Other</th>
                            </tr>
                            <tr>
                                <form action="materialized_grade_distribution_report.jsp" method="get">
                                    <td><input type="text" name="count_A" value="<%= rs.getInt("count_A") %>" size="5" /></td>
                                    <td><input type="text" name="count_B" value="<%= rs.getInt("count_B") %>" size="5" /></td>
                                    <td><input type="text" name="count_C" value="<%= rs.getInt("count_C") %>" size="5" /></td>
                                    <td><input type="text" name="count_D" value="<%= rs.getInt("count_D") %>" size="5" /></td>
                                    <td><input type="text" name="count_other" value="<%= rs.getInt("count_other") %>" size="5" /></td>
                                </form>
                            </tr>
                        <%
                                    }

                                    String queryCPG = "SELECT " +
                                                    "course_id, " +
                                                    "instructor, " +
                                                    "SUM(CASE WHEN grade LIKE 'A%' THEN grade_count ELSE 0 END) AS count_A, " +
                                                    "SUM(CASE WHEN grade LIKE 'B%' THEN grade_count ELSE 0 END) AS count_B, " +
                                                    "SUM(CASE WHEN grade LIKE 'C%' THEN grade_count ELSE 0 END) AS count_C, " +
                                                    "SUM(CASE WHEN grade LIKE 'D%' THEN grade_count ELSE 0 END) AS count_D, " +
                                                    "SUM(CASE WHEN grade NOT LIKE 'A%' AND grade NOT LIKE 'B%' AND grade NOT LIKE 'C%' AND grade NOT LIKE 'D%' THEN grade_count ELSE 0 END) AS count_other " +
                                                    "FROM CPG " +
                                                    "WHERE course_id = ? AND instructor = ? " +
                                                    "GROUP BY course_id, instructor ";
                                    PreparedStatement pstmtFaculty = conn.prepareStatement(queryCPG);
                                    pstmtFaculty.setInt(1, Integer.parseInt(request.getParameter("CourseID")));
                                    pstmtFaculty.setString(2, request.getParameter("FacultyName"));
                                    rs = pstmtFaculty.executeQuery();
                                    conn.commit();

                                    while (rs.next()) {
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center;">Course + Professor</td>
                            </tr>
                            <tr>
                                <th>A</th>
                                <th>B</th>
                                <th>C</th>
                                <th>D</th>
                                <th>Other</th>
                            </tr>
                            <tr>
                                <form action="materialized_grade_distribution_report.jsp" method="get">
                                    <td><input type="text" name="count_A" value="<%= rs.getInt("count_A") %>" size="5" /></td>
                                    <td><input type="text" name="count_B" value="<%= rs.getInt("count_B") %>" size="5" /></td>
                                    <td><input type="text" name="count_C" value="<%= rs.getInt("count_C") %>" size="5" /></td>
                                    <td><input type="text" name="count_D" value="<%= rs.getInt("count_D") %>" size="5" /></td>
                                    <td><input type="text" name="count_other" value="<%= rs.getInt("count_other") %>" size="5" /></td>
                                </form>
                            </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                errorMessageMain = e.getMessage();
                                %>
                                <tr>
                                    <td colspan="15"><%= errorMessageMain %></td>
                                </tr>
                                <%
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
                                    errorMessageMain = e.getMessage();
                                    %>
                                    <tr>
                                        <td colspan="15"><%= errorMessageMain %></td>
                                    </tr>
                                    <%
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>ateriazlied M