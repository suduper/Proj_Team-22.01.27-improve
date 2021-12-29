package pack_goods;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;

public class GoodsProc {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER ="C:/ShoppingMall/"
															   + "Project_Lofi_Co-op/"
															   + "src/main/webapp/"
															   + "Resource/GoodsImg/";
	private static String encType = "UTF-8";
	private static int maxSize = 100*1024*1024;
	
	public GoodsProc() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}
	}
	
	//              상품     등록     시작        //
	public void regGoodsImg(HttpServletRequest req) {		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql 					=		null;
		
		///////////////////////////////////////////////////////////////////
		String inputID = null; // id
		String properties = null; // id 의 내용
		String filename = null; //이미지 하나의 이름
		
		String goodsName = null; // 상품 이름
		String goodsType = null; // 상품 종류
		String goodsPrice = null; // 상품 판매가격
		String goodsSPrice = null; // 상품 세일가격
		String goodsThumbnail = null; // 상품 썸네일 이름
		String goodsImages = null; // 상품 이미지 이름
		String allImages = ""; // 모든 상품 이미지 이름
		String goodsContent = null; //상품 내용
		
		String goodsFolder = null; // 상품 폴더 초기화
		///////////////////////////////////////////////////////////////////
		
		 Date now = new Date();
		 SimpleDateFormat fm = new SimpleDateFormat("_yyMMddhhmm");
		 String add = fm.format(now);
		
		try {
			
		DiskFileUpload upload = new DiskFileUpload();
		upload.setRepositoryPath(SAVEFOLDER);
		upload.setSizeMax(100*1024 * 1024); // 최대 10메가
		upload.setSizeThreshold(1024 * 100); // 한번에 100Kb 까지는 메모리에 저장
		List items = upload.parseRequest(req);
		Iterator params = items.iterator();
		while (params.hasNext()) {
			FileItem fileItem = (FileItem) params.next();
			
			inputID = (String) fileItem.getFieldName(); //input name 요소
			filename = fileItem.getName(); //input 에 넣은 파일 이름요소 
			////////////////////////////////////////////
			if (fileItem.isFormField()) { // 파일이 아닌경우
				properties = fileItem.getString("UTF-8"); //파일이름 UTF-8로 인코딩
				
				if(inputID.equals("goodsName")){
					goodsName = properties;
					goodsFolder = SAVEFOLDER + (goodsName+add);
					File goodsFile = new File(goodsFolder);
					if(!goodsFile.exists()){
						goodsFile.mkdirs();
					}
					File goodsThumb = new File(goodsFolder + "/thumb");
					if(!goodsThumb.exists()){
						goodsThumb.mkdirs();
					}
				}
				if(inputID.equals("goodsType")){
					goodsType = properties;
				}
				if(inputID.equals("goodsPrice")){
					goodsPrice = properties;
				}
				if(inputID.equals("goodsSPrice")){
					goodsSPrice = properties;
				}
				if(inputID.equals("goodsContent")){
					goodsContent = properties;
				}
			}
			////////////////////////////////////////////
			////////////////////////////////////////////
			if (!fileItem.isFormField()) { //파일인경우
				properties = goodsName;
				String file = fileItem.getName();
				file = file.substring(file.lastIndexOf("/") + 1);
				
				if(inputID.equals("goodsThumbnail")){ //썸네일의 경우
					if (filename != null) {
					    filename = FilenameUtils.getName(filename);
						goodsThumbnail = filename;
					}
					goodsFolder = SAVEFOLDER + (goodsName+add);
					File thumb = new File(goodsFolder + "/thumb/thumb_" + file);
					fileItem.write(thumb);
					
				} else if(inputID.equals("goodsImages")){
					if (filename != null) {
					    filename = FilenameUtils.getName(filename);
					    goodsImages = filename;
					    allImages += goodsImages+" / ";
					}
					File Images = new File(goodsFolder + "/" + file);
					fileItem.write(Images);
				}
			}
			////////////////////////////////////////////
		}
		System.out.println("-----------------------------------------");
		System.out.println("상품 이름 : "+ goodsName+add );
		System.out.println("상품 종류 : " + goodsType );
		System.out.println("상품 판매가격 : " + goodsPrice );
		System.out.println("상품 세일 가격 : " + goodsSPrice );
		System.out.println("상품 썸네일 이름 : " + goodsThumbnail );
		System.out.println("상품 이미지 이름 : " + allImages );
		System.out.println("상품 설명 내용 : " + goodsContent );
		System.out.println("-----------------------------------------");
		
			objConn = pool.getConnection();

			sql = "insert into GoodsInfo ("
					+ "goodsName,"
					+ "goodsType,"
					+ "goodsPrice,"
					+ "goodsSPrice,"
					+ "goodsThumbnail,"
					+ "goodsImages,"					
					+ "goodsContent,"
					+ "regDate"
					+ ")values(?, ?, ?, ?, ?, ?, ?, now())";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, goodsName+add);
			objPstmt.setString(2, goodsType);
			objPstmt.setInt(3, Integer.parseInt(goodsPrice));
			objPstmt.setInt(4, Integer.parseInt(goodsSPrice));
			objPstmt.setString(5, goodsThumbnail);
			objPstmt.setString(6, allImages);
			objPstmt.setString(7, goodsContent );
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
			bean.setwCount(objRs.getInt("wcount"));
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

// 상품 조회수 증가 시작 //
	
	public void upCount(int goodsNum) {
		// 조회수 증가 시작
		Connection					objConn			=	null;
		PreparedStatement 		objPstmt 			= 	null;
		String								sql 				=	null;
		
		try {
			objConn = pool.getConnection();   // DB연동
			sql = "update GoodsInfo set count = count+1 where goodsNum=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, goodsNum);
			objPstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}
		
	}
	
// 상품 조회수 증가 끝 //
	
// 상품 정보 전송 시작 //
	public Goods getGoodsView(int num) {

		Connection					objConn			=	null;
		PreparedStatement 		objPstmt 			= 	null;
		String								sql 				=	null;
		ResultSet						  objRs				=	null;							
		
		Goods View = new Goods();
		try {
			objConn = pool.getConnection();   // DB연동
			sql = "select * from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRs = objPstmt.executeQuery();
			
			if (objRs.next()) {
				
				
				View.setGoodsNum(objRs.getInt("goodsNum"));
				View.setGoodsName(objRs.getString("goodsName"));
				View.setGoodsType(objRs.getString("goodsType"));
				View.setGoodsPrice(objRs.getInt("goodsPrice"));
				View.setGoodsSPrice(objRs.getInt("goodsSPrice"));
				View.setGoodsImages(objRs.getString("goodsImages"));
				View.setGoodsContent(objRs.getString("goodsContent"));
				View.setRegDate(objRs.getString("regDate"));
				View.setwCount(objRs.getInt("wcount"));
				
			}
			
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		
		return View;
	} 

// 상품 정보 전송 시작 //	
	
}







