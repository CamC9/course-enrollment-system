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
                            <th>course_name</th>
                            <th>department</th>
                            <th>needs_instructor_consent</th>
                            <th>requires_lab_work</th>
                            <th>min_unit</th>
                            <th>max_unit</th>
                            <th>grading_type</th>
                        </tr>
                        <tr>
                            <form action="courses.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_name" size="20" />
                                <input type="text" name="department" size="20" />
                                <input type="text" name="needs_instructor_consent" size="20" />
                                <input type="text" name="requires_lab_work" size="20" />
                                <input type="text" name="min_unit" size="20" />
                                <input type="text" name="max_unit" size="20" />
                                <input type="text" name="grading_type" size="20" />
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
                                    Boolean needs_instructor_consent = Boolean.parseBoolean(request.getParameter("needs_instructor_consent"));
                                    Boolean requires_lab_work = Boolean.parseBoolean(request.getParameter("requires_lab_work"));
                                    Integer min_unit = Integer.parseInt(request.getParameter("min_unit"));
                                    Integer max_unit = Integer.parseInt(request.getParameter("max_unit"));
                                    String grading_type = request.getParameter("grading_type");
                                     
                                    String sql = "INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) VALUES (?, ?, ?, ?, ?, ?, ?)";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                    ps.setString(2, department);
                                    ps.setBoolean(3, needs_instructor_consent);
                                    ps.setBoolean(4, requires_lab_work);
                                    ps.setInt(5, min_unit);
                                    ps.setInt(6, max_unit);
                                    ps.setString(7, grading_type);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    String course_name = request.getParameter("course_name");
                                    String department = request.getParameter("department");
                                    Boolean needs_instructor_consent = Boolean.parseBoolean(request.getParameter("needs_instructor_consent"));
                                    Boolean requires_lab_work = Boolean.parseBoolean(request.getParameter("requires_lab_work"));
                                    Integer min_unit = Integer.parseInt(request.getParameter("min_unit"));
                                    Integer max_unit = Integer.parseInt(request.getParameter("max_unit"));
                                    String grading_type = request.getParameter("grading_type");
                                    String sql = "UPDATE courses SET department = ?, needs_instructor_consent = ?, requires_lab_work = ?, min_unit = ?, max_unit = ?, grading_type = ? WHERE course_name = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, department);
                                    ps.setBoolean(2, needs_instructor_consent);
                                    ps.setBoolean(3, requires_lab_work);
                                    ps.setInt(4, min_unit);
                                    ps.setInt(5, max_unit);
                                    ps.setString(6, grading_type);
                                    ps.setString(7, course_name);
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    String course_name = request.getParameter("course_name");
                                     
                                    String sql = "DELETE FROM courses WHERE course_name = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }
                                 
                                // Get the data from the database
                                rs = stmt.executeQuery("SELECT * FROM courses");
                                while (rs.next()) {
                        %>
                        <tr>
                            <form action="courses.jsp" method="get">
                                <input type="hidden" name="action" value="update" />
                                <td><input value="<%= rs.getString("course_name") %>" name="course_name" size="15" /></td>
                                <td><input value="<%= rs.getString("department") %>" name="department" size="15" /></td>
                                <td><input value="<%= rs.getBoolean("needs_instructor_consent") %>" name="needs_instructor_consent" size="25" /></td>
                                <td><input value="<%= rs.getBoolean("requires_lab_work") %>" name="requires_lab_work" size="20" /></td>
                                <td><input value="<%= rs.getInt("min_unit") %>" name="min_unit" size="10" /></td>
                                <td><input value="<%= rs.getInt("max_unit") %>" name="max_unit" size="10" /></td>
                                <td><input value="<%= rs.getString("grading_type") %>" name="grading_type" size="15" /></td>
                                <td><input type="submit" value="Update" /></td>
                            </form>
                            <form action="courses.jsp" method="get">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="course_name" value="<%= rs.getString("course_name") %>" />
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