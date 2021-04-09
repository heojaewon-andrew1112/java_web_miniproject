package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	DBConnectionMgr dbcp;
	public BbsDAO() {
		dbcp = DBConnectionMgr.getInstance();
	}
	
	public boolean insert(BbsDTO dto) {
		Connection con = null;
		boolean result2 = false;
		PreparedStatement ps = null;
		try {
			con = dbcp.getConnection();
			String sql = "insert into bbs values (null,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			ps.setString(3, dto.getWriter());
			int result = ps.executeUpdate();
			if(result != 0) {
				result2 = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dbcp.freeConnection(con, ps);
		return result2;
	}
	
	public boolean delete(String id) {
		Connection con = null;
		boolean result2 = false;
		PreparedStatement ps = null;
		try {
			con = dbcp.getConnection();
			String sql = "delete * from bbs where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			int result = ps.executeUpdate();
			if(result != 0) {
				result2 = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dbcp.freeConnection(con, ps);
		return result2;
		}
	
	public boolean update(BbsDTO dto) {
		Connection con = null;
		boolean result2 = false;
		PreparedStatement ps = null;
		try {
			con = dbcp.getConnection();
			String sql = "update bbs set title = ?, content = ? where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			ps.setString(3, dto.getId());
			int result = ps.executeUpdate();
			if(result != 0) {
				result2 = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dbcp.freeConnection(con, ps);
		return result2;
	}
	
	public ArrayList<BbsDTO> list() throws Exception{
		Connection con = dbcp.getConnection();
		String sql = "select * from bbs order by id desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		//dto넣을 컨테이너 생성해둠.
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		while(rs.next()) {//해당 행이 있으면
			BbsDTO dto = new BbsDTO();
			dto.setId(rs.getString(1));
			dto.setTitle(rs.getString(2));
			dto.setContent(rs.getString(3));
			dto.setWriter(rs.getString(4));
			list.add(dto);
		}
		dbcp.freeConnection(con, ps, rs);
		return list;
	}
	
	public BbsDTO one(String id) throws Exception{
		Connection con = dbcp.getConnection();
		String sql = "select * from bbs where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();
		BbsDTO dto = new BbsDTO();
		while(rs.next()) {//해당 행이 있으면
			dto.setId(rs.getString(1));
			dto.setTitle(rs.getString(2));
			dto.setContent(rs.getString(3));
			dto.setWriter(rs.getString(4));
		}
		dbcp.freeConnection(con, ps, rs);
		return dto;
	}
	
	
	
}
