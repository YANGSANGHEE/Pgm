package com.example.demo.pgm;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
public class PgSvcImpl {
	
	private final SqlSession sqlSession;
	//SqlSession Interface import 
	
	//리스트 받기
	public List<HashMap<String,Object>> getPgmList() throws Exception{
		List <HashMap<String,Object>> result = sqlSession.selectList("getPgmList"); 
		
		return result;
	}
	
	//리스트 (행)인서트
	public List<HashMap<String,Object>> insertPgmData(List<HashMap<String,Object>> model) throws Exception {
		
		sqlSession.insert("insertPgmList",model);
		
		return null;
	}
	
	//리스트 (행)선택 삭제
	public List<HashMap<String,Object>> deletePgmData(List<HashMap<String,Object>> model) throws Exception {
		
		sqlSession.delete("deletePgmList",model);
		
		return null;
	}
	
	//리스트 (행)업데이트
	public List<HashMap<String,Object>> UpdatePgmData(List<HashMap<String,Object>> model) throws Exception {
		
		sqlSession.update("updatePgmList",model);
		
		return null;
	}
	
	//검색
	public List<HashMap<String,Object>> searchPgmData(HashMap<String, Object> model) throws Exception {
		
		List<HashMap<String,Object>> result = sqlSession.selectList("searhPgmList",model);
		
		System.out.println(result);
		
		return result;
	}
}
