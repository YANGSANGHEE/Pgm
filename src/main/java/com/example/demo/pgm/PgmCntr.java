package com.example.demo.pgm;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import net.sf.json.JSONArray;

import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.List;


@Controller
@RequiredArgsConstructor
public class PgmCntr {

	private final PgSvcImpl pgSvcImpl;
	
	//메인 페이지
	@RequestMapping("/")
	public String PgmMain() {
		return "pgMg";
	}
	
	//PGM_list 블러오기
	@ResponseBody
	@RequestMapping("/api/getlist")
	public List <HashMap<String,Object>> getPgmList() throws Exception{
		
		return pgSvcImpl.getPgmList();
	}
	
	//PGM_list 행 추가
	@RequestMapping("/api/save")
	@ResponseBody
	public String getPgmData(@RequestBody String param) throws Exception{
		
		List<HashMap<String,Object>> resultMap = JSONArray.fromObject(param);
		pgSvcImpl.insertPgmData(resultMap);
		
		System.out.println(resultMap);
		
		return "insert success";
	}
	
	//PGM_list 행 삭제
	@RequestMapping("/api/delete")
	@ResponseBody
	public String delPgmData(@RequestBody String param) throws Exception{
		
		List<HashMap<String,Object>> resultMap = JSONArray.fromObject(param);
		pgSvcImpl.deletePgmData(resultMap);
		
		return "delete success";
	}
	
	//PGM_list 행 수정
	@RequestMapping("/api/update")
	@ResponseBody
	public String UpPgmData(@RequestBody String param) throws Exception{
		
		List<HashMap<String,Object>> resultMap = JSONArray.fromObject(param);
		
		pgSvcImpl.UpdatePgmData(resultMap);	
		
		return "update success";
	}
	
	//PGM_search
	@RequestMapping("/api/search")
	@ResponseBody
	public List<HashMap<String,Object>> serPgmData(@RequestBody HashMap<String, Object> param) throws Exception{
		
		System.out.println(param);
		
		return pgSvcImpl.searchPgmData(param);
	}
}
