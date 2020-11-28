package review.modul;

import java.sql.SQLException;
import java.util.List;

public interface InterReviewDAO {
	
	
	// 해당 제품의 review를 가져오기.
	List<ReviewVO> getReviewlist(String fk_productid) throws SQLException;
	
	
	
	
	
	
}
	