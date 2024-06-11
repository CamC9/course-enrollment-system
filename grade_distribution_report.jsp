<!DOCTYPE html>
<html>
<head>
    <title>Multi-dimensional Grade Distribution Report Form</title>
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
                            <td colspan="5" style="text-align: center;">Course + Professor + Quarter</td>
                            <td colspan="5" style="text-align: center;">Course + Professor</td>
                            <td colspan="5" style="text-align: center;">Course</td>
                        </tr>
                        <tr>
                            <th>A</th>
                            <th>B</th>
                            <th>C</th>
                            <th>D</th>
                            <th>Other</th>
                            <th>A</th>
                            <th>B</th>
                            <th>C</th>
                            <th>D</th>
                            <th>Other</th>
                            <th>A</th>
                            <th>B</th>
                            <th>C</th>
                            <th>D</th>
                            <th>Other</th>
                        </tr>
                        <tr>
                            <form action="grade_distribution_report.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="submit" value="Select Course ID" />
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
                                            errorMessage = e.getMessage();
                                            %>
                                            <tr>
                                                <td colspan="15"><%= errorMessage %></td>
                                            </tr>
                                            <%
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
                                                errorMessage = e.getMessage();
                                                %>
                                                <tr>
                                                    <td colspan="15"><%= errorMessage %></td>
                                                </tr>
                                                <%
                                                e.printStackTrace();
                                            }
                                        }
                                    %>
                                </select>
                            </form>
                        </tr>
                        <tr>
                            <form action="grade_distribution_report.jsp" method="get">
                                <input type="hidden" name="action" value="show_undergrad_details" />
                                <input type="hidden" name="UndergradPID" id="selectedUndergradPID" />
                                <input type="hidden" name="DegreeName" id="selectedDegreeName" />
                                <input type="submit" value="Show Grade Details" />
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
                                <form action="grade_distribution_report.jsp" method="get">
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
            </td>
        </tr>
    </table>
</body>
</html>