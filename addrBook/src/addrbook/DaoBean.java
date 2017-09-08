package addrbook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoBean {
	Connection conn;
	PreparedStatement pstmt;
	
	public void connect() {
		String path = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "madang";
		String pswd = "madang";
		try {
			Class.forName( "oracle.jdbc.driver.OracleDriver" );
			conn = DriverManager.getConnection( path, user, pswd );
		} catch( ClassNotFoundException e ) {
			e.printStackTrace();
		} catch( SQLException e ) {
			e.printStackTrace();
		}
		
	}
	
	public void disconnect() {
		if( pstmt != null ) {
			try {
				pstmt.close();
			} catch( SQLException e ) {
				e.printStackTrace();
			}
		}
		if( conn != null ) {
			try {
				conn.close();
			} catch( SQLException e ) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean updateDB( AddrBean ab ) {
		connect();
		
		String sql = "UPDATE AddrBook SET ab_name=?, ab_email=?, ab_birth=?, "
				   + "ab_tel=?, ab_comdept=?, ab_memo=? "
				   + "WHERE ab_id=?";
		
		try {
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, ab.getAb_name() );
			pstmt.setString( 2, ab.getAb_email() );
			pstmt.setString( 3, ab.getAb_birth() );
			pstmt.setString( 4, ab.getAb_tel() );
			pstmt.setString( 5, ab.getAb_comdept() );
			pstmt.setString( 6, ab.getAb_memo() );
			pstmt.setInt( 7, ab.getAb_id() );
			pstmt.executeUpdate();
			
		} catch( SQLException e ) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		
		return true;
	}
	
	public boolean deleteDB( int gb_id ) {
		connect();
		
		String sql = "DELETE FROM AddrBook WHERE ab_id=?";
		try {
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt( 1, gb_id );
			pstmt.executeUpdate();
			
		} catch( SQLException e ) { 
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public boolean insertDB( AddrBean ab ) {
		connect();
		
		String sql = "INSERT INTO Addrbook( "
				   + "ab_id, ab_name, ab_email, ab_birth, ab_tel, ab_comdept, ab_memo ) "
				   + "VALUES( seq_ab_id.NEXTVAL, ?, ?, ?, ?, ?, ? )";
		
		try {
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, ab.getAb_name() );
			pstmt.setString( 2, ab.getAb_email() );
			pstmt.setString( 3, ab.getAb_birth() );
			pstmt.setString( 4, ab.getAb_tel() );
			pstmt.setString( 5, ab.getAb_comdept() );
			pstmt.setString( 6, ab.getAb_memo() );
			pstmt.executeUpdate();
		} catch( SQLException e ) {
			e.printStackTrace();
			return false;
		} finally {
			System.out.println("PASS");
			disconnect();
			System.out.println("PASS, AGAIN");
		}
		
		return true;
	}
	
	public AddrBean getDB( int gb_id ) {
		connect();
		
		String sql = "SELECT * FROM AddrBook WHERE ab_id=?";
		AddrBean addrBean = new AddrBean();
		
		try {
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt( 1, gb_id );
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			addrBean.setAb_id(		rs.getInt( "ab_id" ) );
			addrBean.setAb_name(	rs.getString( "ab_name" ) );
			addrBean.setAb_email(	rs.getString( "ab_email" ) );
			addrBean.setAb_birth(	rs.getString( "ab_birth" ) );
			addrBean.setAb_tel(		rs.getString( "ab_tel" ) );
			addrBean.setAb_comdept(	rs.getString( "ab_comdept" ) );
			addrBean.setAb_memo(	rs.getString( "ab_memo" ) );
			rs.close();
			
		} catch( SQLException e ) {
			e.printStackTrace();
			return null;
		} finally {
			disconnect();
		}
		
		return addrBean;
	}
	
	public ArrayList<AddrBean> getDBList() {
		connect();
		ArrayList<AddrBean> datas = new ArrayList<AddrBean>();
		
		String sql = "SELECT * FROM AddrBook ORDER BY ab_id DESC";
		
		try {
			pstmt = conn.prepareStatement( sql );
			ResultSet rs = pstmt.executeQuery();
			while( rs.next() ) {
				AddrBean addrBean = new AddrBean();
				
				addrBean.setAb_id(		rs.getInt( "ab_id" ) );
				addrBean.setAb_name(	rs.getString( "ab_name" ) );
				addrBean.setAb_email(	rs.getString( "ab_email" ) );
				addrBean.setAb_comdept(	rs.getString( "ab_comdept" ) );
				addrBean.setAb_birth(	rs.getString( "ab_birth" ) );
				addrBean.setAb_tel(		rs.getString( "ab_tel" ) );
				addrBean.setAb_memo(	rs.getString( "ab_memo" ) );
				datas.add( addrBean );
			}
			rs.close();
			
		} catch( SQLException e ) {
			e.printStackTrace();
			return null;
		} finally {
			disconnect();
		}
		
		return datas;
	}
	
}
