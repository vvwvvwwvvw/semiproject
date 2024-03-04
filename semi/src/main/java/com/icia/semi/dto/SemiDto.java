package com.icia.semi.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("content")
public class SemiDto {
	private int c_id;
	private String m_id; //참조 아이디
	private String c_name; // 제목
	private String c_storename;// 상호명
	private String c_content;// 내용
	private String c_money;// 시급
	private String c_address; // 주소
	private String c_day; // 요일
	private String c_time; // 시간
	private String p_sysname;// 포스터 저장이름
}
