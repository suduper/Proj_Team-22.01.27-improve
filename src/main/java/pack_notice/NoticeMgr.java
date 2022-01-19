package pack_notice;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.sql.*;
import java.util.Vector;

public class NoticeMgr {
	
	public DBConnectionMgr pool;

	public NoticeMgr() {
		
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public void insertNotice(HttpServletRequest req) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		String name = null;
		
		try {
			
			objConn = pool.getConnection();
			
			sql = "select max(num) from tblNotice";
			objPstmt = objConn.prepareStatement(sql);
			objRs = objPstmt.executeQuery();
			
			
			sql = "insert into tblNotice (uName, subject, content, regDate, ip) values(?, ?, ?, now(), ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, req.getParameter("uName"));
			objPstmt.setString(2, req.getParameter("subject"));
			objPstmt.setString(3, req.getParameter("content"));
			objPstmt.setString(4, req.getParameter("ip"));

			objPstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("SQL"+ e.getMessage());
		}catch (Exception e) {
			System.out.println("DB" + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
	}
	
	public Vector<NoticeBean> getNoticeList(int start, int end){
		
		Vector<NoticeBean> vList = new Vector<>();
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		
		try {
			
			objConn = pool.getConnection();
			
			sql = "select * from tblNotice order by num desc limit ?, ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, 0);
			objPstmt.setInt(2, 5);
			objRs = objPstmt.executeQuery();
			
			while(objRs.next()) {
				
				NoticeBean bean = new NoticeBean();
				bean.setNum(objRs.getInt("num"));
				bean.setuName(objRs.getString("uName"));
				bean.setSubject(objRs.getString("subject"));
				bean.setContent(objRs.getString("content"));
				bean.setRegDate(objRs.getString("regDate"));
				
				vList.add(bean);
				
			}
			
			
		}catch (Exception e) {
			System.out.println("SQL2 : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return vList;
	}
	
	public int getTotalCount() {
		
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		int totalCnt = 0;
		
		try {
			
			objConn = pool.getConnection();
			
			sql = "select count(*) from tblNotice";
			objPstmt = objConn.prepareStatement(sql);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next()) {
				totalCnt = objRs.getInt(1);
			}
			
		}catch (Exception e) {
			System.out.println("SQL1 : " + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return totalCnt;
	}
	
	public NoticeBean getNotice(int num) {
		
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		
		NoticeBean bean = new NoticeBean();
		
		try {
			
			objConn = pool.getConnection();
			sql = "select*from tblNotice where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next()) {
				
				bean.setNum(objRs.getInt("num"));
				bean.setSubject(objRs.getString("subject"));
				bean.setuName(objRs.getString("uName"));
				bean.setContent(objRs.getString("content"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setIp(objRs.getString("ip"));
			}
			
		}catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return bean;
		
	}
	
	public int deleteNotice(int num) {
		
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		
		int exeCnt = 0;
		
		try {
			objConn = pool.getConnection();
			
			sql = "delete from tblNotice where num = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return exeCnt;
		
	}
	
	public int updateNotice(NoticeBean bean) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;

		
		int exeCnt = 0;
		
		try {
			
			objConn = pool.getConnection();
			sql = "update tblNotice set uName=?, subject=?, content=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuName());
			objPstmt.setString(2, bean.getSubject());
			objPstmt.setString(3, bean.getContent());
			objPstmt.setInt(4, bean.getNum());
			exeCnt = objPstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt);
		}
		return exeCnt;
	}
	

}
