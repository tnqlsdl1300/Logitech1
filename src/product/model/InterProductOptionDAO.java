package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductOptionDAO {

	//옵션
	List<ProductOptionVO> viewOption() throws SQLException;

	
	
}
