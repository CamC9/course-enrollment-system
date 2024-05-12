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
                            <th>ClassTitle</th>
                            <th>section_id</th>
                            <th>MeetingType</th>
                            <th>BuildingAndRoom</th>
                            <th>StartTime</th>
                            <th>EndTime</th>
                            <th>Date</th>
                            <th>IsRecurring</th>
                            <th>MeetingID</th>
                        </tr>
                        <tr>
                            <form action="meetings.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="class_title" size="26" placeholder="Class Title" />
                                <input type="text" name="section_id" size="9" placeholder="Section ID" />
                                <input type="text" name="meeting_type" size="16" placeholder="Meeting Type" />
                                <input type="text" name="building_and_room" size="19" placeholder="Building And Room" />
                                <input type="text" name="start_time" size="12" placeholder="Start Time" />
                                <input type="text" name="end_time" size="12" placeholder="End Time" />
                                <input type="text" name="date" size="12" placeholder="Date" />
                                <input type="text" name="is_recurring" size="14" placeholder="Is Recurring" />
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
                                    // Then INSERT the data into the section_meetings table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO section_meetings VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("class_title"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.setString(3, request.getParameter("meeting_type"));
                                    pstmt.setString(4, request.getParameter("building_and_room"));
                                    pstmt.setTime(5, Time.valueOf(request.getParameter("start_time")));
                                    pstmt.setTime(6, Time.valueOf(request.getParameter("end_time")));
                                    pstmt.setDate(7, Date.valueOf(request.getParameter("date")));
                                    pstmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("is_recurring")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE section_meetings SET class_title = ?, section_id = ?, meeting_type = ?, building_and_room = ?, start_time = ?, end_time = ?, date = ?, is_recurring = ? WHERE meeting_id = ?"); 
                                    pstmt.setString(1, request.getParameter("class_title"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.setString(3, request.getParameter("meeting_type"));
                                    pstmt.setString(4, request.getParameter("building_and_room"));
                                    pstmt.setTime(5, Time.valueOf(request.getParameter("start_time")));
                                    pstmt.setTime(6, Time.valueOf(request.getParameter("end_time")));
                                    pstmt.setDate(7, Date.valueOf(request.getParameter("date")));
                                    pstmt.setBoolean(8, Boolean.parseBoolean(request.getParameter("is_recurring")));
                                    pstmt.setInt(9, Integer.parseInt(request.getParameter("meeting_id")));
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
                                <form action="meetings.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" value="<%= rs.getString("class_title") %>" name="class_title" size="25" /></td>
                                    <td><input type="text" value="<%= rs.getInt("section_id") %>" name="section_id" size="8" /></td>
                                    <td><input type="text" value="<%= rs.getString("meeting_type") %>" name="meeting_type" size="15" /></td>
                                    <td><input type="text" value="<%= rs.getString("building_and_room") %>" name="building_and_room" size="18" /></td>
                                    <td><input type="text" value="<%= rs.getTime("start_time") %>" name="start_time" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getTime("end_time") %>" name="end_time" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getDate("date") %>" name="date" size="11" /></td>
                                    <td><input type="text" value="<%= rs.getBoolean("is_recurring") %>" name="is_recurring" size="13" /></td>
                                    <td><input type="text" value="<%= rs.getInt("meeting_id") %>" name="meeting_id" size="9" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="meetings.jsp" method="get">
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