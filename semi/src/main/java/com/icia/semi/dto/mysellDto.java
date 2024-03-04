package com.icia.semi.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("myDto")
public class mysellDto {
	private int s_id; // 고유 아이디
	private String s_name; //회원 이름
	private String s_age; // 회원의 나이
	private String s_address;  //회원 주소
	private String s_contents;  //회원 이력내용
	private String s_sysname; // 회원 사진
	private String m_id; // 참조할 회원의 아이디값
}
