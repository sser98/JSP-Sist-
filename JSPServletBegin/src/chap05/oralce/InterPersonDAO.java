package chap05.oralce;

import java.sql.SQLException;
import java.util.List;

public interface InterPersonDAO {

	// 개인성향을 입력해주는 추상메소드(미완성메소드) ==> insert 
	int personRegister(PersonDTO psdto) throws SQLException;

	// tbl_person_interest 테이블에 저장된 모든행들을 select 해주는 메소드 
	List<PersonDTO> selectAll() throws SQLException;

	// tbl_person_interest 테이블에 저장된 특정 1개행만 select 해주는 메소드 
	PersonDTO selectOne(String seq) throws SQLException;

	// 개인성향을 입력해주는 추상메소드(미완성메소드) ==> update
	int personUpdate(PersonDTO psdto) throws SQLException;
	
}
