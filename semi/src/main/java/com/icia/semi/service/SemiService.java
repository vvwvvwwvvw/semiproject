package com.icia.semi.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.semi.dao.SemiDao;
import com.icia.semi.dto.SemiDto;
import com.icia.semi.dto.applyDto;
import com.icia.semi.dto.memberDto;
import com.icia.semi.dto.mysellDto;
import com.icia.semi.util.PagingUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SemiService {
	// DAO
	@Autowired
	private SemiDao sDao;
	
	public String getapplyList(Integer pageNum, Model model, HttpSession session) {
		log.info("getapplyList()");
		
		if (pageNum == null) {
			pageNum = 1; // 처음에 페이지가 열릴때 첫 페이지가 되도록 설정
		}

		int listCnt = 5; // 페이지당 보여질 콘텐츠 개수

		Map<String, Integer> pMap = new HashMap<String, Integer>();
		pMap.put("pageNum", (pageNum - 1) * listCnt);
		pMap.put("listCnt", listCnt);
		
		List<applyDto> aList = sDao.getapplyList(pMap);
		
		model.addAttribute("aList",aList);
		
		String pageHtml = getPaging(pageNum, listCnt);
		model.addAttribute("paging", pageHtml);

		session.setAttribute("paging", pageNum);
		
		return "applyList";
	}

	// 게시글 목록을 가져와서 컨트롤러에 넘기는 메서드
	public String getContentList(Integer pageNum, Model model, HttpSession session) {
		log.info("getContentList()");

		if (pageNum == null) {
			pageNum = 1; // 처음에 페이지가 열릴때 첫 페이지가 되도록 설정
		}

		int listCnt = 5; // 페이지당 보여질 콘텐츠 개수

		Map<String, Integer> pMap = new HashMap<String, Integer>();
		pMap.put("pageNum", (pageNum - 1) * listCnt);
		pMap.put("listCnt", listCnt);

		List<SemiDto> sList = sDao.getContentList(pMap);

		model.addAttribute("sList", sList);

		// 페이징 처리

		String pageHtml = getPaging(pageNum, listCnt);
		model.addAttribute("paging", pageHtml);

		session.setAttribute("paging", pageNum);

		return "main";
	}

	private String getPaging(Integer pageNum, Integer listCnt) {
		String pageHtml = null;

		// 전체 게시글 개수
		int maxNum = sDao.cntContent();
		// 페이지당 보여질 번호 개수
		int pageCnt = 5;

		PagingUtil paging = new PagingUtil(maxNum, pageCnt, listCnt, pageCnt);

		pageHtml = paging.makePaging();

		return pageHtml;
	}

	public String insertContent(List<MultipartFile> files, SemiDto content, HttpSession session,
			RedirectAttributes rttr) {
		log.info("insertContent");
		String msg = null; // DB 저장 성공 실패 관련 메세지 저장
		String view = null; // 대상 페이지 저장 변수
		String upFile = files.get(0).getOriginalFilename();
		// 업로드 하는 파일의 이름을 추출

		try {
			if (!upFile.equals("")) {
				fileUpload(files, session, content);
			}
			sDao.insertContent(content);
			view = "redirect:main?pageNum=1";
			msg = "작성 성공";
		} catch (Exception e) { // 저장 실패
			e.printStackTrace();
			view = "redirect:jobFrm";
			msg = "작성실패";
		}
		rttr.addFlashAttribute("msg", msg);
		System.out.println();
		return view;
	}

	private void fileUpload(List<MultipartFile> files, HttpSession session, SemiDto content) throws Exception {
		log.info("fileUpload()");
		String sysname = null; // 변경하는 파일명
		String oriname = null; // 원래 파일명

		String realPath = session.getServletContext().getRealPath("/"); 
		log.info(realPath);
		realPath += "resources/upload/";
		File folder = new File(realPath);
		// isDirectory(): 해당 이름이 폴더가 아니거나 존재하지 않으면 false
		if (folder.isDirectory() == false) {
			folder.mkdir();// 폴더 생성 매서드
		}

		MultipartFile mf = files.get(0);
		oriname = mf.getOriginalFilename();

		sysname = System.currentTimeMillis() + oriname.substring(oriname.lastIndexOf("."));

		File file = new File(realPath + sysname);

		mf.transferTo(file); // 하드 디스크에 저장( 경로상의 폴더 ) 에 저장
		content.setP_sysname(sysname);
	}

	// 상세보기 처리 메서드 (수정 처리에서도 활용)
	public void getContent(Integer c_id, Model model) {
		log.info("getContent");
		// DB 에서 데이터 가져오기
		SemiDto content = sDao.selectContent(c_id);
		// model에 담기
		model.addAttribute("content", content);

	}

	public String contentUpdate(List<MultipartFile> files, SemiDto content, HttpSession session,
			RedirectAttributes rttr) {
		log.info("contentUpdate()");
		String msg = null;
		String view = null;
		String poster = content.getP_sysname(); // 기존 파일

		try {
			if (!files.get(0).isEmpty()) {
				fileUpload(files, session, content);

				// 기존 파일 삭제(포스터)
				if (poster != null) {
					fileDelete(poster, session);
				}
			}
			sDao.updateContent(content);

			view = "redirect:detail?c_id=" + content.getC_id();
			msg = "수정 성공";
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:updateFrm?c_id=" + content.getC_id();
		}

		rttr.addAttribute("msg", msg);
		return view;
	}

	private void fileDelete(String poster, HttpSession session) throws Exception {
		log.info("fileDelete()");

		String realPath = session.getServletContext().getRealPath("/");
		realPath += "resources/upload/" + poster;
		File file = new File(realPath);
		if (file.exists()) {
			file.delete();
		}
	}

	public String contentDelete(Integer c_id, HttpSession session, RedirectAttributes rttr) {
		log.info("contentDelete");
		String msg = null;
		String view = null;
		SemiDto content = sDao.selectContent(c_id);
		String poster = content.getP_sysname();
		try {
			if (poster != null) {
				fileDelete(poster, session);
			}
			sDao.deleteContent(c_id);

			view = "redirect:main?pageNum=1";
			msg = "삭제 성공";
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:detail?c_id=" + c_id;
			msg = "글에 대한 권한이 없습니다";
		}

		rttr.addFlashAttribute("msg", msg);
		return view;
	}
// 로그인 기능
	public String authenticate(memberDto member, HttpSession session, RedirectAttributes rttr) {
		log.info("authenticate()");
		String msg = null;
		String view = null;

		memberDto loging = sDao.login(member);

		System.out.println(loging);
		if (loging != null) {
			msg = "로그인 성공";
			view = "redirect:main?pageNum=1";
			session.setAttribute("member", loging);
			
		} else {
			msg = "로그인 실패 아이디 혹은 비밀번호를 다시 확인해 주세요";
			view = "redirect:login";
		}
		
		rttr.addFlashAttribute("msg", msg);
		return view;
	}

// 회원가입
	public String join(memberDto member, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		try {
			sDao.insertMember(member);
			view = "redirect:login";
			msg = "회원가입 완료";
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:join";
			msg = "회원가입에 실패 하였습니다 다시 시도 해주세요";
		}

		rttr.addAttribute("message", msg);
		return view;
	}

	public String checkDuplicateId(String m_id) {

		int cnt = sDao.checkDuplicateId(m_id);

		String res = null;
		if (cnt > 0) {
			// 아이디 있음
			res = "fail";
		} else {
			// 아이디 없음
			res = "ok";
		}

		return res;
	}

	// 로그아웃 기능
	public String logout(HttpSession session, RedirectAttributes rttr) {
		log.info("logout");
		String msg = "로그아웃 성공";
		session.removeAttribute("member");
		rttr.addFlashAttribute("msg", msg);
		System.out.println(msg);
		return "redirect:login";

	}

	// 회원 이력서 작성
	public String mysellWrite(List<MultipartFile> files, mysellDto myDto, HttpSession session,
			RedirectAttributes rttr) {

		log.info("mysellWrite()");
		String msg = null;
		String view = null;
		String upFile = files.get(0).getOriginalFilename();
		memberDto loging = (memberDto) session.getAttribute("member");
		String m_id = loging.getM_id(); 
		System.out.println(myDto);

		try {
			if (!upFile.equals("")) {
				myDto.setM_id(m_id);
				PicUpload(files, session, myDto);
			}
			sDao.mysellWrite(myDto);
			view = "redirect:mysell?pageNum=1";
			msg = "작성 성공";
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:mysellWrite";
			msg = "작성 실패";
		}

		rttr.addFlashAttribute("msg", msg);
		return view;
	}

	// 파일 업로드
	private void PicUpload(List<MultipartFile> files, HttpSession session, mysellDto myDto) throws Exception {
		log.info("fileUpload()");

		String sysname = null;
		String oriname = null;

		String realPath = session.getServletContext().getRealPath("/");
		log.info(realPath);
		realPath += "resources/upload/";
		File folder = new File(realPath);
		// isDirectory() : 해당 이름이 폴더가 아니거나 존재하지 않으면 false
		if (folder.isDirectory() == false) {
			folder.mkdir();// 폴더 생성 메소드
		}

		MultipartFile mf = files.get(0);
		oriname = mf.getOriginalFilename();

		sysname = System.currentTimeMillis() + oriname.substring(oriname.lastIndexOf("."));

		File file = new File(realPath + sysname);

		mf.transferTo(file);// 하드디스크(경로상의 폴더)에 저장
		myDto.setS_sysname(sysname);
	}

// 이력서 상세보기
	public void getDetail(Integer s_id, Model model) {
		log.info("getDetail()");
		
		mysellDto myDto = sDao.getDetail(s_id);
	
		model.addAttribute("myDto", myDto);
		log.info("myDto: " + myDto);
	}

// 이력서 수정
	public String mysellUpdate(List<MultipartFile> files,mysellDto myDto, HttpSession session,
			RedirectAttributes rttr) {
		log.info("mysellUpdate()");
		String msg = null;
		String view = null;
		String poto = myDto.getS_sysname();

		try {
			if (!files.get(0).isEmpty()) {
				PicUpload(files, session, myDto);

				if (poto != null) {
					fileDelete(poto, session);
				}

			}
			sDao.updateMysell(myDto);
			view = "redirect:mysellDetail?s_name=" + myDto.getS_name();
			msg = "수정 성공";
		} catch (Exception e) {
			e.printStackTrace();
			view = "redirect:updateFrm?s_name=" + myDto.getS_name();
			msg = "수정 실패";
		}
		log.info("myDto: " + myDto);
		rttr.addFlashAttribute("msg", msg);

		return view;
	}

	// 이력서 삭제
	
	
	public String mysellDelete(Integer m_id, HttpSession session, RedirectAttributes rttr) {
		log.info("mysellDelete()");
		String msg = null;
		String view = null;
		mysellDto myDto = sDao.mysellDelete(m_id);
		String picture = myDto.getS_sysname();
		
		try {
			if(picture != null) {
				fileDelete(picture, session);
			}
			sDao.mysellDelete(m_id);
			
			view = "redirect:mysell?pageNum=1";
			msg = "삭제성공";
		}catch (Exception e) {
			e.printStackTrace();
			view = "redirect:mysellDetail?pageNum=1";
			msg = "삭제실패";
		}
		
		rttr.addFlashAttribute("msg",msg);
		return view;
	}

	public String getmysellList(Integer pageNum, Model model, HttpSession session) {
		log.info("applyContact()");

		if (pageNum == null) {
			pageNum = 1; // 처음에 페이지가 열릴때 첫 페이지가 되도록 설정
		}

		int listCnt = 5; // 페이지당 보여질 콘텐츠 개수

		Map<String, Integer> pMap = new HashMap<String, Integer>();
		pMap.put("pageNum", (pageNum - 1) * listCnt);
		pMap.put("listCnt", listCnt);

		List<mysellDto> mList = sDao.getmysellList(pMap);

		model.addAttribute("mList", mList);

		// 페이징 처리

		String pageHtml = getPaging(pageNum, listCnt);
		model.addAttribute("paging", pageHtml);

		session.setAttribute("paging", pageNum);

		return "mysellList";
	}

	public String getapply(applyDto apply , Model model, HttpSession session) {
		
		
		return null;
	}


}
