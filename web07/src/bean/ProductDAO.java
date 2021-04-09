package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProductDAO {
	DBConnectionMgr dbcp;
	public ProductDAO() {
		dbcp = DBConnectionMgr.getInstance();
		// 싱글턴, jdbc 1 2 단계
	}
	
	public ArrayList<ProductDTO> list() throws Exception{
		Connection con = dbcp.getConnection();
		String sql = "select * from product";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		//dto 넣을 컨테이너 생성해둠.
		ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();
		while(rs.next()) { //해당 행이 있으면
			//dto를 생성
			//각 칼럼의 값을 꺼낸 것을 dto에 넣는다.
			ProductDTO dto = new ProductDTO();
			dto.setId(rs.getString("id"));
			dto.setName(rs.getString(2));
			dto.setContent(rs.getString(3));
			dto.setPrice(rs.getString(4));
			dto.setCompany(rs.getString(5));
			dto.setImg(rs.getString(6));
			list.add(dto);
		}
		dbcp.freeConnection(con, ps, rs);
		return list;
	}
	
	public ProductDTO one(String id) throws Exception{
		Connection con = dbcp.getConnection();
		String sql = "select * from product where id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();
		ProductDTO dto = new ProductDTO();
		if(rs.next()) { //해당 행이 있으면
			dto.setId(rs.getString("id"));
			dto.setName(rs.getString(2));
			dto.setContent(rs.getString(3));
			dto.setPrice(rs.getString(4));
			dto.setCompany(rs.getString(5));
			dto.setImg(rs.getString(6));
		}
		dbcp.freeConnection(con, ps, rs);
		return dto;
	}
}
