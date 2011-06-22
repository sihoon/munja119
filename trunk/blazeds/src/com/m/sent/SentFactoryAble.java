package com.m.sent;

import java.util.List;
import java.sql.Connection;

import com.m.common.BooleanAndDescriptionVO;
import com.m.member.UserInformationVO;

public interface SentFactoryAble {

	List<SentGroupVO> getSentGroupList(Connection conn, String user_id, String fromDate, String endDate, boolean bReservation);
	List<SentVO> getSentList(Connection connSMS, String user_id, String line, String sentGroupIndex);
	
	SentStatisticVO getSentStatistic(Connection connSMS, String userId, String sentClientName, int year, int month, String sentGroupIndex);
	
	BooleanAndDescriptionVO deleteSentGroupList(Connection conn, String user_id, String pay_type, int idx, int year, int month);
	BooleanAndDescriptionVO deleteSentGroupList(Connection conn, String user_id, int year, int month);
	BooleanAndDescriptionVO cancelSentGroupList(Connection conn, Connection connSMS, UserInformationVO mvo, int idx, int year, int month) throws Exception ;
	
}
