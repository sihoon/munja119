package com.m.point;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.member.JoinVO;

public class PointHistory implements PointHistoryAble {
	
	public int totalCnt = 0;
	public int subcnt = 0;
	static PointHistory ph = new PointHistory();
	
	public static PointHistory getInstance(){
		return ph;
	}
	
	@Override
	public List<PointHistoryVO> getPointHistoryList(Connection conn, String userId, String whenMonth) {

		
		ArrayList<PointHistoryVO> rslt = new ArrayList<PointHistoryVO>();
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, VbyP.messageFormat(VbyP.getSQL("selectPointHistoryLog"), new Object[]{whenMonth}) );
		pq.setString(1, userId);
		
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		al = pq.ExecuteQueryArrayList();
		
		int count = al.size();
		if (count > 0) {
			
			PointHistoryVO vo = null;
			HashMap<String, String> h = null;
			
			try {
				
				for (int i = 0; i < count; i++) {
					
					vo = new PointHistoryVO();
					h = al.get(i);
					String _pointTemp = SLibrary.IfNull(h, "point");
					int point = Integer.parseInt(_pointTemp) / 25;
					
					vo.setAll( i+1, SLibrary.IfNull(h, "memo"), point, SLibrary.IfNull(h, "timeWrite") );
					
					rslt.add(vo);
				}
			}catch(Exception e){System.out.println("getSentGroupList Error!");}
			
			h = null;
			al = null;
		}
		
		
		return rslt;
	}
	
	
	public ArrayList<HashMap<String, String>> getPointHistoryList(Connection conn, String userId, int start, int end) {

		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, VbyP.getSQL("selectPointHistoryLogCnt") );
		pq.setString(1, userId);
		this.totalCnt = pq.ExecuteQueryNum();
		
		pq.setPrepared(conn, VbyP.getSQL("selectPointHistoryLog") );
		pq.setString(1, userId);
		pq.setInt(2, start);
		pq.setInt(3, end);
		
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		al = pq.ExecuteQueryArrayList();
		
		  
		return al;
	}
	
		//////////////////////////////////////////////////////////////////////////12.19
		public ArrayList<HashMap<String, String>> getSubPhone(Connection conn, String user_id){
		
		
		ArrayList<HashMap<String, String>> rslt = null;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, VbyP.getSQL("mysubnumSelect"));
		pq.setString(1, user_id);
		//	VbyP.accessLog("===------------...--not sql-----------=============" );
		rslt = pq.ExecuteQueryArrayList();
		
		//VbyP.accessLog("===------------...--ExecuteQueryArrayList() 다녀옴!-----------===========rslt==" +rslt);
		
		return rslt;
		} // 12.23

		
		public int insertsubphone(JoinVO vo){
			
			VbyP.accessLog("join.java===getAddid??============== "+vo.getAddid() );  //�α׺���
			
		    Connection CN = null;
			int ok=0;
			try{
				CN = VbyP.getDB();
				PreparedExecuteQueryManager PST = new PreparedExecuteQueryManager();
				 PST.setPrepared(CN, VbyP.getSQL("mysubnuminsert"));
				 
				 VbyP.accessLog("join.java================sql.properties===== " );  //�α׺���
				 
			     PST.setString(1, vo.getAddid());
			     PST.setString(2, vo.getSubphone());
			     PST.setString(3, vo.getSname());
		      
		      ok = PST.executeUpdate();
			}catch (Exception e) {}
			finally {
				try {
					if ( CN != null )
						CN.close();
				}catch(SQLException e) {
					VbyP.errorLog("Join.insertsubphone >> conn.close() Exception!"); 
				}
			}
			return ok;
		} //12.23
		
	
	
	
	public ArrayList<HashMap<String, String>> getSubPhoneList(Connection conn, String userId, int start, int end) {
		//VbyP.accessLog("===------------...--Where! addid !- mysubphonecnt----------===========userId==" +userId);
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, VbyP.getSQL("mysubphonecnt"));
		pq.setString(1, userId);
		this.subcnt = pq.ExecuteQueryNum();
		
	//VbyP.accessLog("===------------...쿼리문 수행!!-");
		
		
		pq.setPrepared(conn, VbyP.getSQL("mysubphonList") );
		pq.setString(1, userId);
		pq.setInt(2, start);
		pq.setInt(3, end);
		
		ArrayList<HashMap<String, String>> subList = new ArrayList<HashMap<String, String>>();
		subList = pq.ExecuteQueryArrayList();
		
		
		return subList;
		
	}
	
	public void deletesubphone(Connection conn, String delnum) {
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		System.out.println("PointHistory!!!");
			pq.setPrepared(conn, VbyP.getSQL("mysubDelete"));
			pq.setString(1, delnum);
			pq.executeUpdate();
	}
	
	
	//////////////12.20

	
	

}