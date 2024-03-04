package com.icia.semi.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("apply")
public class applyDto {
	private int a_id;
	private String c_storename;
	private int c_id;
	private String m_id;
}
