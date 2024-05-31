<!DOCTYPE html>
<html>
<head>
    <title>Class Roster Report Form</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function updateClass() {
            var Class = document.getElementById('ClassSelect').value;
            document.getElementById('selectedClass').value = Class;
        }
        window.onload = function() {
            updateClass();  // The initial Class is now set when the page loads
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
                            <th>CourseName</th>
                            <th>Quarter</th>
                            <th>Year</th>
                        </tr>
                        <tr>
                            <form action="roster_report.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="submit" value="Select Class Name" />
                                <select name="Class" id="ClassSelect" onchange="updateClass()">
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
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT class_title FROM classes GROUP BY class_title");
                                                rs1 = pstmt.executeQuery();
                                                conn1.commit();
                                                conn1.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs1.next()) {
                                                String Class = rs1.getString("class_title");
                                                %>
                                                <option value="<%= Class %>"><%= Class %></option>
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
                            <form action="roster_report.jsp" method="get">
                                <input type="hidden" name="action" value="show_class_details" />
                                <input type="hidden" name="Class" id="selectedClass" />
                                <input type="submit" value="Show Classes" />
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
                                if (action != null && action.equals("show_class_details")) {
                                    conn.setAutoCommit(false);
                                   
                                    // Retrieve all student attributes given the Class 
                                    PreparedStatement checkStmt = conn.prepareStatement(
                                        "SELECT * FROM classes WHERE class_title = ?");
                                    
                                    checkStmt.setString(1, request.getParameter("Class"));
                                    ResultSet checkRs = checkStmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);

                                    try {
                                        if (checkStmt != null) {
                                            while (checkRs.next()) {
                        %>
                            <tr>
                                <form action="roster_report.jsp" method="get">
                                    <input type="hidden" name="action" value="show_roster" />
                                    <td><input type="text" name="Course" value="<%= checkRs.getString("course_name") %>" size="13" /></td>
                                    <td><input type="text" name="Quarter" value="<%= checkRs.getString("quarter") %>" size="11" /></td>
                                    <td><input type="text" name="Year" value="<%= checkRs.getString("year") %>" size="11" /></td>
                                    <td><input type="hidden" name="offering_id" value="<%= checkRs.getInt("offering_id") %>" /></td>
                                    <td><input type="submit" value="Show Roster"></td>
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

                                if (action != null && action.equals("show_roster")) {
                                    conn.setAutoCommit(false);
                                    String sql = 
                                        "SELECT " +
                                        "s.PID, " +
                                        "s.SSN, " +
                                        "s.first, " +
                                        "s.middle, " +
                                        "s.last, " +
                                        "s.college, " +
                                        "s.residency, " +
                                        "s.is_enrolled, " +
                                        "s.graduate_status, " +
                                        "s.major, " +
                                        "s.minor, " +
                                        "s.department, " +
                                        "cr.min_unit, " +
                                        "cr.max_unit, " +
                                        "cr.grading_type " +
                                        "FROM " +
                                            "students s " +
                                        "JOIN " + 
                                            "enrollment e ON e.student_pid = s.PID " +
                                        "JOIN " +
                                            "class_sections cs ON e.section_id = cs.section_id " +
                                        "JOIN " + 
                                            "courses cr ON cs.course_name = cr.course_name " +
                                        "JOIN " +
                                            "classes cls ON cs.class_offering_id = cls.offering_id " +
                                        "WHERE " +
                                            "cls.offering_id = ?::int ";

                                    PreparedStatement pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, request.getParameter("offering_id"));
                                    rs = pstmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }
                        %>
                            <table border="1">
                                <tr>
                                    <th>PID</th>
                                    <th>SSN</th>
                                    <th>First</th>
                                    <th>Middle</th>
                                    <th>Last</th>
                                    <th>College</th>
                                    <th>Residency</th>
                                    <th>Is Enrolled</th>
                                    <th>Graduate Status</th>
                                    <th>Major</th>
                                    <th>Minor</th>
                                    <th>Department</th>
                                    <th>Min Unit</th>
                                    <th>Max Unit</th>
                                    <th>Grading Type</th>
                                </tr>
                        <%

                                // Iterate over the result set and generate the table rows
                                while (rs.next()) {
                        %>
                            <tr>
                                <td><%= rs.getString("PID") %></td>
                                <td><%= rs.getString("SSN") %></td>
                                <td><%= rs.getString("first") %></td>
                                <td><%= rs.getString("middle") %></td>
                                <td><%= rs.getString("last") %></td>
                                <td><%= rs.getString("college") %></td>
                                <td><%= rs.getString("residency") %></td>
                                <td><%= rs.getBoolean("is_enrolled") %></td>
                                <td><%= rs.getString("graduate_status") %></td>
                                <td><%= rs.getString("major") %></td>
                                <td><%= rs.getString("minor") %></td>
                                <td><%= rs.getString("department") %></td>
                                <td><%= rs.getInt("min_unit") %></td>
                                <td><%= rs.getInt("max_unit") %></td>
                                <td><%= rs.getString("grading_type") %></td>
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