<!DOCTYPE html>
<html>
<head>
    <title>Review Session Meetings Information</title>
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
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Date</th>
                            <th>Building And Room</th>
                            <th>Meeting ID</th>
                        </tr>
                        <tr>
                            <form action="review_sessions.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="section_id" size="10" placeholder="Section ID" />
                                <input type="text" name="start_time" size="12" placeholder="Start Time" />
                                <input type="text" name="end_time" size="12" placeholder="End Time" />
                                <input type="text" name="date" size="13" placeholder="Date" />
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
                            try {
                                Class.forName("org.postgresql.Driver");
                                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                stmt = conn.createStatement();
                                
                                // Check if any form data was submitted
                                String action = request.getParameter("action");
                                if (action != null && action.equals("add")) {
                                    conn.setAutoCommit(false);
                                    
                                    // Create the prepared Statement
                                    // Then INSERT the data into the review_sessions table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO review_sessions VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("section_id"));
                                    pstmt.setTime(2, Time.valueOf(request.getParameter("start_time")));
                                    pstmt.setTime(3, Time.valueOf(request.getParameter("end_time")));
                                    pstmt.setDate(4, Date.valueOf(request.getParameter("date")));
                                    pstmt.setString(5, request.getParameter("building_and_room"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE review_sessions SET section_id = ?, start_time = ?, end_time = ?, date = ?, building_and_room = ? WHERE meeting_id = ?"); 
                                    pstmt.setString(1, request.getParameter("section_id"));
                                    pstmt.setTime(2, Time.valueOf(request.getParameter("start_time")));
                                    pstmt.setTime(3, Time.valueOf(request.getParameter("end_time")));
                                    pstmt.setDate(4, Date.valueOf(request.getParameter("date")));
                                    pstmt.setString(5, request.getParameter("building_and_room"));
                                    pstmt.setInt(6, Integer.parseInt(request.getParameter("meeting_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM review_sessions WHERE meeting_id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("meeting_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                rs = stmt.executeQuery("SELECT * FROM review_sessions");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="review_sessions.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" value="<%= rs.getString("section_id") %>" name="section_id" size="9" /></td>
                                    <td><input type="text" value="<%= rs.getTime("start_time") %>" name="start_time" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getTime("end_time") %>" name="end_time" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getDate("date") %>" name="date" size="12" /></td>
                                    <td><input type="text" value="<%= rs.getString("building_and_room") %>" name="building_and_room" size="19" /></td>
                                    <td><input type="text" value="<%= rs.getInt("meeting_id") %>" name="meeting_id" size="10" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="review_sessions.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="meeting_id" value="<%= rs.getInt("meeting_id") %>" />
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