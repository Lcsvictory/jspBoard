package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; // USER 라는 테이블에서 userID의 물음표에 해당하는 행을 선택하고 userPassword 의 맞는 열을 선택한다. 
		try {
			pstmt = conn.prepareStatement(SQL); //SQL 이라고 써있는 곳에 SQL 에 정의해놓은 문장을 입력해라. 즉 mysql에 문장을 입력하는 것과 마찬가지.
			pstmt.setString(1, userID); // SQL 에 첫번쨰 물음표에 userID 값을 넣어라.
			rs = pstmt.executeQuery(); //executeQuery 는 rs에 pstmt 값을 반환해주는 함수이다.
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) 
					return 1; //로그인 성공
				else 
					return 0; //Password 불일치
			}
			return -1; // 아이디 없다
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // db 오류	
	}
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}

