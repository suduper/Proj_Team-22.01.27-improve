package pack_goods;

import java.util.*;
import java.io.*;

import java.text.SimpleDateFormat;


import java.io.File;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;




public class GoodsProc {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER
	="C:/ShoppingMall/Proj_LOFI/src/main/webapp/Resource/GoodsImg/";
	private static String encType = "UTF-8";
	private static int maxSize = 100*1024*1024;
	
	public GoodsProc() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}
	}

/*
	public int regGoodsInfo(  String goodsName, 
										 String goodsType,
										 int goodsPrice,
										 int goodsSPrice, 
										 String goodsContent) {
		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet				objRs 					=		null;
		String						sql 					=		null;
		
		try {
			objConn = pool.getConnection();
			sql = "insert into GoodsInfo ("
					+ "goodsName,"
					+ "goodsType,"
					+ "goodsPrice,"
					+ "goodsSPrice,"
					+ "goodsContent,"
					+ "regDate"
					+ ")values(?,?,?,?,?, now())";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1,goodsName);
			objPstmt.setString(2,goodsType);
			objPstmt.setInt(3,goodsPrice);
			objPstmt.setInt(4,goodsSPrice);
			objPstmt.setString(5,goodsContent);
			objPstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return 1;
	} */
	
	//              상품     등록     시작        //
	public void regGoodsImg(HttpServletRequest req,String name) {		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql 					=		null;
		MultipartRequest		multi 				=		null;
		String						fileName 			=		null;
		
		ServletContext context = req.getServletContext();
		ArrayList saveFiles = new ArrayList();
		ArrayList origFiles = new ArrayList();
		
		 Date now = new Date();
		 SimpleDateFormat fm = new SimpleDateFormat("_yyMMddhhmm");
		 String add = fm.format(now);
		
		try {
			objConn = pool.getConnection();
			
			String SaveDir = SAVEFOLDER+name+add;      // 상품 이미지 저장위치 
			String ThumDir = SAVEFOLDER+name+add+"/thum"; // 썸네일 이미지 저장위치

			File file = new File(SaveDir);  // 상품이름으로 폴더생성
			if (!file.exists()) {
				System.out.println("goods folder created!!!");
				file.mkdirs();
			}
			
			File thum = new File(ThumDir); // 상품이름 폴더 내에 썸네일용 폴더 생성
			if (!thum.exists()) {
				System.out.println("thum folder created!!!");
				thum.mkdirs();
			}

			multi = new MultipartRequest( //파일저장
					req, 
					SaveDir,
					maxSize,
					encType,
					new DefaultFileRenamePolicy()
					);
			
			Enumeration files = multi.getFileNames(); //파일 리스트화 프로세스
			while (files.hasMoreElements()){
				String FN = (String)files.nextElement();
				saveFiles.add(multi.getFilesystemName(name));
				origFiles.add(multi.getOriginalFileName(name));
			}
			
			System.out.println("파일갯수 : "+saveFiles.size());

			String[] names = new String[saveFiles.size()];
			String resetNames = "";
			
			for (int i = 0; i <= saveFiles.size() -1; i++) {
				names[i] = multi.getFilesystemName("goodsImages"+i); //파일명  받기 
				File orig = new File(SaveDir+"/"+names[i]);  //파일 위치
				if(i == saveFiles.size() -1) {
					if(orig.exists()) {  //파일 존재여부 확인 (만일 존재하면)
						String thumnail ="TNL_"+names[i]; //파일이름 변경
						
						//////////////////////////// 이전 썸네일 제작 방식 (임시)
						/*
						int dot = -1;  
						dot=names[i].lastIndexOf("."); //파일 확장자 위치
						String thumnail = "TNL"+
													names[i].substring(dot,names[i].length()); //파일이름 변경
						*/
						////////////////////////////
						File set = new File(thum+"/"+thumnail); //썸네일 폴더 내에 변경한 파일검색
						orig.renameTo(set); //저장 파일명 변경
						System.out.println("변경저장 성공");
						names[i] = thumnail; //DB에 저장될 파일이름은 thumnail 이름변경파일로 지정
					}
					System.out.println("해당 파일명을 썸네일로 저장 : "+names[i]);
				}
				
				resetNames +=names[i];
				if(i<=saveFiles.size()-2) {
					resetNames += " , ";
				}
				
				
			}	
			
			System.out.println(resetNames);

			
			int SPC = Integer.parseInt(multi.getParameter("goodsSPrice"));
			if(multi.getParameter("goodsSPrice") != "") {
				SPC = Integer.parseInt(multi.getParameter("goodsSPrice"));
			}else {
				SPC = 0;
			}
			System.out.println("세일가격 : " + SPC);
			
			sql = "insert into GoodsInfo ("
					+ "goodsName,"
					+ "goodsType,"
					+ "goodsPrice,"
					+ "goodsSPrice,"
					+ "goodsImages,"					
					+ "goodsContent,"
					+ "regDate"
					+ ")values(?,?,?,?,?,?, now())";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, (multi.getParameter("goodsName")+add));
			objPstmt.setString(2,multi.getParameter("goodsType"));
			objPstmt.setInt(3,Integer.parseInt(multi.getParameter("goodsPrice")));
			objPstmt.setInt(4, SPC);
			objPstmt.setString(5, resetNames);
			objPstmt.setString(6,multi.getParameter("goodsContent"));
			objPstmt.executeUpdate();
			
			
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
	}
	//  			상품 등록      끝       //
	
	// 저장된 상품 리스트 불러오기 시작 //
	public Vector<Goods> getBoardList() {

		Vector<Goods> GoodsList = new Vector<>();
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;

		try {
			objConn = pool.getConnection();   // DB연동구문 사용
			sql = "select * from goodsInfo order by goodsnum desc limit ?, ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, 0);
			objPstmt.setInt(2, 20);
			objRs = objPstmt.executeQuery();
	
		while (objRs.next()) {
			Goods bean = new Goods();
			bean.setGoodsNum(objRs.getInt("goodsNum"));
			bean.setGoodsName(objRs.getString("goodsName"));
			bean.setGoodsType(objRs.getString("goodsType"));
			bean.setGoodsPrice(objRs.getInt("goodsPrice"));
			bean.setGoodsSPrice(objRs.getInt("goodsSPrice"));
			bean.setGoodsImages(objRs.getString("goodsImages"));
			bean.setRegDate(objRs.getString("regDate"));
			bean.setCount(objRs.getInt("count"));
			GoodsList.add(bean);
		}
	} catch (Exception e) {
		System.out.println("SQL이슈 : " + e.getMessage());
	} finally {
		pool.freeConnection(objConn, objPstmt, objRs);
	}

return GoodsList;
}
// 저장된 상품 리스트 불러오기 종료 //

	
	
	
	
}







