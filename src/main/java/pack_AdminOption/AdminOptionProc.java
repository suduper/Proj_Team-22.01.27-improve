package pack_AdminOption;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class AdminOptionProc {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER ="C:/Users/TridentK/git/"
															   + "Project_Lofi_Co-op/"
															   + "src/main/webapp/"
															   + "Resource/GoodsImg/"; // 경로명 반드시 변경
	private static String encType = "UTF-8";
	private static int maxSize = 100*1024*1024;
	
	public AdminOptionProc() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}
	}
	
	// 구매리스트 보기 시작 //
		public Vector<AdminOption> OrderList() {

				Vector<AdminOption> UserOrderList = new Vector<>();
				Connection					objConn		=	null;
				PreparedStatement 		objPstmt 		= 	null;
				ResultSet						objRs			=	null;
				String						 	sql 				=	null;
	 
				try {
					objConn = pool.getConnection();   // DB연동구문 사용
					sql = "select * from userOrder";
					objPstmt = objConn.prepareStatement(sql);
					objRs = objPstmt.executeQuery(); 
			 
					while (objRs.next()) {
						AdminOption AllOrderList = new AdminOption();
						AllOrderList.setNum(objRs.getInt("num"));
						AllOrderList.setuID(objRs.getString("uID"));
						AllOrderList.setAddDate(objRs.getString("addDate"));
						AllOrderList.setGoodsName(objRs.getString("goodsName"));
						AllOrderList.setScount(objRs.getInt("Scount"));
						AllOrderList.setMcount(objRs.getInt("Mcount"));
						AllOrderList.setLcount(objRs.getInt("Lcount"));
						AllOrderList.setXLcount(objRs.getInt("XLcount"));
						AllOrderList.setCalcRes(objRs.getInt("calcRes"));
						AllOrderList.setZip(objRs.getInt("Zip"));
						AllOrderList.setAddr1(objRs.getString("Addr1"));
						AllOrderList.setAddr2(objRs.getString("Addr2"));
						AllOrderList.setPhone(objRs.getString("phone"));
						AllOrderList.setNotice(objRs.getString("notice"));
						AllOrderList.setDelivery(objRs.getInt("delivery"));
						UserOrderList.add(AllOrderList);
					}
				
				} catch (SQLException e) {
					System.out.println("SQL 이슈 : " + e.getMessage());
				} catch (Exception e) {
					System.out.println("DB 접속이슈 : " + e.getMessage());
				} finally {
					pool.freeConnection(objConn, objPstmt, objRs);
				}
				return UserOrderList;
			}
			// 구매리스트 보기 끝 //
		
		public int changeState(int changeState , String info) {
			
			Connection					objConn		=	null;
			PreparedStatement 		objPstmt 		= 	null;
			ResultSet						objRs			=	null;
			String						 	sql 				=	null;
			
			String[] info_Split = info.split(" / ");
	
			try {
				objConn = pool.getConnection();   // DB연동구문 사용
				sql = "update userOrder "
						+ "set delivery = ? "
						+ "where num = ? "
						+ "and uID = ? "
						+ "and goodsName = ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, changeState);
				objPstmt.setInt(2, Integer.parseInt(info_Split[0]));
				objPstmt.setString(3, info_Split[1]);
				objPstmt.setString(4, info_Split[2]);
				System.out.println("변환 실행 :" + info);
				return objPstmt.executeUpdate(); 
			
			} catch (SQLException e) {
				System.out.println("SQL 이슈 : " + e.getMessage());
			} catch (Exception e) {
				System.out.println("DB 접속이슈 : " + e.getMessage());
			} finally {
				pool.freeConnection(objConn, objPstmt, objRs);
			}
			return 0;
		}
}
