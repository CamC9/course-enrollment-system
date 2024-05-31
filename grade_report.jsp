<!DOCTYPE html>
<html>
<head>
    <title>Classes Taken By Student Report Form</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function updatePIDGradeReport() {
            var PID = document.getElementById('PIDSelectGradeReport').value;
            document.getElementById('selectedPIDGradeReport').value = PID;
        }
        window.onload = function() {
            updatePIDGradeReport();  // The initial PID is now set when the page loads
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
                            <form action="grade_report.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="submit" value="Select Student" />
                                <select name="PID" id="PIDSelectGradeReport" onchange="updatePIDGradeReport()">
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
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT students.PID FROM students JOIN enrollment ON students.PID = enrollment.student_pid UNION SELECT students.PID FROM students JOIN past_enrollment ON students.PID = past_enrollment.student_pid GROUP BY PID");
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
                    </thead>
                    <tbody>
                        <tr>
                            <form action="grade_report.jsp" method="get">
                                <input type="hidden" name="action" value="show_student_details" />
                                <input type="hidden" name="PID" id="selectedPIDGradeReport" />
                                <input type="submit" value="Show Details" />
                            </form>
                        </tr>

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
                                if (action != null && action.equals("show_student_details")) {
                                    conn.setAutoCommit(false);
                                   
                                    // Retrieve all student attributes given the PID
                                    PreparedStatement checkStmt = conn.prepareStatement(
                                        "SELECT * FROM students WHERE PID = ?");
                                    
                                    checkStmt.setString(1, request.getParameter("PID"));
                                    ResultSet checkRs = checkStmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);

                                    try {
                                        if (checkStmt != null) {
                                            while (checkRs.next()) {
                        %>
                            <tr>
                                <form action="grade_report.jsp" method="get">
                                    <input type="hidden" name="action" value="show_classes" />
                                    <td><input type="text" name="PID" value="<%= checkRs.getString("PID") %>" size="10" /></td>
                                    <td><input type="text" name="First" value="<%= checkRs.getString("first") %>" size="13" /></td>
                                    <td><input type="text" name="Middle" value="<%= checkRs.getString("middle") %>" size="11" /></td>
                                    <td><input type="text" name="Last" value="<%= checkRs.getString("last") %>" size="11" /></td>
                                    <td><input type="submit" value="Show Classes"></td>
                                </form>
                            </tr>
                                
                        <%
                                            }
                                            checkStmt.close();
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                }

                                if (action != null && action.equals("show_classes")) {
                                    conn.setAutoCommit(false);

                                    String sql = "SELECT combined.section_id, combined.course_name, c.class_title, combined.quarter, combined.year, combined.grade " +
                                        "FROM " +
                                        "    ( " +
                                        "        SELECT " +
                                        "            e.section_id, " +
                                        "            e.course_name, " +
                                        "            NULL AS quarter, " +
                                        "            NULL AS year, " +
                                        "            NULL AS grade " +
                                        "        FROM " +
                                        "            enrollment e " +
                                        "        WHERE " +
                                        "            e.student_pid = ? " +
                                        "        UNION " +
                                        "        SELECT " +
                                        "            pe.section_id, " +
                                        "            pe.course_name, " +
                                        "            pe.quarter, " +
                                        "            pe.year, " +
                                        "            pe.grade " +
                                        "        FROM " +
                                        "            past_enrollment pe " +
                                        "        WHERE " +
                                        "            pe.student_pid = ? " +
                                        "    ) combined " +
                                        "JOIN class_sections s ON s.section_id = combined.section_id " +
                                        "JOIN classes c ON c.offering_id = s.class_offering_id " +
                                        "ORDER BY combined.year DESC, combined.quarter DESC ";

                                    PreparedStatement pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("PID"));
                                    rs = pstmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }
                        %>
                            <table border="1">
                                <tr>
                                    <th>SectionID</th>
                                    <th>CourseName</th>
                                    <th>ClassTitle</th>
                                    <th>Quarter</th>
                                    <th>Year</th>
                                    <th>Grade</th>
                                </tr>
                        <%
                                // Iterate over the result set and generate the table rows
                                while (rs.next()) {
                        %>
                            <tr>
                                <td><%= rs.getInt("section_id") %></td>
                                <td><%= rs.getString("course_name") %></td>
                                <td><%= rs.getString("class_title") %></td>
                                <td><%= rs.getString("quarter") %></td>
                                <td><%= rs.getInt("year") %></td>
                                <td><%= rs.getString("grade") %></td>
                            </tr>
                        <%
                                }
                        %>
                            </table>
                        <%
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