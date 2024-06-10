<!DOCTYPE html>
<html>
<head>
    <title>Meetings Information</title>
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
                            <th>Section ID</th>
                            <th>Meeting Type</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Days of Week</th>
                            <th>Building And Room</th>
                            <th>Meeting ID</th>
                        </tr>
                        <tr>
                            <form action="section_meetings.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="section_id" size="10" placeholder="Section ID" />
                                <input type="text" name="meeting_type" size="16" placeholder="Meeting Type" />
                                <input type="text" name="start_time" size="12" placeholder="Start Time" />
                                <input type="text" name="end_time" size="12" placeholder="End Time" />
                                <input type="text" name="days_of_week" size="13" placeholder="Days of Week" />
                                <input type="text" name="building_and_room" size="20" placeholder="Building And Room" />
                                <input type="submit" value="Add" />
                            </form>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            String errorMessage = "";
                            try {
                                Class.forName("org.postgresql.Driver");
                                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                stmt = conn.createStatement();
                                
                                // Check if any form data was submitted
                                String action = request.getParameter("action");
                                if (action != null && action.equals("add")) {
                                    conn.setAutoCommit(false);
                                    
                                    // Create the prepared Statement
                                    // Then INSERT the data into the section_meetings table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO section_meetings VALUES (?, ?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("section_id"));
                                    pstmt.setString(2, request.getParameter("meeting_type"));
                                    pstmt.setTime(3, Time.valueOf(request.getParameter("start_time")));
                                    pstmt.setTime(4, Time.valueOf(request.getParameter("end_time")));
                                    pstmt.setString(5, request.getParameter("days_of_week"));
                                    pstmt.setString(6, request.getParameter("building_and_room"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE section_meetings SET section_id = ?, meeting_type = ?, start_time = ?, end_time = ?, days_of_week = ?, building_and_room = ? WHERE meeting_id = ?"); 
                                    pstmt.setString(1, request.getParameter("section_id"));
                                    pstmt.setString(2, request.getParameter("meeting_type"));
                                    pstmt.setTime(3, Time.valueOf(request.getParameter("start_time")));
                                    pstmt.setTime(4, Time.valueOf(request.getParameter("end_time")));
                                    pstmt.setString(5, request.getParameter("days_of_week"));
                                    pstmt.setString(6, request.getParameter("building_and_room"));
                                    pstmt.setInt(7, Integer.parseInt(request.getParameter("meeting_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM section_meetings WHERE meeting_id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("meeting_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                rs = stmt.executeQuery("SELECT * FROM section_meetings");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="section_meetings.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" value="<%= rs.getString("section_id") %>" name="section_id" size="9" /></td>
                                    <td><input type="text" value="<%= rs.getString("meeting_type") %>" name="meeting_type" size="15" /></td>
                                    <td><input type="text" value="<%= rs.getTime("start_time") %>" name="start_time" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getTime("end_time") %>" name="end_time" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getString("days_of_week") %>" name="days_of_week" size="12" /></td>
                                    <td><input type="text" value="<%= rs.getString("building_and_room") %>" name="building_and_room" size="19" /></td>
                                    <td><input type="text" value="<%= rs.getInt("meeting_id") %>" name="meeting_id" size="10" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="section_meetings.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="meeting_id" value="<%= rs.getInt("meeting_id") %>" />
                                        <input type="submit" value="Delete" />
                                    </form>
                                </td>
                            </tr>
                        <%
                                }
                            } catch (Exception e) {
                                errorMessage = e.getMessage();
                                %>
                                <tr>
                                    <td colspan="6"><%= errorMessage %></td>
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
                                    errorMessage = e.getMessage();
                                    %>
                                    <tr>
                                        <td colspan="6"><%= errorMessage %></td>
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