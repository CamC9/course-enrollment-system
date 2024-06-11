<!DOCTYPE html>
<html>
<head>
    <title>Multi-dimensional Grade Distribution Report Form</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
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
        window.onload = function() {
            updateCourseID();  // The initial PID is now set when the page loads
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
                <jsp:include page="menu.html" />
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <form action="grade_distribution_report.jsp" method="get">
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
                                <input type="text" name="Year" id="Year" size="6" placeholder="Year" />
                            </form>
                        </tr>
                        <tr>
                            <form action="grade_distribution_report.jsp" method="get">
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
                                    PreparedStatement pstmt = conn.prepareStatement(
                                        "SELECT course_id FROM courses WHERE course_id = ? "
                                    );
                                    
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("CourseID")));
                                    rs = pstmt.executeQuery();
                                    conn.commit();

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
                                <form action="grade_distribution_report.jsp" method="get">
                                    <td><input type="text" name="CourseID" value="<%= rs.getInt("course_id") %>" size="5" /></td>
                                </form>
                            </tr>
                        <%
                                    }

                                    PreparedStatement pstmtFaculty = conn.prepareStatement(
                                        "SELECT name FROM faculty WHERE name = ? "
                                    );
                                    
                                    pstmtFaculty.setString(1, request.getParameter("FacultyName"));
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
                                <form action="grade_distribution_report.jsp" method="get">
                                    <td><input type="text" name="FacultyName" value="<%= rs.getString("name") %>" size="15" /></td>
                                </form>
                            </tr>
                        <%
                                    }
                                    
                                    PreparedStatement pstmtQuarter = conn.prepareStatement(
                                        "SELECT quarter FROM classes WHERE quarter = ? GROUP BY quarter"
                                    );
                                    
                                    pstmtQuarter.setString(1, request.getParameter("Quarter"));
                                    rs = pstmtQuarter.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);

                                    while (rs.next()) {
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center;">Course</td>
                            </tr>
                            <tr>
                                <th>A</th>
                                <th>B</th>
                                <th>C</th>
                                <th>D</th>
                                <th>Other</th>
                            </tr>
                            <tr>
                                <form action="grade_distribution_report.jsp" method="get">
                                    <td><input type="text" name="Quarter" value="<%= rs.getString("quarter") %>" size="5" /></td>
                                </form>
                            </tr>
                        <%
                                    }

                                    PreparedStatement pstmtAvgGPA = conn.prepareStatement(
                                        "SELECT AVG(gpa) FROM students WHERE course_id = ? AND name = ? AND quarter = ? AND year = ?"
                                    );

                                    pstmtAvgGPA.setInt(1, Integer.parseInt(request.getParameter("CourseID")));
                                    pstmtAvgGPA.setString(2, request.getParameter("FacultyName"));
                                    pstmtAvgGPA.setString(3, request.getParameter("Quarter"));
                                    pstmtAvgGPA.setInt(4, Integer.parseInt(request.getParameter("Year")));
                                    rs = pstmtAvgGPA.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);

                                    while (rs.next()) {
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center;">Average GPA</td>
                            </tr>
                            <tr>
                                <td><input type="text" name="AvgGPA" value="<%= rs.getDouble("AVG(gpa)") %>" size="5" /></td>
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
</html>