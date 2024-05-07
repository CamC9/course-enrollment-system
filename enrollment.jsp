<!DOCTYPE html>
<html>
<head>
    <title>Enrollment Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function updateSectionId() {
            var sectionId = document.getElementById('sectionSelect').value;
            document.getElementById('selectedSectionId').value = sectionId;
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
                            <th>student_pid</th>
                            <th>course_name</th>
                            <th>section_id</th>
                            <th>grade</th>
                            <th>enrollment_id</th>
                        </tr>
                        <tr>
                            <form action="enrollment.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="text" name="course_name" size="11" placeholder="Course Name" />
                                <input type="submit" value="Select Section" />
                                <select name="section_id" id="sectionSelect" onchange="updateSectionId()">
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
                                                String courseName = request.getParameter("course_name");
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT section_id FROM class_sections WHERE course_name = ?");
                                                pstmt.setString(1, courseName);
                                                rs1 = pstmt.executeQuery();
                                                conn1.commit();
                                                conn1.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs1.next()) {
                                                int sectionId = rs1.getInt("section_id");
                                                %>
                                                <option value="<%= sectionId %>">section_id <%= sectionId %></option>
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
                            <form action="enrollment.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="student_pid" size="3" />
                                <input type="text" name="grade" size="4" />
                                <input type="text" name="enrollment_id" size="6" />
                                <input type="hidden" name="course_name" value="<%= request.getParameter("course_name") %>" />
                                <input type="hidden" name="section_id" id="selectedSectionId" />
                                <input type="submit" value="Add" />
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
                                if (action != null && action.equals("add")) {
                                    conn.setAutoCommit(false);
                                    
                                    // Create the prepared Statement
                                    // Then INSERT the data into the enrollment table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO enrollment VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("student_pid"));
                                    pstmt.setString(2, request.getParameter("course_name"));
                                    pstmt.setInt(3, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.setString(4, request.getParameter("grade"));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("enrollment_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE enrollment SET student_pid = ?, course_name = ?, section_id = ?, grade = ? WHERE enrollment_id = ?");
                                    pstmt.setString(1, request.getParameter("student_pid"));
                                    pstmt.setString(2, request.getParameter("course_name"));
                                    pstmt.setInt(3, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.setString(4, request.getParameter("grade"));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("enrollment_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM enrollment WHERE enrollment_id = ?"); 
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("enrollment_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                rs = stmt.executeQuery("SELECT * FROM enrollment");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="enrollment.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" name="student_pid" value="<%= rs.getString("student_pid") %>" size="3" /></td>
                                    <td><input type="text" name="course_name" value="<%= rs.getString("course_name") %>" size="11" /></td>
                                    <td><input type="text" name="section_id" value="<%= rs.getInt("section_id") %>" size="11" /></td>
                                    <td><input type="text" name="grade" value="<%= rs.getString("grade") %>" size="4" /></td>
                                    <td><input type="text" name="enrollment_id" value="<%= rs.getInt("enrollment_id") %>" size="6" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="enrollment.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="enrollment_id" value="<%= rs.getInt("enrollment_id") %>" />
                                        <input type="submit" value="Delete" />
                                    </form>
                                </td>
                            </tr>
                        <%
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
