package com.mvc.hospital.model.service;

import java.sql.Connection;
import java.util.List;

import com.mvc.common.jdbc.JDBCTemplate;
import com.mvc.common.util.PageInfo;
import com.mvc.hospital.model.dao.HospitalDAO;
import com.mvc.hospital.model.vo.Hospital;
import com.mvc.member.model.vo.Location;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class HospitalService {

	private HospitalDAO dao = new HospitalDAO();
	
	public int getHospitalCount() {
		Connection connection = JDBCTemplate.getConnection();
		int count = dao.getHospitalCount(connection);
		
		JDBCTemplate.close(connection);
		
		return count;
	}
	public int getClinicCount() {
		Connection connection = JDBCTemplate.getConnection();
		int count = dao.getClinicCount(connection);
		
		JDBCTemplate.close(connection);
		
		return count;
	}
	

	public List<Hospital> getHospitalList(PageInfo pageInfo) {
		Connection connection = getConnection();
		List<Hospital> list = dao.findHospitalAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}
	public List<Hospital> getClinicList(PageInfo pageInfo) {
		Connection connection = getConnection();
		List<Hospital> list = dao.findClinicAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}
	
	public List<Hospital> getHospitalSeoulList(PageInfo pageInfo) {
		Connection connection = getConnection();
		List<Hospital> list = dao.findClinic_typeLocation(connection, pageInfo);
		
		close(connection);
		
		return list;
	}

	

}
