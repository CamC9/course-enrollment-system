<!DOCTYPE html>
<html>
<head>
    <title>Student Information</title>
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
                            <th>PID</th>
                            <th>SSN</th>
                            <th>First</th>
                            <th>Middle</th>
                            <th>Last</th>
                            <th>College</th>
                            <th>Residency</th>
                            <th>IsEnrolled</th>
                            <th>GraduateStatus</th>
                            <th>Major</th>
                            <th>Minor</th>
                            <th>Department</th>
                        </tr>
                        <tr>
                            <form action="students.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="PID" size="6" placeholder="PID" />
                                <input type="text" name="SSN" size="12" placeholder="SSN" />
                                <input type="text" name="first" size="11" placeholder="First" />
                                <input type="text" name="middle" size="9" placeholder="Middle" />
                                <input type="text" name="last" size="11" placeholder="Last" />
                                <input type="text" name="college" size="7" placeholder="College" />
                                <input type="text" name="residency" size="12" placeholder="Residency" />
                                <input type="text" name="is_enrolled" size="10" placeholder="Is Enrolled" />
                                <input type="text" name="graduate_status" size="16" placeholder="Graduate Status" />
                                <input type="text" name="major" size="18" placeholder="Major" />
                                <input type="text" name="minor" size="18" placeholder="Minor" />
                                <input type="text" name="department" size="18" placeholder="Department" />
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
                                    // Then INSERT the data into the students table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO students VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                                    String middle = request.getParameter("middle");
                                    String major = request.getParameter("major");
                                    String minor = request.getParameter("minor");
                                    String department = request.getParameter("department");
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("SSN"));
                                    pstmt.setString(3, request.getParameter("first"));
                                    if (middle == null || middle.trim().isEmpty()) {
                                        pstmt.setString(4, null);
                                    } else {
                                        pstmt.setString(4, middle);
                                    }
                                    pstmt.setString(5, request.getParameter("last"));
                                    pstmt.setString(6, request.getParameter("college"));
                                    pstmt.setString(7, request.getParameter("residency"));
                                    pstmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("is_enrolled")));
                                    pstmt.setString(9, request.getParameter("graduate_status"));
                                    if (major == null || major.trim().isEmpty()) {
                                        pstmt.setString(10, null);
                                    } else {
                                        pstmt.setString(10, major);
                                    }
                                    if (minor == null || minor.trim().isEmpty()) {
                                        pstmt.setString(11, null);
                                    } else {
                                        pstmt.setString(11, minor);
                                    }
                                    if (department == null || department.trim().isEmpty()) {
                                        pstmt.setString(12, null);
                                    } else {
                                        pstmt.setString(12, department);
                                    }
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("students.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE students SET SSN = ?, first = ?, middle = ?, last = ?, college = ?, residency = ?, is_enrolled = ?, graduate_status = ?, major = ?, minor = ?, department = ? WHERE PID = ?");
                                    String str_middle = request.getParameter("middle");
                                    String str_major = request.getParameter("major");
                                    String str_minor = request.getParameter("minor");
                                    String str_department = request.getParameter("department");
                                    pstmt.setString(1, request.getParameter("SSN"));
                                    pstmt.setString(2, request.getParameter("first"));
                                    pstmt.setString(3, str_middle);
                                    pstmt.setString(4, request.getParameter("last"));
                                    pstmt.setString(5, request.getParameter("college"));
                                    pstmt.setString(6, request.getParameter("residency"));
                                    pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("is_enrolled")));
                                    pstmt.setString(8, request.getParameter("graduate_status"));
                                    pstmt.setString(9, str_major);
                                    pstmt.setString(10, str_minor);
                                    pstmt.setString(11, str_department);
                                    pstmt.setString(12, request.getParameter("PID"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("students.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM students WHERE PID = ?");
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("students.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM students");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="students.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("PID") %>" name="PID" size="5"></td>
                                    <td><input value="<%= rs.getString("SSN") %>" name="SSN" size="11"></td>
                                    <td><input value="<%= rs.getString("first") %>" name="first" size="10"></td>
                                    <td><input value="<%= rs.getString("middle") %>" name="middle" size="8"></td>
                                    <td><input value="<%= rs.getString("last") %>" name="last" size="10"></td>
                                    <td><input value="<%= rs.getString("college") %>" name="college" size="7"></td>
                                    <td><input value="<%= rs.getString("residency") %>" name="residency" size="11"></td>
                                    <td><input value="<%= rs.getBoolean("is_enrolled") %>" name="is_enrolled" size="9"></td>
                                    <td><input value="<%= rs.getString("graduate_status") %>" name="graduate_status" size="15"></td>
                                    <td><input value="<%= rs.getString("major") %>" name="major" size="17"></td>
                                    <td><input value="<%= rs.getString("minor") %>" name="minor" size="17"></td>
                                    <td><input value="<%= rs.getString("department") %>" name="department" size="17"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="students.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="PID" value="<%= rs.getString("PID") %>" />
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
