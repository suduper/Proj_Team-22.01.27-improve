package pack_user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import pack_goods.DBConnectionMgr;

public class UserDAO {
	
	private DBConnectionMgr pool;
	
	public UserDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}
	}
	
	//////////////////////////////// 로그인 ////////////////////////////////
	public int login(String uID, String uPw,String authority) {
		
			Connection				objConn 			=		null;
			PreparedStatement	objPstmt 			=		null;
			ResultSet					objRs 				=		null;
			String						sql_checkPw 		=		null;
			String						sql_chekAuth 	=		null;

     sql_chekAuth = "select authority from userInfo where uID = ?;";

		try {
			objConn = pool.getConnection();
			sql_checkPw = "select uPw from userInfo where uID = ?";
			objPstmt = objConn.prepareStatement(sql_checkPw); //쿼리문1을 대기 시킨다
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery();
			if(objRs.next()) {
				if(objRs.getString(1).equals(uPw)) {
					 sql_chekAuth = "select authority from userInfo where uID = ?;";
					 objPstmt = objConn.prepareStatement(sql_chekAuth);
					 objPstmt.setString(1, uID);
					 objRs = objPstmt.executeQuery();
					 if(objRs.next()) {
						 if(objRs.getString(1).equals("admin")) {
								authority = "admin";
								return 2;
						 }else 
								authority = "user";
						 return 1;
					 }
				} else {
					return -1;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //오류
	}
	
	//////////////////////////////// 회원가입 ////////////////////////////////
	public int join(User user) {
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql_join 		=		null;
		
		  String sql = "insert into userInfo values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		  try {
			  objConn = pool.getConnection();
			  sql_join  = "insert into userInfo values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			  objPstmt = objConn.prepareStatement(sql_join); //쿼리문1을 대기 시킨다
			  objPstmt.setString(1, user.getNationality());
			  objPstmt.setString(2, user.getCertify());
			  objPstmt.setString(3, user.getuID());
			  objPstmt.setString(4, user.getuPw());
			  objPstmt.setString(5, user.getuZip());
			  objPstmt.setString(6, user.getuAddr1());
			  objPstmt.setString(7, user.getuAddr2());
			  objPstmt.setString(8, user.getAuthority());
			  objPstmt.setInt(9, 0);
			  return objPstmt.executeUpdate();
		  }catch (Exception e) {
		 	e.printStackTrace();
		  }
		  return -1;
		}
	/*
	//////////////////////////////// 회원탈퇴 ////////////////////////////////
	public User getUser(String uID) {
		String sql = "select * from userInfo where uID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uID);
			rs1 = pstmt.executeQuery();
			if(rs1.next()) {
				User userC = new User();
				userC.setuID(rs1.getString(1));
				return userC;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int CMS(User user) {
		  String sql = "delete from userInfo where uID=?";
		  try {
		    pstmt1 = conn.prepareStatement(sql);
		    pstmt1.setString(1, user.getuID());

		    return pstmt1.executeUpdate();
		  }catch (Exception e) {
		 	e.printStackTrace();
		  }
		  return -1;
		}
	
	////////////////////////////////회원 정보 수정용 확인 ////////////////////////////////
	public int UserInfo(String uID, String uPw) {
		String sql = "select uPw from user where uID = ?";
		try {
			pstmt1 = conn.prepareStatement(sql); //sql쿼리문을 대기 시킨다
			pstmt1.setString(1, uID); //첫번째 '?'에 매개변수로 받아온 'uID'를 대입
			rs1 = pstmt1.executeQuery(); //쿼리를 실행한 결과를 rs1에 저장
			if(rs1.next()) {
				if(rs1.getString(1).equals(uPw)) {
					return 1; //로그인 성공
					}else
						return 0; //비밀번호 틀림
				}
			return -1; //아이디 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //오류
	}
	*/
	
	public int Wallet(String uID) {
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;
		
		try {
			objConn = pool.getConnection();
			
			sql= "select Wallet from userInfo where uID = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery();
			if(objRs.next()) {
				return objRs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return -1;
	}
}