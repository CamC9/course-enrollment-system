<!DOCTYPE html>
<html>
<head>
    <title>Past Enrollment Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function updateSectionId() {
            var sectionId = document.getElementById('pastSectionSelect').value;
            document.getElementById('selectedPastSectionId').value = sectionId;
        }
        window.onload = function() {
            updateSectionId();  // The initial section_id is now set when the page loads
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
                            <th>class_id</th>
                            <th>section_id</th>
                            <th>units</th>
                            <th>grade</th>
                            <th>enrollment_id</th>
                        </tr>
                        <tr>
                            <form action="past_enrollment.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="text" name="student_pid" size="10" placeholder="PID" />
                                <input type="text" name="course_id" size="13" placeholder="Course ID" />
                                <input type="text" name="class_id" size="11" placeholder="Class ID" />
                                <input type="text" name="units" size="5" placeholder="Units" />
                                <input type="text" name="grade" size="5" placeholder="Grade" />
                                <input type="text" name="quarter" size="11" placeholder="Quarter" />
                                <input type="text" name="year" size="11" placeholder="Year" />
                                <input type="submit" value="Select Section" />
                                <select name="section_id" id="pastSectionSelect" onchange="updateSectionId()">
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
                                                Integer course_id = Integer.parseInt(request.getParameter("course_id"));
                                                String quarter = request.getParameter("quarter");
                                                Integer year = Integer.parseInt(request.getParameter("year"));
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT section_id FROM class_sections WHERE class_id = (SELECT class_id FROM classes WHERE course_id = ? AND quarter = ? AND year = ?)");
                                                pstmt.setInt(1, course_id);
                                                pstmt.setString(2, quarter);
                                                pstmt.setInt(3, year);
                                                rs1 = pstmt.executeQuery();
                                                conn1.commit();
                                                conn1.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs1.next()) {
                                                String sectionId = rs1.getString("section_id");
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
                            <form action="past_enrollment.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="student_pid" value="<%= request.getParameter("student_pid") %>" />
                                <input type="hidden" name="class_id" value="<%= request.getParameter("class_id") %>" />
                                <input type="hidden" name="section_id" id="selectedPastSectionId" />
                                <input type="hidden" name="units" value="<%= request.getParameter("units") %>" />
                                <input type="hidden" name="grade" value="<%= request.getParameter("grade") %>" />
                                <input type="hidden" name="enrollment_id" value="<%= request.getParameter("enrollment_id") %>" />
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
                                    // Then INSERT the data into the past_enrollment table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO past_enrollment VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("student_pid"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("class_id")));
                                    pstmt.setString(3, request.getParameter("section_id"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));
                                    pstmt.setString(5, request.getParameter("grade"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("past_enrollment.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE past_enrollment SET student_pid = ?, class_id = ?, section_id = ?, units = ?, grade = ? WHERE enrollment_id = ?");
                                    pstmt.setString(1, request.getParameter("student_pid"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("class_id")));
                                    pstmt.setString(3, request.getParameter("section_id"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));
                                    pstmt.setString(5, request.getParameter("grade"));
                                    pstmt.setInt(6, Integer.parseInt(request.getParameter("enrollment_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("past_enrollment.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM past_enrollment WHERE enrollment_id = ?"); 
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("enrollment_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("past_enrollment.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM past_enrollment");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="past_enrollment.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" name="student_pid" value="<%= rs.getString("student_pid") %>" size="10" /></td>
                                    <td><input type="text" name="class_id" value="<%= rs.getInt("class_id") %>" size="11" /></td>
                                    <td><input type="text" name="section_id" value="<%= rs.getString("section_id") %>" size="11" /></td>
                                    <td><input type="text" name="units" value="<%= rs.getInt("units") %>" size="5" /></td>
                                    <td><input type="text" name="grade" value="<%= rs.getString("grade") %>" size="5" /></td>
                                    <td><input type="text" name="enrollment_id" value="<%= rs.getInt("enrollment_id") %>" size="13" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="past_enrollment.jsp" method="get">
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
