package pack_QnA;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class QnAMgr {
	
	public DBConnectionMgr pool;
	private static final String SAVEFOLDER
	 = "C:\\Project_Directory";
	
	private static String encType = "UTF-8";
	private static int maxSize = 8*1024*1024;
	
	public QnAMgr() {
		
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	// 리뷰 입력
	public void insertQnA(HttpServletRequest req) {
		
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		MultipartRequest	multi = null;
		int fileSize = 0;
		String fileName = null;
		
		try {
			objConn = pool.getConnection();
			sql = "select max(num) from tblReview";
			objPstmt = objConn.prepareStatement(sql);
			objRs = objPstmt.executeQuery();
			
			int ref = 1;
			if(objRs.next()) ref = objRs.getInt(1)+1;
			
			File file = new File(SAVEFOLDER);
			
			if(!file.exists()) file.mkdirs();
			
			multi = new MultipartRequest(req, SAVEFOLDER, maxSize, encType, new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("fileName") != null) {
				fileName = multi.getFilesystemName("fileName");
				fileSize = (int)multi.getFile("fileName").length();
			}
			String content = multi.getParameter("content");
			
			sql = "insert into tblQnA(uName, subject, content, ref, pos, depth, regDate, pass, ip, count, fileName, fileSize)"
					+ " values (?, ?, ?, ?, 0, 0, now(), ?, ?, 0, ?, ?)";
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1,  multi.getParameter("uName"));
			objPstmt.setString(2,  multi.getParameter("subject"));
			objPstmt.setString(3,  content);
			objPstmt.setInt(4,  ref);
			objPstmt.setString(5,  multi.getParameter("pass"));
			objPstmt.setString(6,  multi.getParameter("ip"));
			objPstmt.setString(7,  fileName);
			objPstmt.setInt(8,  fileSize);
			objPstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("SQL"+ e.getMessage());
		}catch (Exception e) {
			System.out.println("DB" + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
	}
	
	// 리뷰 입력 끝
	
	// List 출력
	
	public Vector<QnABean> getQnAList(int start, int end){
		
		Vector<QnABean> vList = new Vector<>();
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		
		try {
			objConn = pool.getConnection();
			sql = "select*from tblQnA order by num desc limit ?,?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, start);
			objPstmt.setInt(2, end);
			objRs = objPstmt.executeQuery();
			
			while(objRs.next()) {
				QnABean bean = new QnABean();
				bean.setNum(objRs.getInt("num"));
				bean.setSubject(objRs.getString("subject"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setuName(objRs.getString("uName"));
				
				vList.add(bean);
			}
		}catch (Exception e) {
			System.out.println("SQL : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return vList;
	}
	
	// List 출력 끝
	
	// Read 시작
	
	public QnABean getQnA(int num) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		
		QnABean bean = new QnABean();
		try {
			objConn = pool.getConnection();
			sql = "select*from tblQnA where num = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next()) {
				bean.setNum(objRs.getInt("num"));
				bean.setuName(objRs.getString("uName"));
				bean.setSubject(objRs.getString("subject"));
				bean.setContent(objRs.getString("content"));
				bean.setPos(objRs.getInt("pos"));
				bean.setDepth(objRs.getInt("depth"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setPass(objRs.getString("pass"));
				bean.setCount(objRs.getInt("count"));
				bean.setFileName(objRs.getString("fileName"));
				bean.setFileSize(objRs.getInt("fileSize"));
				bean.setIp(objRs.getString("ip"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("SQL : "+e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return bean;
	}
	// Read 끝
	
	// 페이지 출력
	
	public int getTotalCount(String keyField, String keyWord) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int totalCnt = 0;
		
		try {
			objConn = pool.getConnection(); // DB연동
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblQnA";
				objPstmt = objConn.prepareStatement(sql);
			} else {
				sql = "select count(*) from tblQnA ";
				sql += "where "+keyField+" like ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%" + keyWord + "%");
			}

			objRs = objPstmt.executeQuery();

			if (objRs.next()) {
				totalCnt = objRs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return totalCnt;
	}
	
		
	// 페이지 출력 끝
	
	// 리뷰 수정
	
	public int updateQnA(QnABean bean) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		int exeCnt = 0;
		
		try {
			objConn = pool.getConnection();
			sql = "update tblQnA set uName=?, subject=?, content=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuName());
			objPstmt.setString(2, bean.getSubject());
			objPstmt.setString(3, bean.getContent());
			objPstmt.setInt(4, bean.getNum());
			exeCnt = objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	
	}
	
	// 리뷰 수정 끝
	
	//Delete 시작
	
	public int deleteQnA(int num) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		
		int exeCnt = 0;
		
		try {
			objConn = pool.getConnection();
			
			sql = "select fileName from tblQnA whrere num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1,  num);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next() && objRs.getString(1) != null) {
				if(!objRs.getString(1).equals("")) {
					String fName = objRs.getString(1);
					String fileSrc = SAVEFOLDER + "/" + fName;
					File file = new File(fileSrc);
					
					if(file.exists())
						file.delete();
				}
			}
			
			
			sql = "delete from tblQnA where num = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("SQL : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return exeCnt;
		
		
	}
	
	
	//Delete 끝
	
	public int replyQnA(QnABean bean) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int cnt = 0;
		
		try {
			
			objConn = pool.getConnection();
			
			sql = "insert into tblQnA (uName, content, subject, ref, pos, depth, regDate, pass, count, ip) values(?, ?, ?, ?, ?, ?,now(), ?, 0, ?)";
			
			int depth = bean.getDepth()+1;
			int pos = bean.getPos()+1;
			
			objPstmt =objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuName());
			objPstmt.setString(2, bean.getContent());
			objPstmt.setString(3, bean.getSubject());
			objPstmt.setInt(4, bean.getRef());
			objPstmt.setInt(5, pos);
			objPstmt.setInt(6, depth);
			objPstmt.setString(7, bean.getPass());
			objPstmt.setString(8, bean.getIp());
			cnt = objPstmt.executeUpdate();
			
			
		}catch(Exception e) {
			System.out.println("SQL : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return cnt;
		
		
	}
	
	public int replyUpQnA(int ref, int pos) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int cnt = 0;
		
		try {
			
			objConn = pool.getConnection();
			
			sql = "update tblQnA set pos = pos+1 where ref = ? and pos > ?";
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, ref);
			objPstmt.setInt(2, pos);
			cnt = objPstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("SQL : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return cnt;
		
	}
	
	
	

}
