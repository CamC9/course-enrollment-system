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
                        </tr>
                        <tr>
                            <form action="students.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="PID" size="3" />
                                <input type="text" name="SSN" size="11" />
                                <input type="text" name="first" size="4" />
                                <input type="text" name="middle" size="6" />
                                <input type="text" name="last" size="6" />
                                <input type="text" name="college" size="6" />
                                <input type="text" name="residency" size="11" />
                                <input type="text" name="is_enrolled" size="9" />
                                <input type="text" name="graduate_status" size="15" />
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

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO students VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                                    
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("SSN")));
                                    pstmt.setString(3, request.getParameter("first"));
                                    pstmt.setString(4, request.getParameter("middle"));
                                    pstmt.setString(5, request.getParameter("last"));
                                    pstmt.setString(6, request.getParameter("college"));
                                    pstmt.setString(7, request.getParameter("residency"));
                                    pstmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("is_enrolled")));
                                    pstmt.setString(9, request.getParameter("graduate_status"));

                                    pstmt.executeUpdate();
                                     
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                rs = stmt.executeQuery("SELECT * FROM students");
                                while (rs.next()) {
                        %>
                            <tr>
                                <td><%=rs.getString("PID")%></td>
                                <td><%=rs.getInt("SSN")%></td>
                                <td><%=rs.getString("first")%></td>
                                <td><%=rs.getString("middle")%></td>
                                <td><%=rs.getString("last")%></td>
                                <td><%=rs.getString("college")%></td>
                                <td><%=rs.getString("residency")%></td>
                                <td><%= rs.getBoolean("is_enrolled") ? "True" : "False" %></td> 
                                <td><%=rs.getString("graduate_status")%></td>
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
