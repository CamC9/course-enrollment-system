<!DOCTYPE html>
<html>
<head>
    <title>Course Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
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
                            <th>course_id</th>
                            <th>course_name</th>
                            <th>department</th>
                            <th>min_unit</th>
                            <th>max_unit</th>
                            <th>grading_type</th>
                            <th>requires_lab_work</th>
                            <th>needs_instructor_consent</th>
                        </tr>
                        <tr>
                            <form action="courses.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_id" size="12" placeholder="Course ID" />
                                <input type="text" name="course_name" size="13" placeholder="Course Name" />
                                <input type="text" name="department" size="21" placeholder="Department" />
                                <input type="text" name="min_unit" size="11" placeholder="Min Units" />
                                <input type="text" name="max_unit" size="10"placeholder="Max Units" />
                                <input type="text" name="grading_type" size="16" placeholder="Grading Type" />
                                <input type="text" name="requires_lab_work" size="21" placeholder="Requires Lab Work" />
                                <input type="text" name="needs_instructor_consent" size="26" placeholder="Needs Instructor Consent" />
                                <input type="submit" value="Add" />
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
                                if (action != null && action.equals("add")) {
                                    conn.setAutoCommit(false);
                                     
                                    // Create the prepared Statement
                                    String course_name = request.getParameter("course_name");
                                    String department = request.getParameter("department");
                                    Integer course_id = Integer.parseInt(request.getParameter("course_id"));
                                    Boolean needs_instructor_consent = Boolean.parseBoolean(request.getParameter("needs_instructor_consent"));
                                    Boolean requires_lab_work = Boolean.parseBoolean(request.getParameter("requires_lab_work"));
                                    Integer min_unit = Integer.parseInt(request.getParameter("min_unit"));
                                    Integer max_unit = Integer.parseInt(request.getParameter("max_unit"));
                                    String grading_type = request.getParameter("grading_type");
                                     
                                    String sql = "INSERT INTO courses (course_id, course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, course_id);
                                    ps.setString(2, course_name);
                                    ps.setString(3, department);
                                    ps.setBoolean(4, needs_instructor_consent);
                                    ps.setBoolean(5, requires_lab_work);
                                    ps.setInt(6, min_unit);
                                    ps.setInt(7, max_unit);
                                    ps.setString(8, grading_type);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("courses.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    Integer course_id = Integer.parseInt(request.getParameter("course_id"));
                                    String course_name = request.getParameter("course_name");
                                    String department = request.getParameter("department");
                                    Boolean needs_instructor_consent = Boolean.parseBoolean(request.getParameter("needs_instructor_consent"));
                                    Boolean requires_lab_work = Boolean.parseBoolean(request.getParameter("requires_lab_work"));
                                    Integer min_unit = Integer.parseInt(request.getParameter("min_unit"));
                                    Integer max_unit = Integer.parseInt(request.getParameter("max_unit"));
                                    String grading_type = request.getParameter("grading_type");
                                    String sql = "UPDATE courses SET course_name = ?, department = ?, needs_instructor_consent = ?, requires_lab_work = ?, min_unit = ?, max_unit = ?, grading_type = ? WHERE course_id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                    ps.setString(2, department);
                                    ps.setBoolean(3, needs_instructor_consent);
                                    ps.setBoolean(4, requires_lab_work);
                                    ps.setInt(5, min_unit);
                                    ps.setInt(6, max_unit);
                                    ps.setString(7, grading_type);
                                    ps.setInt(8, course_id);
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("courses.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    Integer course_id = Integer.parseInt(request.getParameter("course_id"));
                                     
                                    String sql = "DELETE FROM courses WHERE course_id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, course_id);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("courses.jsp"); 
                                }
                                 
                                // Get the data from the database
                                rs = stmt.executeQuery("SELECT * FROM courses");
                                while (rs.next()) {
                        %>
                        <tr>
                            <form action="courses.jsp" method="get">
                                <input type="hidden" name="action" value="update" />
                                <td><input value="<%= rs.getInt("course_id") %>" name="course_id" size="12" /></td>
                                <td><input value="<%= rs.getString("course_name") %>" name="course_name" size="12" /></td>
                                <td><input value="<%= rs.getString("department") %>" name="department" size="20" /></td>
                                <td><input value="<%= rs.getInt("min_unit") %>" name="min_unit" size="10" /></td>
                                <td><input value="<%= rs.getInt("max_unit") %>" name="max_unit" size="10" /></td>
                                <td><input value="<%= rs.getString("grading_type") %>" name="grading_type" size="15" /></td>
                                <td><input value="<%= rs.getBoolean("requires_lab_work") %>" name="requires_lab_work" size="20" /></td>
                                <td><input value="<%= rs.getBoolean("needs_instructor_consent") %>" name="needs_instructor_consent" size="25" /></td>
                                <td><input type="submit" value="Update" /></td>
                            </form>
                            <form action="courses.jsp" method="get">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="course_id" value="<%= rs.getInt("course_id") %>" />
                                <td><input type="submit" value="Delete" /></td>
                            </form>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>