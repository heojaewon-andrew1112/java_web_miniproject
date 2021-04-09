package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReplyDAO {
	DBConnectionMgr dbcp;
	public ReplyDAO() {
		dbcp = DBConnectionMgr.getInstance();
	}
	
	public boolean insert(ReplyDTO dto) {
		Connection con = null;
		boolean result2 = false;
		PreparedStatement ps = null;
		try {
			con = dbcp.getConnection();
			String sql = "insert into reply values (null,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getOriid());
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
	
	public ArrayList<ReplyDTO> list(String oriid) throws Exception{
		Connection con = dbcp.getConnection();
		String sql = "select * from reply where oriid = ? order by id desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, oriid);
		ResultSet rs = ps.executeQuery();
		ArrayList<ReplyDTO> list = new ArrayList<>();
		while(rs.next()) { //해당 행이 있으면
			ReplyDTO dto = new ReplyDTO();
			dto.setId(rs.getString(1));
			dto.setOriid(rs.getString(2));
			dto.setContent(rs.getString(3));
			dto.setWriter(rs.getString(4));
			list.add(dto);
		}
		dbcp.freeConnection(con, ps, rs);
		return list;
	}
	
	
}
