package review.modul;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class ReviewDAO implements InterReviewDAO {
	
	
	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	
	// 기본생성자
	public ReviewDAO() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi_oracle");

			// SecretMyKey.KEY 은 내가 만든 비밀키 이다.
			aes = new AES256(SecretMyKey.KEY);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	// 사용한 자원을 반납하는 close() 메서드 생성하기
	
	private void close() {
	      try {
	         if(rs != null)    {rs.close(); rs=null;}
	         if(pstmt != null) {pstmt.close(); pstmt=null;}
	         if(conn != null)  {conn.close(); conn=null;}
	      } catch(SQLException e) {
	         e.printStackTrace();
	      }
	}

	
	// 해당 제품의 리뷰 가져오기.
	@Override
	public List<ReviewVO> getReviewlist(String fk_productid) throws SQLException {
	
		List<ReviewVO> reviewlist = new ArrayList<ReviewVO>();
		
		
		
		try {
			
			conn = ds.getConnection();
			

			String sql = " select seq_review, A.fk_productid, color, userid, score, content, review_image, to_char(writeday, 'yyyy-mm-dd') "+
					" from review A join member B "+
					" on A.fk_memberno = B.memberno "+
					" join productoption C "+
					" on A.fk_productid = C.fk_productid "+
					" where A.fk_productid = ? "+
					" order by 1 desc ";

			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_productid);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				
				ReviewVO rvo = new ReviewVO();
				 rvo.setSeq_review(rs.getString(1));
				 rvo.setFk_productid(rs.getNString(2));
				 rvo.setColor(rs.getString(3));
				 rvo.setUserid(rs.getString(4));
				 rvo.setScore(rs.getString(5));
				 rvo.setContent(rs.getString(6));
				 rvo.setReview_image(rs.getString(7));
				 rvo.setWirteday(rs.getString(8));
				 reviewlist.add(rvo);
				 
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return reviewlist;
		
	}

	
	

	
}
