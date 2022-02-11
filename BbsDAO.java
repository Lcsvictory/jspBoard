package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/LcsBBS";
			String dbID = "root";
			String dbPassword = "okuy12";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //db오류
	}
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1) + 1;
			}
			return 1; //첫번쨰 게시물
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUE (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bbsTitle);
			pstmt.setInt(3, userID);
			pstmt.setInt(4, getDate());
			pstmt.setInt(5, bbsContent);
			pstmt.setInt(6, getNext());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1) + 1;
			}
			return 1; //첫번쨰 게시물
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
}
